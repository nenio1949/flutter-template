import 'package:flutter/material.dart';
import 'package:funenc_flutter_template/pages/common/login.dart';
import 'package:funenc_flutter_template/pages/home/index.dart';
import 'package:funenc_flutter_template/pages/message/index.dart';
import 'package:funenc_flutter_template/pages/user/index.dart';
import 'package:funenc_flutter_template/utils/localStorage.dart';
import 'package:getwidget/getwidget.dart';

class TabNavigator extends StatefulWidget {
  final dynamic arguments;

  const TabNavigator({super.key, this.arguments});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>
    with SingleTickerProviderStateMixin {
  // int selectedPage = 0;
  // final pageArr = [const HomePage(), const MessagePage(), const UserPage()];
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(
        initialIndex: widget.arguments?["tabIndex"] ?? 0,
        length: 3,
        vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    // final AppStore appStore = AppStore();
    // if (appStore.userInfo == null) {
    //   Navigator.pushNamed(context, '/login');
    // }
    final userInfo = LocalStorage.get("_USER_INFO");
    if (userInfo == null) {
      return const LoginPage();
    } else {
      return Scaffold(
        // appBar: AppBar(
        //   // Here we take the value from the TabNavigator object that was created by
        //   // the App.build method, and use it to set our appbar title.
        //   title: const Text('flutter 模板'),
        // ),
        body: GFTabBarView(
          controller: tabController,
          children: const [HomePage(), MessagePage(), UserPage()],
        ),
        bottomNavigationBar: GFTabBar(
          length: 3,
          controller: tabController,
          tabBarColor: GFColors.WHITE,
          labelColor: GFColors.PRIMARY,
          unselectedLabelColor: GFColors.DARK,
          indicatorColor: GFColors.WHITE,
          tabs: const [
            Tab(
              icon: Icon(Icons.home),
              child: Text("首页"),
            ),
            Tab(
              icon: Icon(Icons.message),
              child: Text("消息"),
            ),
            Tab(
              icon: Icon(Icons.person),
              child: Text("我的"),
            ),
          ],
        ),
      );
    }
  }
}
