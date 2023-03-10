import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:funenc_flutter_template/models/department.dart';
import 'package:funenc_flutter_template/models/user.dart';
import 'package:funenc_flutter_template/repositories/departmentRepository.dart';
import 'package:funenc_flutter_template/repositories/userRepository.dart';
import 'package:getwidget/getwidget.dart';

class CreateDepartmentPage extends StatefulWidget {
  const CreateDepartmentPage({super.key});

  @override
  State<CreateDepartmentPage> createState() => _CreateDepartmentPageState();
}

class _CreateDepartmentPageState extends State<CreateDepartmentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  Department? selectedParentDeparment;
  List<Department> _departments = [];
  User? selectedLeader;
  List<User> _users = [];
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    getAllUsers();
    getAllDepartments();
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
        appBar: AppBar(title: const Text('添加部门')),
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
                                      _departments.isNotEmpty
                                          ? Pickers.showSinglePicker(
                                              context,
                                              data: _departments
                                                  .map((e) => e.name)
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
                        var department = Department()
                          ..name = name
                          ..leader.value = selectedLeader
                          ..parentDepartment.value = selectedParentDeparment;
                        var res = await DepartmentRepository()
                            .createOrUpdate(department);
                        if (res != 0) {
                          EasyLoading.showSuccess("添加成功");
                          if (mounted) {
                            Navigator.of(context).pop(true);
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
