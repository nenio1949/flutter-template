import 'user.dart';
import 'package:floor/floor.dart';
import 'base.dart';

/// 部门model
@Entity(primaryKeys: [
  'id'
], foreignKeys: [
  ForeignKey(
      childColumns: ['parentId'], parentColumns: ['id'], entity: Department),
  ForeignKey(childColumns: ['leaderId'], parentColumns: ['id'], entity: User),
  // ForeignKey(
  //     childColumns: ['creatorId', 'modifierId'],
  //     parentColumns: ['id'],
  //     entity: User),
])
class Department extends BaseModel {
  /// 部门名称
  final String name;

  /// 父级部门
  @ColumnInfo(name: 'parentId')
  final int? parentId;

  /// 部门领导
  @ColumnInfo(name: 'leaderId')
  final int? leaderId;

  Department(this.name,
      {this.parentId,
      this.leaderId,
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
