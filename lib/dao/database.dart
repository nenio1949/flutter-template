import 'dart:async';
import 'package:floor/floor.dart';
import 'package:funenc_flutter_template/dao/departmentDao.dart';
import 'package:funenc_flutter_template/dao/roleDao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../enum/index.dart';
import '../model/department.dart';
import '../model/role.dart';
import './userDao.dart';
import '../model/user.dart';

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [User, Role, Department])
abstract class AppDatabase extends FloorDatabase {
  UserDao get userDao;

  RoleDao get roleDao;

  DepartmentDao get departmentDao;
}
