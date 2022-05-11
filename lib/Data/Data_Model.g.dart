// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Data_Model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Counter on _Counter, Store {
  final _$userAtom = Atom(name: '_Counter.user');

  @override
  Contact get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(Contact value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  final _$contactAtom = Atom(name: '_Counter.contact');

  @override
  Contact get contact {
    _$contactAtom.reportRead();
    return super.contact;
  }

  @override
  set contact(Contact value) {
    _$contactAtom.reportWrite(value, super.contact, () {
      super.contact = value;
    });
  }

  final _$sharedPrefAtom = Atom(name: '_Counter.sharedPref');

  @override
  SharedPref get sharedPref {
    _$sharedPrefAtom.reportRead();
    return super.sharedPref;
  }

  @override
  set sharedPref(SharedPref value) {
    _$sharedPrefAtom.reportWrite(value, super.sharedPref, () {
      super.sharedPref = value;
    });
  }

  final _$contactsAtom = Atom(name: '_Counter.contacts');

  @override
  ObservableList<Contact> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(ObservableList<Contact> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  final _$onSubmitAsyncAction = AsyncAction('_Counter.onSubmit');

  @override
  Future onSubmit() {
    return _$onSubmitAsyncAction.run(() => super.onSubmit());
  }

  final _$getListAsyncAction = AsyncAction('_Counter.getList');

  @override
  Future getList() {
    return _$getListAsyncAction.run(() => super.getList());
  }

  final _$removeListAsyncAction = AsyncAction('_Counter.removeList');

  @override
  Future removeList(dynamic index) {
    return _$removeListAsyncAction.run(() => super.removeList(index));
  }

  @override
  String toString() {
    return '''
user: ${user},
contact: ${contact},
sharedPref: ${sharedPref},
contacts: ${contacts}
    ''';
  }
}
