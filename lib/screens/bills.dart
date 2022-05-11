import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:trial_example/Data/loginModel.dart';
import 'package:trial_example/screens/upload.dart';
import 'package:trial_example/theme.dart';

class BillPage extends StatefulWidget {
  @override
  _BillPageState createState() => _BillPageState();
}

class _BillPageState extends State<BillPage> {
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
                floatingActionButton: FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddImage()));
                  },
                ),
                appBar: AppBar(
                  iconTheme: new IconThemeData(color: Colors.amberAccent),
                  title: Center(
                    child: Text(
                      "Upload a bill photo...",
                      style: TextStyle(
                          color: Colors.amberAccent, letterSpacing: 1.2),
                    ),
                  ),
                ),
                body: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('Contacts')
                      .doc(currentUser.uid)
                      .collection("data")
                      .snapshots(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            padding: EdgeInsets.all(10),
                            child: GridView.builder(
                                itemCount: snapshot.data.documents.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2),
                                itemBuilder: (context, index) {
                                  return Card(
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0)),
                                    child: FadeInImage.memoryNetwork(
                                        fit: BoxFit.cover,
                                        placeholder: kTransparentImage,
                                        image: snapshot.data.documents[index]
                                            .get('url')),
                                  );
                                }),
                          );
                  },
                ),
              ),
            );
          },
        ));
  }
}
