import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:funenc_flutter_template/config/global.dart';
// import 'package:funenc_flutter_template/models/role.dart';
import 'package:funenc_flutter_template/model/role.dart';
import 'package:funenc_flutter_template/repositories/roleRepository.dart';
import 'package:getwidget/getwidget.dart';

class CreateRolePage extends StatefulWidget {
  const CreateRolePage({super.key});

  @override
  State<CreateRolePage> createState() => _CreateRolePageState();
}

class _CreateRolePageState extends State<CreateRolePage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('添加角色')),
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
                              return '角色名称不能为空';
                            }
                            return null;
                          },
                        ),
                      ),
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
                        var role = Role(name);
                        // var res = await RoleRepository().createOrUpdate(role);
                        var res = await Global.database.roleDao.insertItem(role);
                        print("666$res");
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
