import 'package:floor/floor.dart';

class BaseModel {
  /// 主键
  @PrimaryKey(autoGenerate: true)
  final int? id;

  /// 创建人
  @ColumnInfo(name: 'creatorId')
  final int? creatorId;

  /// 修改人
  @ColumnInfo(name: 'modifierId')
  final int? modifierId;

  /// 创建时间
  final String? createdAt;

  /// 更新时间
  final String? updatedAt;

  /// 是否逻辑删除
  final bool? deleted;

  BaseModel(this.id, this.creatorId, this.modifierId, this.createdAt,
      this.updatedAt, this.deleted);

  List<Object> get props => [];
}
