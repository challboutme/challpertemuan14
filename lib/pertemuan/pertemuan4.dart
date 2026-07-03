import 'package:flutter/material.dart';
import 'package:simple_alert_dialog/simple_alert_dialog.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:pertemuan_listview/page/beranda_page.dart';
import 'package:pertemuan_listview/page/profile_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Toast_Alert extends StatefulWidget {
  const Toast_Alert({super.key});

  // This widget is the root of your application.
  @override
  State<Toast_Alert> createState() => _Toast_AlertState();
}

class _Toast_AlertState extends State<Toast_Alert> {
  int _currentPage = 0;

  List<Widget> _page = [BerandaPage(), ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _page[_currentPage],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentPage,
        onTap: (index) => setState(() => _currentPage = index),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.home),
            title: const Text("Beranda"),
            selectedColor: Color(0xFF800020),
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: Color(0xFF800020),
          ),
        ],
      ),
    );
  }
}
