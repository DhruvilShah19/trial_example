import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:trial_example/screens/bills.dart';
import 'package:trial_example/screens/home.dart';
import 'package:trial_example/screens/news.dart';

class DefaultPage extends StatefulWidget {
  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  final _pageController = PageController();
  @override
  void initState() {
    super.initState();
  }

  int _selectedIndex = 0;
  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<Widget> _screens = [
    MyApp(),
    NewsPage(),
    BillPage(),
  ];
  void _onItemTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: _pageController,
              children: _screens,
              onPageChanged: _onPageChanged),
          bottomNavigationBar: CurvedNavigationBar(
            index: _selectedIndex,
            backgroundColor: Color.fromARGB(255, 61, 60, 60),
            color: Color.fromARGB(235, 0, 0, 0),
            height: 54,
            items: [
              Icon(
                Icons.home,
                size: 20,
                color: Colors.white,
              ),
              Icon(
                Icons.data_exploration_outlined,
                size: 20,
                color: Colors.white,
              ),
              // Icon(
              //   Icons.favorite_border,
              //   size: 20,
              //   color: Colors.white,
              // ),
              Icon(
                Icons.add_a_photo_outlined,
                size: 20,
                color: Colors.white,
              ),
              Icon(
                Icons.account_circle_outlined,
                size: 20,
                color: Colors.white,
              ),
              // Icon(
              //   Icons.account_circle,
              //   size: 20,
              //   color: Colors.white,
              // ),
            ],
            onTap: _onItemTapped,
          ),
        ));
  }
}
