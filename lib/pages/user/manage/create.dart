import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:funenc_flutter_template/config/global.dart';
import 'package:funenc_flutter_template/models/role.dart';
// import 'package:funenc_flutter_template/models/user.dart';
import 'package:funenc_flutter_template/model/user.dart';

import 'package:funenc_flutter_template/repositories/roleRepository.dart';
import 'package:funenc_flutter_template/repositories/userRepository.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_pickers/pickers.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({super.key});

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  final _mobileController = TextEditingController();
  List<Role> _roles = [];
  Role? selectedRole;
  final FocusNode _focusNode = FocusNode();

  // final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAllRoles();
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
        appBar: AppBar(title: const Text('添加用户')),
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
                                        selectData: '',
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
                        var user = User(name,account,password,mobile);
                        //   ..name = name
                        //   ..account = account
                        //   ..password = password
                        //   ..mobile = mobile
                        //   ..role.value = selectedRole;
                        // var res = await UserRepository().createOrUpdate(user);
                        var res= await Global.database.userDao.insertItem(user);
                        print("555$res");
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
