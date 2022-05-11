// ignore_for_file: deprecated_member_use

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:trial_example/screens/login.dart';
// import 'package:trial_example/Modals/Data.dart';
// import 'package:trial_example/Data/Data_Model.dart';
// import 'package:trial_example/shared.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen()));
}

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 8), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(10),
        alignment: Alignment.bottomCenter,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 253, 253),
          image: DecorationImage(
              image: AssetImage('lib/images/splashFinal.jpg'),
              fit: BoxFit.contain),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Text(
              "Everything you need...",
              style: TextStyle(
                  color: Color.fromARGB(255, 9, 9, 9),
                  fontSize: 13,
                  fontStyle: FontStyle.italic),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                  width: 200,
                  height: 2,
                  child: LinearProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
                      backgroundColor: Color.fromARGB(255, 67, 67, 67))),
            ),
          ],
        ),
      ),
    );
  }
}






































































// final _formKey = GlobalKey<FormState>();

// TextEditingController _ctrlMobile = new TextEditingController();
// TextEditingController _ctrlName = new TextEditingController();
// final Counter store = Counter();
// SharedPref sharedPref = SharedPref();
// bool isupdate = false;
// String radiobtn;
// enum Manage { select, pending, collect }

// extension ParseToString on Manage {
//   String toShortString() {
//     return this.toString().split('.').last;
//   }
// }

// Manage order = Manage.select;
// // print(order.toShortString());

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   showAlertDialog(BuildContext context) {
//     Widget okButton = Container(
//         width: MediaQuery.of(context).size.width,
//         child: RaisedButton(
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(30.0),
//               side: BorderSide(color: Colors.red)),
//           color: Colors.teal[400],
//           child: Text(
//             "OK",
//             style: TextStyle(color: Colors.white),
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ));

//     AlertDialog alert = AlertDialog(
//       content: new Container(
//         width: 230.0,
//         height: 120.0,
//         decoration: new BoxDecoration(
//           shape: BoxShape.rectangle,
//           borderRadius: new BorderRadius.all(new Radius.circular(32.0)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               "All field's are mandatory.",
//               style: TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
//             ),
//             Divider(
//               thickness: 1.0,
//             ),
//             okButton,
//           ],
//         ),
//       ),
//     );

//     // show the dialog
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return alert;
//       },
//     );
//   }

//   Contact updateContact;
//   final CollectionReference noticeCollection =
//       FirebaseFirestore.instance.collection('Contacts');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.teal[300],
//       appBar: AppBar(
//         backgroundColor: Colors.teal[300],
//         title: Center(
//           child: Text(
//             " Money Manager",
//             style: TextStyle(color: Colors.white),
//           ),
//         ),
//       ),
//       body: StreamBuilder<QuerySnapshot>(
//           stream: deleted.snapshots(),
//           builder: (context, data) {
//             if (data.hasData) {
//               var contact = data.data?.documents ?? [];
//               store.contacts.clear();
//               contact.forEach((element) {
//                 var contact = element.data();
//                 print(contact);

//                 final contacts = Contact(
//                     done: contact['done'],
//                     deleted: contact['deleted'],
//                     name: contact['name'],
//                     amount: contact['mobile'],
//                     documentId: element.id,
//                     radiobtn: contact['radiobtn']);
//                 store.contacts.add(contacts);
//                 print(store.contacts);
//               });
//             }
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     color: Colors.white,
//                     padding: EdgeInsets.symmetric(vertical: 15, horizontal: 28),
//                     child: Form(
//                       key: _formKey,
//                       child: Column(
//                         children: <Widget>[
//                           TextFormField(
//                               cursorColor: Colors.teal,
//                               keyboardType: TextInputType.name,
//                               controller: _ctrlName,
//                               decoration:
//                                   InputDecoration(labelText: 'Full Name'),
//                               validator: (val) => (val.length == 0
//                                   ? 'This field is mandatory'
//                                   : null),
//                               onChanged: (value) => store.user.name = value),
//                           TextFormField(
//                               cursorColor: Colors.teal,
//                               keyboardType: TextInputType.number,
//                               controller: _ctrlMobile,
//                               decoration: InputDecoration(labelText: 'Amount'),
//                               validator: (val) => val.length < 1
//                                   ? 'Minimum 1 character required'
//                                   : null,
//                               onChanged: (value) => store.user.amount = value),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Row(
//                                 children: [
//                                   Radio(
//                                     value: Manage.pending,
//                                     groupValue: order,
//                                     activeColor: Colors.teal,
//                                     onChanged: (Manage value) {
//                                       setState(() {
//                                         order = value;

//                                         store.user.radiobtn =
//                                             value.toString().split('.').last;
//                                         radiobtn = store.user.radiobtn;
//                                         // print(store.user.radiobtn);
//                                         print(radiobtn);
//                                       });
//                                     },
//                                   ),
//                                   Text("To be paid",
//                                       style: TextStyle(
//                                           letterSpacing: 1.2,
//                                           color: Colors.teal,
//                                           fontWeight: FontWeight.bold)),
//                                 ],
//                               ),
//                               Row(
//                                 children: [
//                                   Radio(
//                                     value: Manage.collect,
//                                     groupValue: order,
//                                     activeColor: Colors.teal,
//                                     onChanged: (Manage value) {
//                                       setState(() {
//                                         order = value;
//                                         print(value.toString().split('.').last);
//                                         store.user.radiobtn =
//                                             value.toString().split('.').last;
//                                         radiobtn = store.user.radiobtn;
//                                         print(store.user.radiobtn);
//                                       });
//                                     },
//                                   ),
//                                   Text("To collect",
//                                       style: TextStyle(
//                                           letterSpacing: 1.2,
//                                           color: Colors.teal,
//                                           fontWeight: FontWeight.bold)),
//                                 ],
//                               ),
//                             ],
//                           ),
//                           Container(
//                               width: MediaQuery.of(context).size.width / 2,
//                               margin: EdgeInsets.all(8.0),
//                               child: isupdate
//                                   ? RaisedButton(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(18.0),
//                                           side: BorderSide(color: Colors.red)),
//                                       child: Text(
//                                         "Update",
//                                         style: TextStyle(
//                                             letterSpacing: 1.4,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       color: Colors.teal,
//                                       onPressed: () {
//                                         setState(() {
//                                           isupdate = false;
//                                         });
//                                         if (_formKey.currentState.validate() &&
//                                             store.user.radiobtn != null) {
//                                           db
//                                               .doc(updateContact.documentId)
//                                               .update({
//                                             'radiobtn': store.user.radiobtn,
//                                             'name': store.user.name,
//                                             'mobile': store.user.amount,
//                                           });
//                                           // store.getList();
//                                           _ctrlMobile.clear();
//                                           _ctrlName.clear();
//                                         } else {
//                                           showAlertDialog(context);
//                                         }
//                                       },
//                                     )
//                                   : RaisedButton(
//                                       shape: RoundedRectangleBorder(
//                                           borderRadius:
//                                               BorderRadius.circular(18.0),
//                                           side: BorderSide(color: Colors.red)),
//                                       child: Text(
//                                         "Submit",
//                                         style: TextStyle(
//                                             letterSpacing: 1.4,
//                                             color: Colors.white,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       color: Colors.teal[300],
//                                       onPressed: () {
//                                         setState(() {
//                                           isupdate = false;
//                                         });
//                                         if (_formKey.currentState.validate() &&
//                                             store.user.radiobtn != null) {
//                                           store.onSubmit();
//                                           _ctrlMobile.clear();
//                                           _ctrlName.clear();
//                                         } else {
//                                           showAlertDialog(context);
//                                         }
//                                       },
//                                     )),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Card(
//                       margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
//                       child: Scrollbar(
//                         child: ListView.builder(
//                           padding: const EdgeInsets.all(8),
//                           itemBuilder: (context, index) {
//                             var name = store.contacts[index].name.toUpperCase();
//                             var amount = store.contacts[index].amount;
//                             Contact contact = store.contacts[index];
//                             return Column(
//                               crossAxisAlignment: CrossAxisAlignment.end,
//                               children: <Widget>[
//                                 Row(
//                                   mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Container(
//                                         margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                                         child: (contact.radiobtn == 'pending')
//                                             ? contact.done == false
//                                                 ? Text(
//                                                     "Payment pending",
//                                                     style: TextStyle(
//                                                         letterSpacing: 1.2,
//                                                         color: Colors.red[600],
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   )
//                                                 : Text(
//                                                     "payment completed",
//                                                     style: TextStyle(
//                                                         letterSpacing: 1.2,
//                                                         color:
//                                                             Colors.green[600],
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   )
//                                             : contact.done == false
//                                                 ? Text(
//                                                     "collection is pending",
//                                                     style: TextStyle(
//                                                         letterSpacing: 1.2,
//                                                         color: Colors.red[600],
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   )
//                                                 : Text(
//                                                     "Amount is collected",
//                                                     style: TextStyle(
//                                                         letterSpacing: 1.2,
//                                                         color:
//                                                             Colors.green[600],
//                                                         fontWeight:
//                                                             FontWeight.bold),
//                                                   )),
//                                     Padding(
//                                       padding: const EdgeInsets.only(
//                                           left: 10,
//                                           right: 10,
//                                           top: 5,
//                                           bottom: 5),
//                                       child: InkWell(
//                                         onTap: () {
//                                           updateContact = store.contacts[index];
//                                           _ctrlName.text = store
//                                               .contacts[index].name
//                                               .toUpperCase();
//                                           _ctrlMobile.text =
//                                               store.contacts[index].amount;
//                                           setState(() {
//                                             isupdate = true;
//                                           });
//                                         },
//                                         child: Icon(
//                                           Icons.edit,
//                                           size: 18,
//                                           color: Colors.blueGrey,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 Card(
//                                   child: ListTile(
//                                     leading: Checkbox(
//                                         tristate: true,
//                                         checkColor: Colors.white,
//                                         activeColor: contact.done
//                                             ? Colors.teal
//                                             : Colors.teal[200],
//                                         value: contact.done,
//                                         onChanged: (x) {
//                                           setState(() {
//                                             x = contact.done;
//                                             print(x);
//                                             if (x == false) {
//                                               db
//                                                   .doc(contact.documentId)
//                                                   .update({'done': true});
//                                             } else {
//                                               db
//                                                   .doc(contact.documentId)
//                                                   .update({'done': false});
//                                             }
//                                           });
//                                         }),
//                                     trailing: InkWell(
//                                       onTap: () {
//                                         print(store.contacts[index].done);
//                                         if (contact.deleted == false) {
//                                           db
//                                               .doc(contact.documentId)
//                                               .update({'deleted': true});
//                                         }
//                                       },
//                                       child: (Icon(
//                                         Icons.delete,
//                                         color: Colors.red,
//                                       )),
//                                     ),
//                                     title: Text(
//                                       "Name : $name",
//                                       style: TextStyle(
//                                           fontWeight: FontWeight.w500),
//                                     ),
//                                     subtitle: Text(
//                                       "Amount: ₹$amount",
//                                       style: TextStyle(
//                                           letterSpacing: 1.2,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(
//                                       top: 20.0, bottom: 10),
//                                   child: Divider(
//                                     height: 10.0,
//                                     thickness: 1.0,
//                                   ),
//                                 ),
//                               ],
//                             );
//                           },
//                           itemCount: store.contacts.length,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }),
//     );
//   }
// }
