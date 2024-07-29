import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:line_icons/line_icons.dart';
import 'package:wknd_app/config/router/route_path.dart';
import 'package:wknd_app/core/constant/app_string.dart';
import 'package:wknd_app/core/extensions/e_context_extensions.dart';
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
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(child: Icon(LineIcons.user)),
            const SizedBox(width: 8.0),
            RichText(
              text: TextSpan(
                text: 'Welcome \n',
                style: context.titleLarge,
                children: const <TextSpan>[
                  TextSpan(text: 'John Doe', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: CircleAvatar(child: Icon(LineIcons.alternateSignOut)),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              context.go(RoutePath.login);
            },
          ),
        ],
      ),
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
