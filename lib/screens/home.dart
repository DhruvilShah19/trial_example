import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:trial_example/Data/Data_Model.dart';
import 'package:trial_example/Data/loginModel.dart';
import 'package:trial_example/Modals/Data.dart';
import 'package:trial_example/screens/login.dart';
import 'package:trial_example/theme.dart';

final _formKey = GlobalKey<FormState>();
var dt = DateTime.now();
var newDt = DateFormat.yMMMEd().format(dt);
TextEditingController _ctrlMobile = new TextEditingController();
TextEditingController _ctrlName = new TextEditingController();
final Counter store = Counter();
final Contact contact = Contact();
// final db = FirebaseFirestore.instance;
bool isupdate = false;
Map userProfile;
// final facebookLogin = FacebookLogin();
String radiobtn;
enum Manage { select, pending, collect }

extension ParseToString on Manage {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

Manage order = Manage.select;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController _controller = PageController(
    initialPage: 0,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Contact updateContact;

  showAlertDialog(BuildContext context) {
    Widget okButton = Container(
        width: MediaQuery.of(context).size.width,
        // ignore: deprecated_member_use
        child: RaisedButton(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
              side: BorderSide(color: Colors.red)),
          color: Colors.teal,
          child: Text(
            "OK",
            style: TextStyle(color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ));

    AlertDialog alert = AlertDialog(
      content: new Container(
        width: 230.0,
        height: 120.0,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All field's are mandatory.",
              style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            ),
            Divider(
              thickness: 1.0,
            ),
            okButton,
          ],
        ),
      ),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
          builder: (context, ThemeNotifier notifier, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: notifier.darkTheme ? dark : light,
          home: Scaffold(
            floatingActionButton: Consumer<ThemeNotifier>(
                builder: (context, notifier, child) => (FloatingActionButton(
                    onPressed: null,
                    child: Switch(
                      value: notifier.darkTheme,
                      onChanged: (value) {
                        notifier.toggleTheme();
                      },
                    )))),
            appBar: AppBar(
              iconTheme: new IconThemeData(color: Colors.amberAccent),
              title: Center(
                child: Text(
                  " Money Wise",
                  style:
                      TextStyle(color: Colors.amberAccent, letterSpacing: 1.2),
                ),
              ),
            ),
            // endDrawer: Drawer(
            //   child: ListView(
            //     shrinkWrap: true,
            //     padding: EdgeInsets.zero,
            //     children: <Widget>[
            //       DrawerHeader(
            //         child: Text('Drawer Header'),
            //         decoration: BoxDecoration(),
            //       ),
            //       ListTile(
            //           title: Text('Logout'),
            //           onTap: () {
            //             Navigator.of(context).pushAndRemoveUntil(
            //                 MaterialPageRoute(
            //                     builder: (context) => LoginPage()),
            //                 (Route<dynamic> route) => false);
            //           }),
            //       Divider(),
            //     ],
            //   ),
            // ),
            // body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
            body: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('Contacts')
                    .doc(currentUser.uid)
                    .collection("data")
                    .snapshots(),
                builder: (context, data) {
                  if (data.hasData) {
                    var contact = data.data;
                    store.contacts.clear();
                    contact.docs.forEach((element) {
                      var contact = element.data();
                      print(contact);
                      final contacts = Contact(
                        date: contact['date'],
                        done: contact['done'],
                        deleted: contact['deleted'],
                        name: contact['name'],
                        amount: contact['amount'],
                        documentId: element.id,
                        radiobtn: contact['radiobtn'],
                      );
                      store.contacts.add(contacts);
                      print(contacts.toMap().toString());
                    });
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 28),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                textField1(),
                                textField2(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    radiobtn1(),
                                    radiobtn2(),
                                  ],
                                ),
                                submitbtn(),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Card(
                            margin: EdgeInsets.fromLTRB(8, 12, 8, 3),
                            child: customList(),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        );
      }),
    );
  }

  Widget submitbtn() {
    return Container(
        width: MediaQuery.of(context).size.width / 1.5,
        margin: EdgeInsets.all(8.0),
        child: isupdate
            // ignore: deprecated_member_use
            ? RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  "Update",
                  style: TextStyle(
                      color: Colors.amberAccent,
                      letterSpacing: 1.4,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {
                    isupdate = false;
                  });
                  if (_formKey.currentState.validate() &&
                      store.user.radiobtn != null) {
                    FirebaseFirestore.instance
                        .collection('Contacts')
                        .doc(currentUser.uid)
                        .collection("data")
                        .doc(updateContact.documentId)
                        .update({
                      'radiobtn': store.user.radiobtn,
                      'name': store.user.name,
                      'amount': store.user.amount,
                    });
                    // store.getList();
                    _ctrlMobile.clear();
                    _ctrlName.clear();
                  } else {
                    showAlertDialog(context);
                  }
                },
              )
            // ignore: deprecated_member_use
            : RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                child: Text(
                  "Submit",
                  style: TextStyle(
                      letterSpacing: 1.4,
                      color: Colors.amberAccent,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  setState(() {
                    isupdate = false;
                  });
                  if (_formKey.currentState.validate() &&
                      store.user.radiobtn != null) {
                    store.user.date = newDt;
                    store.onSubmit();
                    _ctrlMobile.clear();
                    _ctrlName.clear();
                  } else {
                    showAlertDialog(context);
                  }
                },
              ));
  }

  Widget radiobtn2() {
    return Row(
      children: [
        Radio(
          value: Manage.collect,
          groupValue: order,
          activeColor: Colors.green,
          onChanged: (Manage value) {
            setState(() {
              order = value;
              print(value.toString().split('.').last);
              store.user.radiobtn = value.toString().split('.').last;
              radiobtn = store.user.radiobtn;
              print(store.user.radiobtn);
            });
          },
        ),
        Text("To collect",
            style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget radiobtn1() {
    return Row(
      children: [
        Radio(
          value: Manage.pending,
          groupValue: order,
          activeColor: Colors.green,
          onChanged: (Manage value) {
            setState(() {
              order = value;
              store.user.radiobtn = value.toString().split('.').last;
              radiobtn = store.user.radiobtn;
              // print(store.user.radiobtn);
              print(radiobtn);
            });
          },
        ),
        Text("To be paid",
            style: TextStyle(letterSpacing: 1.2, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget customList() {
    var item = store.contacts.where((x) => x.deleted == false).toList();
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(8),
      itemBuilder: (context, index) {
        var name = item[index].name.toUpperCase();
        var amount = item[index].amount;
        Contact contact = item[index];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                    child: (contact.radiobtn == 'pending')
                        ? contact.done == false
                            ? Text(
                                "Payment pending",
                                style: TextStyle(
                                    letterSpacing: 1.2,
                                    color: Colors.red[600],
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "payment completed",
                                style: TextStyle(
                                    letterSpacing: 1.2,
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.bold),
                              )
                        : contact.done == false
                            ? Text(
                                "collection is pending",
                                style: TextStyle(
                                    letterSpacing: 1.2,
                                    color: Colors.red[600],
                                    fontWeight: FontWeight.bold),
                              )
                            : Text(
                                "Amount is collected",
                                style: TextStyle(
                                    letterSpacing: 1.2,
                                    color: Colors.green[600],
                                    fontWeight: FontWeight.bold),
                              )),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 5, bottom: 5),
                  child: InkWell(
                    onTap: () {
                      updateContact = store.contacts[index];
                      _ctrlName.text = store.contacts[index].name.toUpperCase();
                      _ctrlMobile.text = store.contacts[index].amount;
                      setState(() {
                        isupdate = true;
                      });
                    },
                    child: Icon(
                      Icons.edit,
                      size: 21,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ],
            ),
            Card(
              child: ListTile(
                leading: Checkbox(
                    tristate: true,
                    checkColor: Colors.black,
                    activeColor:
                        contact.done ? Colors.amberAccent : Colors.amberAccent,
                    value: contact.done,
                    onChanged: (x) {
                      setState(() {
                        x = contact.done;
                        print(x);
                        if (x == false) {
                          FirebaseFirestore.instance
                              .collection('Contacts')
                              .doc(currentUser.uid)
                              .collection("data")
                              .doc(contact.documentId)
                              .update({'done': true});
                        } else {
                          FirebaseFirestore.instance
                              .collection('Contacts')
                              .doc(currentUser.uid)
                              .collection("data")
                              .doc(contact.documentId)
                              .update({'done': false});
                        }
                      });
                    }),
                trailing: InkWell(
                  onTap: () {
                    print(store.contacts[index].done);
                    if (contact.deleted == false) {
                      FirebaseFirestore.instance
                          .collection('Contacts')
                          .doc(currentUser.uid)
                          .collection("data")
                          .doc(contact.documentId)
                          .update({'deleted': true});
                    }
                  },
                  child: (Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
                ),
                title: Text(
                  "Name : $name" ?? "--/--",
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  "Amount: $amount" ?? "--/--",
                  style: TextStyle(
                      letterSpacing: 1.2, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0, top: 6.0),
              child: Text(
                contact.date,
                style: TextStyle(
                    letterSpacing: 0.8,
                    color: Colors.grey,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10),
              child: Divider(
                height: 10.0,
                thickness: 1.0,
              ),
            ),
          ],
        );
      },
      itemCount: item.length,
    );
  }

  Widget textField2() {
    return TextFormField(
        keyboardType: TextInputType.number,
        controller: _ctrlMobile,
        decoration: InputDecoration(labelText: 'Amount'),
        validator: (val) =>
            val.length < 1 ? 'Minimum 1 character required' : null,
        onChanged: (value) => store.user.amount = value);
  }

  Widget textField1() {
    return TextFormField(
        keyboardType: TextInputType.name,
        controller: _ctrlName,
        decoration: InputDecoration(labelText: 'Full Name'),
        validator: (val) =>
            (val.length == 0 ? 'This field is mandatory' : null),
        onChanged: (value) => store.user.name = value);
  }
}
