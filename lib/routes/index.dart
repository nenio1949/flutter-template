import 'package:funenc_flutter_template/pages/common/login.dart';
import 'package:funenc_flutter_template/pages/index.dart';
import 'package:funenc_flutter_template/pages/message/index.dart';
import 'package:funenc_flutter_template/pages/setting/index.dart';
import 'package:funenc_flutter_template/pages/user/manage/create.dart';
import 'package:funenc_flutter_template/pages/user/manage/index.dart';
import 'package:funenc_flutter_template/pages/user/manage/update.dart';
import 'package:funenc_flutter_template/pages/user/role/create.dart';
import 'package:funenc_flutter_template/pages/user/role/index.dart';
import 'package:funenc_flutter_template/pages/user/role/update.dart';
import 'package:funenc_flutter_template/pages/user/department/create.dart';
import 'package:funenc_flutter_template/pages/user/department/index.dart';
import 'package:funenc_flutter_template/pages/user/department/update.dart';
import 'package:funenc_flutter_template/pages/user/userInfo.dart';

final routes = {
  "/": (context, {arguments}) => TabNavigator(arguments: arguments),
  '/login': (context, {arguments}) => const LoginPage(),
  '/userInfo': (context, {arguments}) => UserInfoPage(arguments: arguments),
  '/setting': (context, {arguments}) => SettingPage(arguments: arguments),
  '/message': (context, {arguments}) => const MessagePage(),
  '/userManage': (context, {arguments}) => const UserManagePage(),
  '/createUser': (context, {arguments}) => const CreateUserPage(),
  '/updateUser': (context, {arguments}) => UpdateUserPage(arguments: arguments),
  '/role': (context, {arguments}) => const RolePage(),
  '/createRole': (context, {arguments}) => const CreateRolePage(),
  '/updateRole': (context, {arguments}) => UpdateRolePage(arguments: arguments),
  '/department': (context, {arguments}) => const DepartmentPage(),
  '/createDepartment': (context, {arguments}) => const CreateDepartmentPage(),
  '/updateDepartment': (context, {arguments}) =>
      UpdateDepartmentPage(arguments: arguments),
};
