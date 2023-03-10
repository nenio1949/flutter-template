import 'package:flutter/material.dart';
import 'package:funenc_flutter_template/stores/appStore.dart';
import 'package:funenc_flutter_template/utils/localStorage.dart';
import 'package:funenc_flutter_template/utils/photoPreview.dart';
import 'package:getwidget/getwidget.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final AppStore appStore = AppStore();
    final dynamic userInfo = appStore.userInfo;

    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
        leading: const Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            children: [
              Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => PhotoPreview(
                                    galleryItems: ["${userInfo["avatar"]}"],
                                    defaultImage: 0,
                                  )));
                    },
                    child: GFImageOverlay(
                      image: NetworkImage("${userInfo["avatar"]}"),
                      width: 100,
                      height: 100,
                      shape: BoxShape.circle,
                      boxFit: BoxFit.cover,
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text("${userInfo["name"]}"),
              )
            ],
          ),
          _userList(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: GFButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("提示"),
                        content: const Text("确定要退出吗?"),
                        actions: <Widget>[
                          GFButton(
                            onPressed: () => {Navigator.of(context).pop()},
                            type: GFButtonType.transparent,
                            child: const Text("取消"),
                          ),
                          GFButton(
                            onPressed: () async => {
                              /// 清除用户
                              appStore.reset(),
                              await LocalStorage.clear(),
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  "/login", ModalRoute.withName("/login")),

                              // Navigator.pushNamed(context, "/login"),
                            },
                            type: GFButtonType.transparent,
                            child: const Text("确定"),
                          ),
                        ],
                      );
                    });
              },
              color: GFColors.DANGER,
              text: "退出登录",
              fullWidthButton: true,
            ),
          )
        ],
      ),
    );
  }
}

_userList() {
  var listArr = [
    {'title': '修改资料', 'icon': '0xf04f6', 'path': '/userInfo'},
    {'title': '用户管理', 'icon': '0xe492', 'path': '/userManage'},
    {'title': '角色管理', 'icon': '0xf27d', 'path': '/role'},
    {'title': '部门管理', 'icon': '0xe392', 'path': '/department'},
    {'title': '设置', 'icon': '0xe57f', 'path': '/setting'},
  ];

  return Container(
    height: 300,
    margin: const EdgeInsets.only(top: 50),
    decoration: const BoxDecoration(color: Colors.white),
    child: ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE)))),
          child: InkWell(
            child: ListTile(
              leading: Icon(
                IconData(int.parse('${listArr[index]['icon']}'),
                    fontFamily: 'MaterialIcons'),
                size: 30,
              ),
              title: Container(
                transform: Matrix4.translationValues(-20, 0.0, 0.0),
                child: Text(listArr[index]['title'].toString()),
              ),
              trailing: const Icon(Icons.keyboard_arrow_right, size: 30),
            ),
            onTap: () {
              Navigator.pushNamed(context, '${listArr[index]['path']}');
            },
          ),
        );
      },
      itemCount: listArr.length,
    ),
  );
}
