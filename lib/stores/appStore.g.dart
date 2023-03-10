// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AppStore on _AppStore, Store {
  late final _$userInfoAtom =
      Atom(name: '_AppStore.userInfo', context: context);

  @override
  dynamic get userInfo {
    _$userInfoAtom.reportRead();
    return super.userInfo;
  }

  @override
  set userInfo(dynamic value) {
    _$userInfoAtom.reportWrite(value, super.userInfo, () {
      super.userInfo = value;
    });
  }

  late final _$_AppStoreActionController =
      ActionController(name: '_AppStore', context: context);

  @override
  void reset() {
    final _$actionInfo =
        _$_AppStoreActionController.startAction(name: '_AppStore.reset');
    try {
      return super.reset();
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateUserInfo(dynamic data) {
    final _$actionInfo = _$_AppStoreActionController.startAction(
        name: '_AppStore.updateUserInfo');
    try {
      return super.updateUserInfo(data);
    } finally {
      _$_AppStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
userInfo: ${userInfo}
    ''';
  }
}
