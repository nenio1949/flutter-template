import 'dart:async';

import 'package:funenc_flutter_template/config/global.dart';
import 'package:isar/isar.dart';

import '../models/role.dart';

/// 角色repository
class RoleRepository {
  /// 获取角色分页列表
  Future<List<Role>> getPageList(
      {String? name, int page = 1, int size = 20}) async {
    return await Global.isar.roles
        .where(sort: Sort.desc)
        .filter()
        .optional(name != null && name != "", (q) => q.nameContains(name!))
        .deletedEqualTo(false)
        .offset(size * (page - 1))
        .limit(size)
        .findAll();
  }

  /// 获取所有角色列表
  Future<List<Role>> getAllList({String? name}) async {
    return await Global.isar.roles
        .where(sort: Sort.desc)
        .filter()
        .optional(name != null && name != "", (q) => q.nameContains(name!))
        .deletedEqualTo(false)
        .findAll();
  }

  /// 根据id获取角色
  Future<Role?> getById(int id) async {
    return await Global.isar.roles
        .filter()
        .idEqualTo(id)
        .deletedEqualTo(false)
        .findFirst();
  }

  /// 创建/更新角色
  Future<int> createOrUpdate(Role role) async {
    int res = 0;
    await Global.isar.writeTxn(() async {
      res = await Global.isar.roles.put(role);
    });
    return res;
  }

  /// 删除角色
  Future<int> delete(List<int> ids, {bool? isForced = false}) async {
    int res = 0;
    List<Role> userList = <Role>[];
    if (isForced != null && isForced) {
      /// 强制物理删除
      await Global.isar.writeTxn(() async {
        res = await Global.isar.roles.deleteAll(ids);
      });
    } else {
      final list = await Global.isar.roles.getAll(ids);

      for (var user in list) {
        if (user != null) {
          userList.add(user);
          user.deleted = true;
        }
      }

      await Global.isar.writeTxn(() async {
        res = (await Global.isar.roles.putAll(userList)).length;
      });
    }
    return res;
  }
}
