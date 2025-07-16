import 'package:dashboard/pages/dashboard/dashboard_controller.dart';
import 'package:dashboard/pages/widgets/side_bar_meny.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  void updateContent(int index) {
    setState(() {
      selectedIndex = index;
      if (MediaQuery.of(context).size.width < 800) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: MediaQuery.of(context).size.width < 800
          ? SideBar(
              selectedIndex: selectedIndex,
              onItemSelected: updateContent,
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (MediaQuery.of(context).size.width >= 800)
              SideBar(
                selectedIndex: selectedIndex,
                onItemSelected: updateContent,
              ),
            Expanded(
              child: DashboardController(selectedIndex: selectedIndex),
            ),
          ],
        ),
      ),
    );
  }
}
