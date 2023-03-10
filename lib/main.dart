import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:funenc_flutter_template/config/global.dart';
import 'package:funenc_flutter_template/pages/common/login.dart';
import 'package:funenc_flutter_template/pages/common/notFound.dart';
import 'package:funenc_flutter_template/routes/index.dart';
import 'package:funenc_flutter_template/utils/localStorage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 初始化本地缓存
  await LocalStorage.initSP();
  /// 全局变量初始化
  await Global.init().then((e) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Template',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      // routes: routes,
      // initialRoute: "/",
      // home: const MyHomePage(),

      builder: EasyLoading.init(),
      // home: const TabNavigator(),
      initialRoute: "/",
      onGenerateRoute: (RouteSettings settings) {
        final name = settings.name;

        Function pageContentBuilder =
            routes[name] ?? (content) => const NotFoundPage();

        // 用户权限认证的逻辑处理
        final userInfo = LocalStorage.get("_USER_INFO");
        if (userInfo == null) {
          pageContentBuilder = (content) => const LoginPage();
        }
        if (settings.arguments != null) {
          // 构建动态的route
          final Route route = MaterialPageRoute(
            builder: (context) =>
                pageContentBuilder(context, arguments: settings.arguments),
            settings: settings,
          );
          return route;
        } else {
          // 构建动态的route
          final Route route = MaterialPageRoute(
            builder: (context) => pageContentBuilder(context),
            settings: settings,
          );
          return route;
        }
      },
    );
  }
}

/// 实现路由守卫
// Route _routeGenerator(RouteSettings settings) {
//   final name = settings.name;
//   var builder = routes[name];
//   // 如果路由表中未定义，跳转到未定义路由页面
//   builder ??= (content) => const NotFoundPage();
//   // 用户权限认证的逻辑处理
//   final AppStore appStore = AppStore();
//   if (appStore.userInfo == null) {
//     Navigator.pushNamed(context, '/login');
//   }
//   // 构建动态的route
//   final route = MaterialPageRoute(
//     builder: builder,
//     settings: settings,
//   );
//   return route;
// }
