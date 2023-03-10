import 'dart:convert';

import 'package:funenc_flutter_template/utils/localStorage.dart';
import 'package:mobx/mobx.dart';

part 'appStore.g.dart';

class AppStore = _AppStore with _$AppStore;

final AppStore appStore = AppStore();

abstract class _AppStore with Store {
  /// 用户信息
  @observable
  var userInfo = LocalStorage.get("_USER_INFO") != null
      ? jsonDecode(LocalStorage.get("_USER_INFO"))
      : null;

  /// 重置数据
  @action
  void reset() {
    userInfo = null;
  }

  /// 更新用户信息
  @action
  void updateUserInfo(data) {
    userInfo = data;
  }
}
