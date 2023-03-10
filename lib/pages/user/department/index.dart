import 'package:flutter/material.dart';
import 'package:funenc_flutter_template/components/empty.dart';
import 'package:funenc_flutter_template/components/popMenu.dart';
import 'package:funenc_flutter_template/models/department.dart';
import 'package:funenc_flutter_template/repositories/departmentRepository.dart';
import 'package:getwidget/getwidget.dart';

class DepartmentPage extends StatefulWidget {
  const DepartmentPage({super.key});

  @override
  State<DepartmentPage> createState() => _DepartmentPageState();
}

class _DepartmentPageState extends State<DepartmentPage> {
  List<int> deleteIds = [];

  List<Department> users = [];
  bool isMultiSelect = false;

  @override
  void initState() {
    super.initState();
    getDepartmentPageList();
  }

  /// 获取部门分页数据
  Future<void> getDepartmentPageList() async {
    var list = await DepartmentRepository().getPageList();
    setState(() {
      users = list;
    });
  }

  /// 删除部门
  Future<void> deleteDepartments(List<int> ids) async {
    await DepartmentRepository().delete(ids, isForced: true);
  }

  @override
  Widget build(BuildContext context) {
    final List<PopMenuItem> items = [];
    items.add(
      PopMenuItem(
        text: '删除',
        onTap: () async {
          await deleteDepartments(deleteIds);
          await getDepartmentPageList();
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
      appBar: AppBar(title: const Text('部门管理')),
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
                                  await deleteDepartments(deleteIds);
                                  await getDepartmentPageList();
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
                      Navigator.pushNamed(context, '/createDepartment').then(
                          (value) => value != null ? getDepartmentPageList() : null);
                    },
                    text: "新增部门",
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
                                        ? GFCheckbox(
                                            size: GFSize.SMALL,
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
                                        title: Text(users[index].name),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 50,
                                      child: InkWell(
                                          child: const Icon(Icons.edit),
                                          onTap: () {
                                            Navigator.pushNamed(
                                                context, "/updateDepartment",
                                                arguments: {
                                                  "id": users[index].id
                                                }).then((value) => value != null
                                                ? getDepartmentPageList()
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
