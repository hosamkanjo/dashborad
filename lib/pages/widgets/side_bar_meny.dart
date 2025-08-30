import 'package:flutter/material.dart';
import 'package:dashboard/pages/logout.dart';

class SideBar extends StatelessWidget {
  final Function(int) onItemSelected;
  final int selectedIndex;

  const SideBar({
    super.key,
    required this.onItemSelected,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 800) {
          return Container(
            width: 250,
            color: const Color(0xff4B70F5),
            child: buildDrawerContent(context),
          );
        }

        return Drawer(
          elevation: 0,
          child: Container(
            color: const Color(0xff4B70F5),
            child: buildDrawerContent(context),
          ),
        );
      },
    );
  }

  Widget buildDrawerContent(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Image.asset("assets/photo_2025-06-05_05-53-33.jpg",
                      height: 120, width: 100),
                  const SizedBox(width: 8),
                  const Text("MASTER",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const Divider(color: Colors.white70),
            ..._buildMenuItems(context),
            const SizedBox(height: 20),
            Image.asset("assets/photo_2025-05-13_15-11-29.jpg"),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildMenuItems(BuildContext context) {
    final menuItems = [
      ("Home", Icons.home),
      ("Students", Icons.person_add),
      ("Teachers", Icons.school),
      ("Supervisor", Icons.person_add_outlined),
      ("Search", Icons.search),
      ("Timetable", Icons.schedule),
      ("Session year", Icons.calendar_today),

      // ("Permission Requests", Icons.check_circle),
      ("Settings", Icons.settings),
    ];

    return List.generate(menuItems.length, (index) {
      return DrawerList(
        title: menuItems[index].$1,
        icon: Icon(menuItems[index].$2, color: Colors.white),
        selected: selectedIndex == index,
        onTap: () => onItemSelected(index),
      );
    })
      ..add(
        DrawerList(
          title: "Log out",
          icon: const Icon(Icons.logout, color: Colors.white),
          selected: false,
          onTap: () => showDialog(
            context: context,
            builder: (context) => const LogoutPage(),
          ),
        ),
      );
  }
}

class DrawerList extends StatelessWidget {
  final String title;
  final Icon icon;
  final bool selected;
  final VoidCallback onTap;

  const DrawerList({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: selected ? Colors.white.withOpacity(0.2) : Colors.transparent,
      child: ListTile(
        horizontalTitleGap: 0.0,
        leading: icon,
        title: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: onTap,
      ),
    );
  }
}
