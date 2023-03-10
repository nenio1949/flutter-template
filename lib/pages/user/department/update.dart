import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:funenc_flutter_template/models/department.dart';
import 'package:funenc_flutter_template/repositories/departmentRepository.dart';
import 'package:getwidget/getwidget.dart';

import 'package:funenc_flutter_template/models/user.dart';

import 'package:funenc_flutter_template/repositories/userRepository.dart';

class UpdateDepartmentPage extends StatefulWidget {
  final dynamic arguments;

  const UpdateDepartmentPage({super.key, this.arguments});

  @override
  State<UpdateDepartmentPage> createState() => _UpdateDepartmentPageState();
}

class _UpdateDepartmentPageState extends State<UpdateDepartmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Department? selectedParentDeparment;
  List<Department> _departments = [];
  User? selectedLeader;
  List<User> _users = [];
  Department? department;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getAllUsers();
    getAllDepartments();
    var departmentId = widget.arguments["id"];
    if (departmentId != null) {
      getDepartmentInfo(widget.arguments["id"]);
    } else {
      EasyLoading.showError("参数非法");
    }
  }

  /// 获取用户信息
  getDepartmentInfo(int id) async {
    var res = await DepartmentRepository().getById(id);
    if (res != null) {
      department = res;
      _nameController.text = department?.name ?? "";
      setState(() {
        selectedLeader = department?.leader?.value;
        selectedParentDeparment = department?.parentDepartment.value;
      });
    }
  }

  /// 获取所有人员
  getAllUsers() async {
    var list = await UserRepository().getAllList();
    setState(() {
      _users = list;
    });
  }

  /// 获取所有部门
  getAllDepartments() async {
    var list = await DepartmentRepository().getAllList();
    setState(() {
      _departments = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('更新部门')),
        body: SingleChildScrollView(
            child: Column(children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: TextFormField(
                          controller: _nameController,
                          restorationId: 'name',
                          focusNode: _focusNode,
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.characters,
                          maxLength: 10,
                          decoration: InputDecoration(
                              counterText: "",
                              filled: true,
                              icon: const Icon(Icons.person),
                              labelText: '名称',
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    if (!_focusNode.hasFocus) {
                                      _focusNode.canRequestFocus = false;
                                      Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                        _focusNode.canRequestFocus = true;
                                      });
                                    }
                                    _nameController.clear();
                                  },
                                  icon: const Icon(Icons.clear))),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '部门名称不能为空';
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                          height: 60,
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ListView(
                            children: [
                              SizedBox(
                                height: 50,
                                child: InkWell(
                                    child: ListTile(
                                      leading:
                                          const Icon(Icons.person_pin_outlined),
                                      title: Container(
                                        transform: Matrix4.translationValues(
                                            -20, 0.0, 0.0),
                                        child: Text(
                                            selectedParentDeparment?.name ??
                                                "请选择上级部门"),
                                      ),
                                      trailing: const Icon(
                                          Icons.keyboard_arrow_right,
                                          size: 30),
                                    ),
                                    onTap: () {
                                      _departments
                                              .map((e) => e.name)
                                              .where((element) =>
                                                  element !=
                                                  _nameController.text)
                                              .toList()
                                              .isNotEmpty
                                          ? Pickers.showSinglePicker(
                                              context,
                                              data: _departments
                                                  .map((e) => e.name)
                                                  .where((element) =>
                                                      element !=
                                                      _nameController.text)
                                                  .toList(),
                                              selectData:
                                                  selectedParentDeparment
                                                          ?.name ??
                                                      '',
                                              onConfirm: (p, position) {
                                                setState(() {
                                                  selectedParentDeparment =
                                                      _departments.firstWhere(
                                                          (role) =>
                                                              role.name == p);
                                                });
                                              },
                                            )
                                          : EasyLoading.showInfo("暂无部门可选！");
                                    }),
                              )
                            ],
                          )),
                      Container(
                          height: 60,
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ListView(
                            children: [
                              SizedBox(
                                height: 50,
                                child: InkWell(
                                    child: ListTile(
                                      leading:
                                          const Icon(Icons.person_pin_outlined),
                                      title: Container(
                                        transform: Matrix4.translationValues(
                                            -20, 0.0, 0.0),
                                        child: Text(
                                            selectedLeader?.name ?? "请选择部门负责人"),
                                      ),
                                      trailing: const Icon(
                                          Icons.keyboard_arrow_right,
                                          size: 30),
                                    ),
                                    onTap: () {
                                      _users.isNotEmpty
                                          ? Pickers.showSinglePicker(
                                              context,
                                              data: _users
                                                  .map((e) => e.name)
                                                  .toList(),
                                              selectData:
                                                  selectedLeader?.name ?? '',
                                              onConfirm: (p, position) {
                                                setState(() {
                                                  selectedLeader = _users
                                                      .firstWhere((role) =>
                                                          role.name == p);
                                                });
                                              },
                                            )
                                          : EasyLoading.showInfo("暂无人员可选");
                                    }),
                              )
                            ],
                          ))
                    ],
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                  child: GFButton(
                    text: "提交",
                    fullWidthButton: true,
                    onPressed: () async {
                      if (_formKey.currentState?.validate() != true) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Processing Data')),
                        );
                      } else {
                        String name = _nameController.text;
                        final department = this.department;
                        if (department != null) {
                          department.name = name;
                          department.leader.value = selectedLeader;
                          department.parentDepartment.value =
                              selectedParentDeparment;
                          department.updatedAt = DateTime.now();

                          if (department.id > 0) {
                            var res = await DepartmentRepository()
                                .createOrUpdate(department);
                            if (res != 0) {
                              EasyLoading.showSuccess("更新成功");
                              if (mounted) {
                                Navigator.of(context).pop(true);
                              }
                            }
                          }
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          )
        ])));
  }
}
