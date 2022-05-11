import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobx/mobx.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trial_example/Modals/userData.dart';
part 'loginModel.g.dart';

User currentUser;

FirebaseAuth auth = FirebaseAuth.instance;
final CollectionReference db = FirebaseFirestore.instance.collection('Users');
final GoogleSignIn googleSignIn = GoogleSignIn();
// final fb = FacebookLogin();
class Login = _Login with _$Login;

abstract class _Login with Store {
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  @observable
  UserData loginCrediantials = UserData();
  @observable
  UserData user = UserData();
  @observable
  SharedPreferences prefs;
  @observable
  bool isLoading = false;

  @action
  register() async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: loginCrediantials.email, password: passwordController.text);
      currentUser = result.user;
      loginCrediantials.uid = currentUser.uid;
      db.doc(currentUser.uid).set(loginCrediantials.toJson());
      user = loginCrediantials;
    } catch (e) {}
  }

  @action
  signInWithEmailAndPassword() async {
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      currentUser = result.user;
      getUserData();
    } catch (e) {}
  }

  @action
  signOut() async {
    await auth.signOut();
  }

  @action
  getUserData() {
    db.doc(currentUser.uid).get().then((value) async {
      prefs = await SharedPreferences.getInstance();
      print(value.data());
      if (value.data() != null) {
        user = UserData.fromJson(value.data());
        print("${user.email} signed in");
        await prefs.setString('id', currentUser.uid);
        await prefs.setString('photoUrl', currentUser.email);
      } else {
        currentUser.delete();
      }
    });
  }
}
