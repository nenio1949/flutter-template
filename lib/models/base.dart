import 'package:funenc_flutter_template/models/user.dart';
import 'package:isar/isar.dart';

class BaseModel {
  /// 主键
  Id id = Isar.autoIncrement;

  /// 创建人
  final creator = IsarLink<User>();

  /// 修改人
  final modifier = IsarLink<User>();

  /// 创建时间
  DateTime createdAt = DateTime.now();

  /// 更新时间
  DateTime updatedAt = DateTime.now();

  /// 是否逻辑删除
  late bool deleted = false;
}
