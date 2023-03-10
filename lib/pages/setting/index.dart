import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:funenc_flutter_template/utils/cache.dart';

class SettingPage extends StatefulWidget {
  final dynamic arguments;

  const SettingPage({super.key, this.arguments});

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String cacheSize = "";

  @override
  void initState() {
    super.initState();
    getCacheSize();
  }

  /// 获取缓存大小
  Future<void> getCacheSize() async {
    int size = await CacheUtil.total();
    String sizeText = "";
    if (size == 0) {
      sizeText = "暂无缓存";
    } else if (size > 0 && size < pow(1024, 1)) {
      sizeText = '${size}B';
    } else if (size >= 1024 && size < pow(1024, 2)) {
      sizeText = '${(size / 1024).toStringAsFixed(2)}KB';
    } else if (size >= pow(1024, 2) && size < pow(1024, 3)) {
      sizeText = '${(size / pow(1024, 2)).toStringAsFixed(2)}MB';
    } else {
      sizeText = '${(size / pow(1024, 3)).toStringAsFixed(2)}GB';
    }

    /// 复制变量
    setState(() {
      cacheSize = sizeText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('设置'),
      ),
      body: Column(
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE)))),
            child: InkWell(
              child: ListTile(
                title: const Text("清除缓存"),
                subtitle: Text(cacheSize),
                trailing:
                    const Icon(Icons.cleaning_services_outlined, size: 20),
              ),
              onTap: () async {
                if (cacheSize == "暂无缓存") {
                  EasyLoading.showError("暂无可清理缓存！");
                } else {
                  EasyLoading.show(
                      status: '清理中...', maskType: EasyLoadingMaskType.black);
                  await CacheUtil.clear();

                  const timeout = Duration(seconds: 2);
                  Timer(timeout, () {
                    EasyLoading.dismiss();
                    setState(() {
                      cacheSize = "暂无缓存";
                    });
                  });
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

_tabList() {
  var listArr = [
    {'title': '清除缓存', 'icon': '0xf04f6', 'path': '/user'},
  ];

  return Container(
    height: 200,
    margin: const EdgeInsets.only(top: 10),
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
              // leading: Icon(
              //   IconData(int.parse('${listArr[index]['icon']}'),
              //       fontFamily: 'MaterialIcons'),
              //   size: 30,
              // ),
              title: Text(listArr[index]['title'].toString()),
              trailing: const Icon(Icons.cleaning_services_outlined, size: 20),
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
