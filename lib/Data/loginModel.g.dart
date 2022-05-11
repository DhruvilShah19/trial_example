// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'loginModel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Login on _Login, Store {
  final _$loginCrediantialsAtom = Atom(name: '_Login.loginCrediantials');

  @override
  UserData get loginCrediantials {
    _$loginCrediantialsAtom.reportRead();
    return super.loginCrediantials;
  }

  @override
  set loginCrediantials(UserData value) {
    _$loginCrediantialsAtom.reportWrite(value, super.loginCrediantials, () {
      super.loginCrediantials = value;
    });
  }

  final _$userAtom = Atom(name: '_Login.user');

  @override
  UserData get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(UserData value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$registerAsyncAction = AsyncAction('_Login.register');

  @override
  Future register() {
    return _$registerAsyncAction.run(() => super.register());
  }

  final _$signInWithEmailAndPasswordAsyncAction =
      AsyncAction('_Login.signInWithEmailAndPassword');

  @override
  Future signInWithEmailAndPassword() {
    return _$signInWithEmailAndPasswordAsyncAction
        .run(() => super.signInWithEmailAndPassword());
  }

  final _$_LoginActionController = ActionController(name: '_Login');

  @override
  dynamic getUserData() {
    final _$actionInfo =
        _$_LoginActionController.startAction(name: '_Login.getUserData');
    try {
      return super.getUserData();
    } finally {
      _$_LoginActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loginCrediantials: ${loginCrediantials},
user: ${user}
    ''';
  }
}
