import 'package:flutter/material.dart';
import 'package:qwe/pages/npages/bar_item.dart';
import 'package:qwe/pages/npages/home.dart';
import 'package:qwe/pages/npages/my.dart';
import 'package:qwe/pages/npages/search.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [const HomePage(), const BarItem(), const SearchPage(), const MyPage()];
  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        unselectedFontSize: 0,
        selectedFontSize: 0,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white70,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(label: ("Home"), icon: Icon(Icons.apps)),
          BottomNavigationBarItem(
              label: ("Bar"), icon: Icon(Icons.bar_chart_sharp)),
          BottomNavigationBarItem(label: ("Search"), icon: Icon(Icons.search)),
          BottomNavigationBarItem(label: ("My"), icon: Icon(Icons.person))
        ],
      ),
    );
  }
}
