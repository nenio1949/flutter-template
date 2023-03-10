import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_pickers/pickers.dart';
import 'package:funenc_flutter_template/models/user.dart';
import 'package:funenc_flutter_template/repositories/userRepository.dart';
import 'package:getwidget/getwidget.dart';
import 'package:funenc_flutter_template/models/role.dart';

import 'package:funenc_flutter_template/repositories/roleRepository.dart';

class UpdateUserPage extends StatefulWidget {
  final dynamic arguments;

  const UpdateUserPage({super.key, this.arguments});

  @override
  State<UpdateUserPage> createState() => _UpdateUserPageState();
}

class _UpdateUserPageState extends State<UpdateUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();
  List<Role> _roles = [];
  Role? selectedRole;
  var user = User();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    var userId = widget.arguments["id"];
    getAllRoles();
    if (userId != null) {
      getUserInfo(widget.arguments["id"]);
    } else {
      EasyLoading.showError("参数非法");
    }
  }

  /// 获取用户信息
  getUserInfo(int id) async {
    var res = await UserRepository().getById(id);
    if (res != null) {
      user = res;
      _nameController.text = user.name;
      _accountController.text = user.account;
      _passwordController.text = user.password;
      _mobileController.text = user.mobile;
      selectedRole = user.role.value;
    }
  }

  /// 获取所有角色
  getAllRoles() async {
    var list = await RoleRepository().getAllList();
    setState(() {
      _roles = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('更新用户')),
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
                              labelText: '姓名',
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
                              return '姓名不能为空';
                            }
                            return null;
                          },
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                              controller: _accountController,
                              restorationId: 'account',
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              maxLength: 20,
                              decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  icon: const Icon(Icons.account_box_outlined),
                                  labelText: '账号',
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        _accountController.clear();
                                      },
                                      icon: const Icon(Icons.clear))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '账号不能为空';
                                }
                                return null;
                              })),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                              controller: _passwordController,
                              restorationId: 'password',
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              maxLength: 20,
                              decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  icon: const Icon(Icons.password),
                                  labelText: '密码',
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        _passwordController.clear();
                                      },
                                      icon: const Icon(Icons.clear))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '密码不能为空';
                                }
                                return null;
                              })),
                      Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: TextFormField(
                              controller: _mobileController,
                              restorationId: 'mobile',
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              maxLength: 11,
                              decoration: InputDecoration(
                                  counterText: "",
                                  filled: true,
                                  icon: const Icon(Icons.phone_android),
                                  labelText: '手机号',
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        _mobileController.clear();
                                      },
                                      icon: const Icon(Icons.clear))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '手机号不能为空';
                                }
                                return null;
                              })),
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
                                        child:
                                            Text(selectedRole?.name ?? "请选择角色"),
                                      ),
                                      trailing: const Icon(
                                          Icons.keyboard_arrow_right,
                                          size: 30),
                                    ),
                                    onTap: () {
                                      Pickers.showSinglePicker(
                                        context,
                                        data:
                                            _roles.map((e) => e.name).toList(),
                                        selectData: selectedRole?.name ?? '',
                                        onConfirm: (p, position) {
                                          setState(() {
                                            selectedRole = _roles.firstWhere(
                                                (role) => role.name == p);
                                          });
                                        },
                                      );
                                    }),
                              )
                            ],
                          )),
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
                        String account = _accountController.text;
                        String password = _passwordController.text;
                        String mobile = _mobileController.text;

                        user.name = name;
                        user.account = account;
                        user.password = password;
                        user.mobile = mobile;
                        user.role.value = selectedRole;
                        user.updatedAt = DateTime.now();
                        if (user.id > 0) {
                          var res = await UserRepository().createOrUpdate(user);
                          if (res != 0) {
                            EasyLoading.showSuccess("更新成功");
                            if (mounted) {
                              Navigator.of(context).pop(true);
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
