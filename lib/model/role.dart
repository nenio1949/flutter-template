import 'user.dart';
import 'package:floor/floor.dart';
import 'base.dart';

/// 角色model
@Entity(primaryKeys: [
  'id'
], foreignKeys: [
  // ForeignKey(
  //     childColumns: ['creatorId', 'modifierId'],
  //     parentColumns: ['id'],
  //     entity: User)
])
class Role extends BaseModel {
  /// 角色名称
  final String name;

  /// 权限
  final String? permissions;

  Role(this.name,
      {this.permissions,
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
