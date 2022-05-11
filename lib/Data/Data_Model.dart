import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mobx/mobx.dart';
import 'package:trial_example/Data/loginModel.dart';
import 'package:trial_example/Modals/Data.dart';
import 'package:trial_example/shared.dart';

// Include generated file
part 'Data_Model.g.dart';

// final db = FirebaseFirestore.instance;
final CollectionReference db =
    FirebaseFirestore.instance.collection('Contacts');
final Query deleted = db.where("deleted", isEqualTo: false);

class Counter = _Counter with _$Counter;

// The store-class
abstract class _Counter with Store {
  @observable
  Contact user = Contact();

  @observable
  Contact contact = Contact();

  @observable
  SharedPref sharedPref = SharedPref();

  @observable
  ObservableList<Contact> contacts = ObservableList<Contact>();

  @action
  onSubmit() async {
    // contacts.add(contact);
    contacts.clear();
    contact = Contact(
        date: user.date,
        done: false,
        deleted: false,
        documentId: null,
        name: user.name,
        amount: user.amount,
        radiobtn: user.radiobtn);

    // await db.add(contact.toMap());
    await db.doc(currentUser.uid).collection("data").add(contact.toMap());

    // var templist =
    //     contacts.map((element) => jsonEncode(element.toMap())).toList();
    // print(contact.toMap());
    // saveList(templist);
  }

  @action
  getList() async {
    db.doc(contact.documentId).update({
      'name': user.name,
      'amount': user.amount,
    });

    // if (sharedPref.read("user") != null) {
    //   var list = await sharedPref.read("user");
    //   // print(list);
    //   for (var item in list) {
    //     Map contact = jsonDecode(item);
    //     final con = Contact.fromMap(contact);
    //     contacts.add(con);
    //   }
    // } else {
    //   print('never reached');
    // }

    // @action
    // saveList(value) {
    //   sharedPref.save("user", value);
    //   return true;
    // }
  }

  @action
  removeList(index) async {
    contacts.removeAt(index);

    // var templist =
    //     contacts.map((element) => jsonEncode(element.toMap())).toList();
    // print(contact.toMap());
    // saveList(templist);
    // print(templist);
  }
}
