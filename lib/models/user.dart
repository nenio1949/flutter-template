import 'package:isar/isar.dart';
import '../enum/index.dart';
import 'department.dart';
import 'role.dart';
import 'base.dart';

part 'user.g.dart';

/// 用户model
@collection
class User extends BaseModel {
  /// 姓名
  late String name;

  /// 头像
  String? avatar;

  /// 性别
  @enumerated
  GenderEnum gender = GenderEnum.unknown;

  /// 账号
  late String account;

  /// 密码
  late String password;

  /// 手机号
  late String mobile;

  /// 邮箱
  String? email;

  /// 部门
  final department = IsarLink<Department>();

  /// 角色
  final role = IsarLink<Role>();

  User();
}
