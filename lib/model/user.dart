import 'package:floor/floor.dart';
import 'package:funenc_flutter_template/enum/index.dart';
import 'department.dart';
import 'role.dart';
import 'base.dart';

/// 用户model
@Entity(primaryKeys: [
  'id'
], foreignKeys: [
  ForeignKey(
      childColumns: ['departmentId'],
      parentColumns: ['id'],
      entity: Department),
  ForeignKey(childColumns: ['roleId'], parentColumns: ['id'], entity: Role),
  // ForeignKey(
  //     childColumns: ['creatorId', 'modifierId'],
  //     parentColumns: ['id'],
  //     entity: User),
], indices: [
  Index(value: ['name', 'account', 'mobile'])
])
class User extends BaseModel {
  /// 姓名
  final String name;

  /// 头像
  @ColumnInfo(name: 'avatar')
  final String? avatar;

  /// 性别
  final GenderEnum? gender;

  /// 账号
  final String account;

  /// 密码
  final String password;

  /// 手机号
  final String mobile;

  /// 邮箱
  final String? email;

  /// 部门
  @ColumnInfo(name: 'departmentId')
  final int? departmentId;

  /// 角色
  @ColumnInfo(name: 'roleId')
  final int? roleId;

  User(this.name, this.account, this.password, this.mobile,
      {this.avatar,
      this.gender = GenderEnum.unknown,
      this.email,
      this.departmentId,
      this.roleId,
      int? id,
      int? creatorId,
      int? modifierId,
      String? createdAt,
      String? updatedAt,
      bool? deleted})
      : super(
            id,
            creatorId ?? 0,
            modifierId ?? 0,
            createdAt ?? DateTime.now().toString(),
            updatedAt ?? DateTime.now().toString(),
            deleted ?? false);
}
