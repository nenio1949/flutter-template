import 'package:flutter/material.dart';
import 'package:funenc_flutter_template/components/empty.dart';
import 'package:funenc_flutter_template/components/popMenu.dart';
import 'package:funenc_flutter_template/models/role.dart';
import 'package:funenc_flutter_template/repositories/roleRepository.dart';
import 'package:getwidget/getwidget.dart';

class RolePage extends StatefulWidget {
  const RolePage({super.key});

  @override
  State<RolePage> createState() => _RolePageState();
}

class _RolePageState extends State<RolePage> {
  List<int> deleteIds = [];

  List<Role> roles = [];
  bool isMultiSelect = false;

  @override
  void initState() {
    super.initState();
    getRolePageList();
  }

  /// 获取角色分页数据
  Future<void> getRolePageList() async {
    var list = await RoleRepository().getPageList();
    setState(() {
      roles = list;
    });
  }

  /// 删除角色
  Future<void> deleteRoles(List<int> ids) async {
    await RoleRepository().delete(ids, isForced: true);
  }

  @override
  Widget build(BuildContext context) {
    final List<PopMenuItem> items = [];
    items.add(
      PopMenuItem(
        text: '删除',
        onTap: () async {
          await deleteRoles(deleteIds);
          await getRolePageList();
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
      appBar: AppBar(title: const Text('角色管理')),
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
                                  await deleteRoles(deleteIds);
                                  await getRolePageList();
                                },
                                text: "删除",
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
                      Navigator.pushNamed(context, '/createRole').then(
                          (value) => value != null ? getRolePageList() : null);
                    },
                    text: "新增角色",
                  ),
                ],
              )),
          Expanded(
              child: roles.isNotEmpty
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
                                        ? GFCheckbox(
                                            size: GFSize.SMALL,
                                            onChanged: (value) {
                                              if (deleteIds.any((user) =>
                                                  user == roles[index].id)) {
                                                setState(() {
                                                  deleteIds.removeWhere(
                                                      (element) =>
                                                          element ==
                                                          roles[index].id);
                                                });
                                              } else {
                                                setState(() {
                                                  deleteIds
                                                      .add(roles[index].id);
                                                });
                                              }
                                            },
                                            value: deleteIds.any(
                                                (id) => id == roles[index].id))
                                        : const SizedBox.shrink(),
                                    Expanded(
                                      child: ListTile(
                                        title: Text(roles[index].name),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      child: InkWell(
                                          child: const Icon(Icons.edit),
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "/updateRole",
                                                arguments: {
                                                  "id": roles[index].id
                                                }).then((value) => value != null
                                                ? getRolePageList()
                                                : null);
                                          }),
                                    )
                                  ],
                                ),
                                onLongPressStart: (details) async {
                                  if (items.isNotEmpty) {
                                    deleteIds = [roles[index].id];
                                    await PopMenuUtil.showPopupMenu(
                                        context, details, items);
                                  }
                                }));
                      },
                      itemCount: roles.length,
                    )
                  : const Empty())
        ],
      ),
    );
  }
}
