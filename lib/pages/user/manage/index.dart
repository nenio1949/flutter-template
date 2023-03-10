import 'package:flutter/material.dart';
import 'package:funenc_flutter_template/components/empty.dart';
import 'package:funenc_flutter_template/components/popMenu.dart';
import 'package:funenc_flutter_template/config/global.dart';
import 'package:funenc_flutter_template/models/user.dart';
import 'package:funenc_flutter_template/repositories/userRepository.dart';
import 'package:getwidget/getwidget.dart';

class UserManagePage extends StatefulWidget {
  const UserManagePage({super.key});

  @override
  State<UserManagePage> createState() => _UserManagePageState();
}

class _UserManagePageState extends State<UserManagePage> {
  List<int> deleteIds = [];

  List<User> users = [];
  bool isMultiSelect = false;

  @override
  void initState() {
    super.initState();
    getUserPageList();
  }

  /// 获取用户分页数据
  Future<void> getUserPageList() async {
    var list = await UserRepository().getPageList();
    var list2= await Global.database.userDao.findAllUsers();
    print("2333$list2");
    setState(() {
      users = list;
    });
  }

  /// 删除用户
  Future<void> deleteUsers(List<int> ids) async {
    await UserRepository().delete(ids, isForced: true);
  }

  @override
  Widget build(BuildContext context) {
    final List<PopMenuItem> items = [];
    items.add(
      PopMenuItem(
        text: '删除',
        onTap: () async {
          await deleteUsers(deleteIds);
          await getUserPageList();
        },
      ),
    );
    items.add(
      PopMenuItem(
        text: '多选',
        onTap: () {
          setState(() {
            isMultiSelect = true;
          });
        },
      ),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('用户管理')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
              alignment: const Alignment(-1, 1),
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  isMultiSelect
                      ? Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GFButton(
                                size: GFSize.SMALL,
                                color: GFColors.DANGER,
                                onPressed: () async {
                                  await deleteUsers(deleteIds);
                                  await getUserPageList();
                                },
                                text: "删除",
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: GFButton(
                                size: GFSize.SMALL,
                                color: GFColors.DANGER,
                                onPressed: () async {
                                  await Global.database.database.execute("DROP TABLE IF EXISTS Role;");
                                  await Global.database.database.execute("DROP TABLE IF EXISTS Department;");
                                  await Global.database.database.execute("DROP TABLE IF EXISTS User;");
                                 print("777");
                                },
                                text: "删除数据库",
                              ),
                            ),
                            GFButton(
                              size: GFSize.SMALL,
                              type: GFButtonType.outline,
                              color: GFColors.TRANSPARENT,
                              onPressed: () {
                                setState(() {
                                  isMultiSelect = false;
                                });
                              },
                              text: "取消",
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                  GFButton(
                    size: GFSize.SMALL,
                    onPressed: () {
                      Navigator.pushNamed(context, '/createUser').then(
                          (value) => value != null ? getUserPageList() : null);
                    },
                    text: "新增用户",
                  ),
                ],
              )),
          Expanded(
              child: users.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                border: Border(
                                    bottom:
                                        BorderSide(color: Color(0xFFEEEEEE)))),
                            child: GestureDetector(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    isMultiSelect
                                        ? Checkbox(
                                            onChanged: (value) {
                                              if (deleteIds.any((user) =>
                                                  user == users[index].id)) {
                                                setState(() {
                                                  deleteIds.removeWhere(
                                                      (element) =>
                                                          element ==
                                                          users[index].id);
                                                });
                                              } else {
                                                setState(() {
                                                  deleteIds
                                                      .add(users[index].id);
                                                });
                                              }
                                            },
                                            value: deleteIds.any(
                                                (id) => id == users[index].id))
                                        : const SizedBox.shrink(),
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                            "${users[index].name}    ${users[index].role.value != null ? users[index].role.value?.name : ""}"),
                                        subtitle: Text(
                                            "账号:${users[index].account}, 手机号:${users[index].mobile}"),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      child: InkWell(
                                          child: const Icon(Icons.edit),
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "/updateUser",
                                                arguments: {
                                                  "id": users[index].id
                                                }).then((value) => value != null
                                                ? getUserPageList()
                                                : null);
                                          }),
                                    )
                                  ],
                                ),
                                onLongPressStart: (details) async {
                                  if (items.isNotEmpty) {
                                    deleteIds = [users[index].id];
                                    await PopMenuUtil.showPopupMenu(
                                        context, details, items);
                                  }
                                }));
                      },
                      itemCount: users.length,
                    )
                  : const Empty())
        ],
      ),
    );
  }
}
