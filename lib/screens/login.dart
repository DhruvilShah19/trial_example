import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trial_example/Data/loginModel.dart';
import 'package:trial_example/Modals/userData.dart';
import 'package:trial_example/screens/default.dart';
// ignore: unused_import
import 'package:trial_example/screens/home.dart';
import 'package:trial_example/screens/register.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference db = FirebaseFirestore.instance.collection('Users');
  final GoogleSignIn googleSignIn = GoogleSignIn();
  SharedPreferences prefs;
  bool isLoading = false;
  bool isLoggedIn = false;
  String name;
  UserData loginCrediantials = UserData();
  Map userProfile;
  final facebookLogin = FacebookLogin();

  @override
  void initState() {
    // loginWithFB();
    super.initState();
  }

  // void loginWithFB() async {
  //   final result = await facebookLogin.logIn(['email']);
  //   switch (result.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       final token = result.accessToken.token;
  //       final graphResponse = await http.get(
  //           'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
  //       final profile = JSON.jsonDecode(graphResponse.body);
  //       print(profile);
  //       setState(() {
  //         userProfile = profile;
  //         isLoggedIn = true;
  //       });
  //       break;

  //     case FacebookLoginStatus.cancelledByUser:
  //       setState(() => isLoggedIn = false);
  //       break;
  //     case FacebookLoginStatus.error:
  //       setState(() => isLoggedIn = false);
  //       break;
  //   }
  // }

  void logout() {
    // facebookLogin.logOut();
    setState(() {
      isLoggedIn = false;
    });
  }

  void isSignedIn() async {
    this.setState(() {
      isLoading = true;
    });

    prefs = await SharedPreferences.getInstance();

    isLoggedIn = await googleSignIn.isSignedIn();
    if (isLoggedIn == true) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DefaultPage()));
    }

    this.setState(() {
      isLoading = false;
    });
  }

  Future<String> handleSignIn() async {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

    currentUser = (await auth.signInWithCredential(credential)).user;
    print("signed in " + currentUser.displayName);

    currentUser = (await auth.signInWithCredential(credential)).user;
    loginCrediantials.uid = currentUser.uid;
    loginCrediantials.email = currentUser.email;
    loginCrediantials.name = currentUser.displayName;

    if (currentUser != null) {
      db.doc(currentUser.uid).get().then((value) {
        print(value.data());
        if (value.data() != null) {
          store.user = UserData.fromJson(value.data());
          print("${store.user.email} signed in");
        }
      });
    }
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('Users')
        .where('uid', isEqualTo: currentUser.uid)
        .get();
    final List<DocumentSnapshot> documents = result.docs;
    if (documents.length == 0) {
      db.doc(currentUser.uid).set(loginCrediantials.toJson());
    }
    this.setState(() {
      isLoading = false;
      isLoggedIn = true;
    });
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => DefaultPage()));

    print(currentUser.email);
    print(currentUser.displayName);
    print(currentUser.uid);
    return currentUser != null ? currentUser.uid : null;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Login store = Login();
  Widget textField() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Password",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: store.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)),
        ],
      ),
    );
  }

  Widget textField2() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Email",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              controller: store.emailController,
              obscureText: false,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        if (_formKey.currentState.validate()) {
          store.signInWithEmailAndPassword();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => DefaultPage()));
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448), Color(0xfff7892b)])),
        child: Text(
          'Login',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text('or'),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Don\'t have an account ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpPage()),
              );
            },
            child: Text(
              'Register',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _title() {
    return Center(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
            text: 'Money',
            style: TextStyle(color: Colors.black, fontSize: 30),
          ),
          TextSpan(
            text: ' Wise',
            style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
          ),
        ]),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          textField2(),
          textField(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Container(
      height: height,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: height * .2),
                  _title(),
                  SizedBox(height: 50),
                  _emailPasswordWidget(),
                  SizedBox(height: 20),
                  _submitButton(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.centerRight,
                    child: Text('Forgot Password ?',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500)),
                  ),
                  _divider(),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: FacebookSignInButton(
                        centered: true,
                        splashColor: Colors.amberAccent,
                        onPressed: () {}),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      child: GoogleSignInButton(
                          darkMode: false,
                          splashColor: Colors.amberAccent,
                          centered: true,
                          onPressed: () {
                            handleSignIn();
                          })),
                  SizedBox(
                    height: 10,
                  ),
                  _createAccountLabel(),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
