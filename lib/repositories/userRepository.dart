import 'dart:async';

import 'package:funenc_flutter_template/config/global.dart';
import 'package:funenc_flutter_template/models/user.dart';
import 'package:isar/isar.dart';

/// 用户repository
class UserRepository {
  /// 获取用户分页列表
  Future<List<User>> getPageList(
      {String? name, int page = 1, int size = 20}) async {
    return await Global.isar.users
        .where(sort: Sort.desc)
        .filter()
        .optional(name != null && name != "", (q) => q.nameContains(name!))
        .deletedEqualTo(false)
        .offset(size * (page - 1))
        .limit(size)
        .findAll();
  }

  /// 获取所有用户列表
  Future<List<User>> getAllList(
      {String? name}) async {
    return await Global.isar.users
        .where(sort: Sort.desc)
        .filter()
        .optional(name != null && name != "", (q) => q.nameContains(name!))
        .deletedEqualTo(false)
        .findAll();
  }

  /// 根据id获取用户
  Future<User?> getById(int id) async {
    return await Global.isar.users
        .filter()
        .idEqualTo(id)
        .deletedEqualTo(false)
        .findFirst();
  }

  /// 创建/更新用户
  Future<int> createOrUpdate(User user) async {
    int res = 0;
    await Global.isar.writeTxn(() async {
      res = await Global.isar.users.put(user);

      /// 手动保存关联
      await user.role.save();
      await user.department.save();
    });
    return res;
  }

  /// 删除用户
  Future<int> delete(List<int> ids, {bool? isForced = false}) async {
    int res = 0;
    List<User> userList = <User>[];
    if (isForced != null && isForced) {
      /// 强制物理删除
      await Global.isar.writeTxn(() async {
        res = await Global.isar.users.deleteAll(ids);
      });
    } else {
      final list = await Global.isar.users.getAll(ids);

      for (var user in list) {
        if (user != null) {
          userList.add(user);
          user.deleted = true;
        }
      }

      await Global.isar.writeTxn(() async {
        res = (await Global.isar.users.putAll(userList)).length;
      });
    }
    return res;
  }
}
