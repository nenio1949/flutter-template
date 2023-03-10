import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

// class UserInfoPage extends StatefulWidget {
//   final int? tabIndex;
//
//   const UserInfoPage({super.key, this.tabIndex});
//
//   @override
//   State<UserInfoPage> createState() => _UserInfoPageState();
// }

class UserInfoPage extends StatelessWidget {
  final dynamic arguments;

  const UserInfoPage({super.key, this.arguments});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人信息'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text("个人信息"),
            GFButton(
              onPressed: () {
                Navigator.pushNamed(context, "/", arguments: {"tabIndex": 1});
              },
              child: const Text("跳转消息"),
            )
          ],
        ),
      ),
    );
  }
}
