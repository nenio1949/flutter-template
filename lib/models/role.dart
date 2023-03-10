import 'package:funenc_flutter_template/models/user.dart';
import 'package:isar/isar.dart';
import 'base.dart';

part 'role.g.dart';

/// 角色model
@collection
class Role extends BaseModel {
  /// 角色名称
  late String name;

  /// 权限
  String? permissions;

  Role();
}
