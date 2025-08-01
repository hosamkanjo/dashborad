import 'package:dashboard/pages/activities.dart';
import 'package:dashboard/pages/dashboard.dart';
import 'package:dashboard/pages/employees.dart';
import 'package:dashboard/pages/holidays.dart';
import 'package:dashboard/pages/installments_and_salaries.dart';
import 'package:dashboard/pages/logout.dart';
import 'package:dashboard/pages/permission_requests.dart';
import 'package:dashboard/pages/search.dart';
import 'package:dashboard/pages/session_year.dart';
import 'package:dashboard/pages/settings.dart';
import 'package:dashboard/pages/students.dart';
import 'package:dashboard/pages/teachers.dart';
import 'package:dashboard/pages/timetable.dart';

import 'package:flutter/material.dart';

class DashboardController extends StatelessWidget {
  final int selectedIndex;

  const DashboardController({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    List<Widget> contentWidgets = [
      const Dashboard(),
      Students(),
      const Teachers(),
      const Employees(),
      const Search(),
      const Timetable(),
      const SessionYear(),
      const Holidays(),
      const Activities(),
      const PermissionRequest(),
      InstallmentsAndSalaries(),
      const Settings(),
      const LogoutPage(),
    ];

    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: contentWidgets[selectedIndex],
      ),
    );
  }
}
