import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:funenc_flutter_template/request/api.dart';
import 'package:funenc_flutter_template/stores/appStore.dart';
import 'package:funenc_flutter_template/utils/localStorage.dart';
import 'package:getwidget/getwidget.dart';
import 'package:package_info/package_info.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isShowPassword = false;
  late final String version;

  Future<void> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('登录'),
        leading: const Text(''),
      ),
      body: Center(
          child: Form(
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
                      controller: _accountController,
                      restorationId: 'account',
                      textInputAction: TextInputAction.next,
                      textCapitalization: TextCapitalization.words,
                      decoration: InputDecoration(
                          filled: true,
                          icon: const Icon(Icons.person),
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
                      },
                    ),
                  ),
                  TextFormField(
                      controller: _passwordController,
                      restorationId: 'password',
                      obscureText: !isShowPassword,
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
                                setState(() {
                                  isShowPassword =
                                      isShowPassword ? false : true;
                                });
                              },
                              icon: Icon(isShowPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '密码不能为空';
                        }
                        return null;
                      })
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: GFButton(
                text: "登录",
                fullWidthButton: true,
                onPressed: () async {
                  if (_formKey.currentState?.validate() != true) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  } else {
                    String account = _accountController.text;
                    String password = _passwordController.text;
                    var res = await ApiService()
                        .login({"login": account, "password": password});
                    if (res["errcode"] == 0) {
                      final AppStore appStore = AppStore();
                      if (!mounted) return;
                      appStore.updateUserInfo(res);
                      LocalStorage.save("_USER_INFO", jsonEncode(res["data"]));
                      Navigator.pushNamed(context, "/");
                    }
                  }
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
