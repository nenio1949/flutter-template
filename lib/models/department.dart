import 'user.dart';
import 'package:isar/isar.dart';
import 'base.dart';

part 'department.g.dart';

/// 部门model
@collection
class Department extends BaseModel {
  /// 部门名称
  late String name;

  /// 父级部门
  final parentDepartment= IsarLink<Department>();

  /// 部门领导
  final leader = IsarLink<User>();



  Department();
}
