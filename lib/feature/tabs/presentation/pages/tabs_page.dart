import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wknd_app/core/constant/app_string.dart';
import 'package:wknd_app/feature/home/presentation/pages/home_page.dart';
import 'package:wknd_app/feature/refer/presentation/pages/refer_page.dart';

class TabsPage extends StatefulWidget {
  const TabsPage({super.key});

  @override
  State<TabsPage> createState() => _TabsPageState();
}

class _TabsPageState extends State<TabsPage> {
  int currentPageIndex = 0;
  final List<Widget> pages = <Widget>[HomePage(), ReferPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: [
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: AppString.home,
          ),
          NavigationDestination(
            icon: Icon(Icons.share),
            label: AppString.refer,
          ),
        ],
      ),
    );
  }
}
