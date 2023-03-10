import 'package:funenc_flutter_template/dao/database.dart';
import 'package:funenc_flutter_template/models/department.dart';
import 'package:funenc_flutter_template/models/role.dart';
import 'package:funenc_flutter_template/models/user.dart';
import 'package:isar/isar.dart';

class Global {
  static late Isar isar;

  static late AppDatabase database;

  static Future init() async {
    /// 初始化数据库
    isar = await Isar.open(
      [UserSchema, RoleSchema, DepartmentSchema],
    );

    database = await $FloorAppDatabase
        .databaseBuilder('funenc_flutter_template.db')
        .build();
  }
}
