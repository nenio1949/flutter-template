# flutter_demo

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 初始化
flutter pub get


## 数据库ORM isar（实体：models文件夹下，数据操作：repositories文件夹）
生成实体：flutter pub run build_runner build --delete-conflicting-outputs

## 数据库ORM floor（实体：model文件夹下，数据操作：dao文件夹下）
生成dao：flutter packages pub run build_runner build

## mobx状态管理
更新stores下的文件时需要执行`flutter packages pub run build_runner watch`以生成g.dart文件。

## 缓存shared_preferences
对于json对象需要先encode转成String再存储，获取时再decode；
Key：
_USER_INFO：用户信息

## 安卓生成签名文件
秘钥生成命令：`keytool -genkey -v -keystore funenc-flutter-template.jks -keyalg RSA -keysize 2048 -validity 36500 -alias funenc-flutter-template`
```sh
输入密钥库口令: funenc
再次输入新口令: funenc
您的名字与姓氏是什么?
  [Unknown]:  funenc
您的组织单位名称是什么?
  [Unknown]:  funenc
您的组织名称是什么?
  [Unknown]:  funenc
您所在的城市或区域名称是什么?
  [Unknown]:  beijing
您所在的省/市/自治区名称是什么?
  [Unknown]:  beijing
该单位的双字母国家/地区代码是什么?
  [Unknown]:  cn   
CN=easywork, OU=tct, O=tct, L=beijing, ST=beijing, C=cn是否正确?
```

