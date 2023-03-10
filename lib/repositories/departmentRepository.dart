import 'dart:async';

import 'package:funenc_flutter_template/config/global.dart';
import 'package:isar/isar.dart';

import '../models/department.dart';

/// 部门repository
class DepartmentRepository {
  /// 获取部门分页列表
  Future<List<Department>> getPageList(
      {String? name, int page = 1, int size = 20}) async {
    return await Global.isar.departments
        .where(sort: Sort.desc)
        .filter()
        .optional(name != null && name != "", (q) => q.nameContains(name!))
        .deletedEqualTo(false)
        .offset(size * (page - 1))
        .limit(size)
        .findAll();
  }

  /// 获取所有部门列表
  Future<List<Department>> getAllList(
      {String? name}) async {
    return await Global.isar.departments
        .where(sort: Sort.desc)
        .filter()
        .optional(name != null && name != "", (q) => q.nameContains(name!))
        .deletedEqualTo(false)
        .findAll();
  }

  /// 根据id获取部门
  Future<Department?> getById(int id) async {
    return await Global.isar.departments
        .filter()
        .idEqualTo(id)
        .deletedEqualTo(false)
        .findFirst();
  }

  /// 创建/更新部门
  Future<int> createOrUpdate(Department department) async {
    int res = 0;
    await Global.isar.writeTxn(() async {
      res = await Global.isar.departments.put(department);

      /// 手动保存关联
      await department.leader.save();
      await department.parentDepartment.save();
    });
    return res;
  }

  /// 删除部门
  Future<int> delete(List<int> ids, {bool? isForced = false}) async {
    int res = 0;
    List<Department> userList = <Department>[];
    if (isForced != null && isForced) {
      /// 强制物理删除
      await Global.isar.writeTxn(() async {
        res = await Global.isar.departments.deleteAll(ids);
      });
    } else {
      final list = await Global.isar.departments.getAll(ids);

      for (var user in list) {
        if (user != null) {
          userList.add(user);
          user.deleted = true;
        }
      }

      await Global.isar.writeTxn(() async {
        res = (await Global.isar.departments.putAll(userList)).length;
      });
    }
    return res;
  }
}
