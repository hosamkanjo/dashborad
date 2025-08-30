import 'package:dashboard/counters/employee_counter.dart';
import 'package:dashboard/counters/student_counter.dart';
import 'package:dashboard/counters/teacher_counter.dart';
import 'package:dashboard/services/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:async';

// class Dashboard extends StatefulWidget {
//   const Dashboard({super.key});

//   @override
//   State<Dashboard> createState() => _DashboardState();
// }

// class _DashboardState extends State<Dashboard> {
//   DateTime _focusedDay = DateTime.now();
//   DateTime _selectedDay = DateTime.now();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'D A S H B O A R D',
//               style: TextStyle(
//                 color: Color(0xff4B70F5),
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 4),
//             const Text(
//               'Navigate the future of education with MASTER !',
//               style: TextStyle(fontSize: 16, color: Color(0xff4B70F5)),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: _buildCounterCard(
//                     title: 'Total Students :',
//                     valueNotifier: StudentCounter.count,
//                     icon: Icons.school,
//                     backgroundColor: const Color(0xff4B70F5),
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: _buildCounterCard(
//                     title: 'Total Teachers :',
//                     valueNotifier: TeacherCounter.count1,
//                     icon: Icons.person,
//                     backgroundColor: const Color(0xff4B70F5),
//                   ),
//                 ),
//                 const SizedBox(width: 20),
//                 Expanded(
//                   child: _buildCounterCard(
//                     title: 'Total Employees :',
//                     valueNotifier: EmployeeCounter.count2,
//                     icon: Icons.work,
//                     backgroundColor: const Color(0xff4B70F5),
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // المخطط البياني
//                 _buildGenderChart(),
//                 const Spacer(),
//                 ValueListenableBuilder<Map<String, int>>(
//                   valueListenable: StudentCounter.classCounts,
//                   builder: (context, data, _) =>
//                       buildClassDistributionChart(data),
//                 ),
//                 const Spacer(),
//                 // التقويم والساعة
//                 SizedBox(width: 500, child: _buildCalendarCard()),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCounterCard({
//     required String title,
//     required ValueNotifier<int> valueNotifier,
//     required IconData icon,
//     required Color backgroundColor,
//   }) {
//     return Container(
//       height: 120,
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: const [
//           BoxShadow(
//             color: Colors.black12,
//             blurRadius: 8,
//             offset: Offset(0, 4),
//           ),
//         ],
//       ),
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       child: Row(
//         children: [
//           CircleAvatar(
//             backgroundColor: Colors.white,
//             radius: 28,
//             child: Icon(icon, color: backgroundColor, size: 30),
//           ),
//           const SizedBox(width: 16),
//           Expanded(
//             child: ValueListenableBuilder<int>(
//               valueListenable: valueNotifier,
//               builder: (context, value, child) {
//                 return Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       title,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Text(
//                       '$value',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 28,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildCalendarCard() {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             StreamBuilder<DateTime>(
//               stream: Stream.periodic(
//                   const Duration(seconds: 1), (_) => DateTime.now()),
//               builder: (context, snapshot) {
//                 final now = snapshot.data ?? DateTime.now();
//                 final timeText =
//                     "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
//                 final dateText =
//                     "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

//                 return Column(
//                   children: [
//                     Text(
//                       "Time: $timeText",
//                       style: const TextStyle(
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff4B70F5),
//                       ),
//                     ),
//                     const SizedBox(height: 4),
//                     Text(
//                       "Date: $dateText",
//                       style: const TextStyle(
//                         fontSize: 18,
//                         color: Colors.black54,
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                   ],
//                 );
//               },
//             ),
//             TableCalendar(
//               firstDay: DateTime.utc(2000, 1, 1),
//               lastDay: DateTime.utc(2100, 12, 31),
//               focusedDay: _focusedDay,
//               selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
//               onDaySelected: (selectedDay, focusedDay) {
//                 setState(() {
//                   _selectedDay = selectedDay;
//                   _focusedDay = focusedDay;
//                 });
//               },
//               calendarFormat: CalendarFormat.month,
//               availableGestures: AvailableGestures.horizontalSwipe,
//               calendarStyle: const CalendarStyle(
//                 todayDecoration: BoxDecoration(
//                   color: Color(0xff4B70F5),
//                   shape: BoxShape.circle,
//                 ),
//                 weekendTextStyle: TextStyle(color: Colors.red),
//               ),
//               headerStyle: const HeaderStyle(
//                 formatButtonVisible: false,
//                 titleCentered: true,
//                 titleTextStyle: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//                 leftChevronVisible: true,
//                 rightChevronVisible: true,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildGenderChart() {
//     return SizedBox(
//       width: 300,
//       height: 300,
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const Text(
//                 'Students :',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Expanded(
//                 child: ValueListenableBuilder<int>(
//                   valueListenable: StudentCounter.boys,
//                   builder: (context, boys, _) {
//                     return ValueListenableBuilder<int>(
//                       valueListenable: StudentCounter.girls,
//                       builder: (context, girls, _) {
//                         final total = boys + girls;
//                         final boysPercent =
//                             total == 0 ? 0.0 : (boys / total) * 100;
//                         final girlsPercent =
//                             total == 0 ? 0.0 : (girls / total) * 100;

//                         return PieChart(
//                           PieChartData(
//                             sections: [
//                               PieChartSectionData(
//                                 color: const Color(0xff4B70F5),
//                                 value: boysPercent,
//                                 title: '',
//                                 radius: 50,
//                               ),  
//                               PieChartSectionData(
//                                 color: Colors.pinkAccent,
//                                 value: girlsPercent,
//                                 title: '',
//                                 radius: 50,
//                               ),
//                             ],
//                             centerSpaceRadius: 35,
//                           ),
//                         );
//                       },
//                     );
//                   },
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ValueListenableBuilder<int>(
//                     valueListenable: StudentCounter.boys,
//                     builder: (context, boys, _) =>
//                         _buildLegend(const Color(0xff4B70F5), "Boys", boys),
//                   ),
//                   ValueListenableBuilder<int>(
//                     valueListenable: StudentCounter.girls,
//                     builder: (context, girls, _) =>
//                         _buildLegend(Colors.pinkAccent, "Girls", girls),
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLegend(Color color, String label, int value) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             CircleAvatar(backgroundColor: color, radius: 6),
//             const SizedBox(width: 6),
//             Text(
//               "$value",
//               style: const TextStyle(fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//         Text(label),
//       ],
//     );
//   }

//   Widget buildClassDistributionChart(Map<String, int> classCountsMap) {
//     final total = classCountsMap.values.fold(0, (sum, count) => sum + count);
//     if (total == 0) {
//       return const Center(child: Text("No students yet."));
//     }

//     final colors = [
//       Colors.red,
//       Colors.orange,
//       Colors.yellow,
//       Colors.green,
//       Colors.teal,
//       Colors.cyan,
//       Colors.blue,
//       Colors.indigo,
//       Colors.purple,
//       Colors.pink,
//       Colors.brown,
//       Colors.grey,
//     ];

//     final sections = <PieChartSectionData>[];

//     classCountsMap.forEach((className, count) {
//       final percent = (count / total) * 100;
//       if (percent == 0) return;

//       // استخراج رقم الصف من الاسم مثل "class 4"
//       final classNumber = int.tryParse(className.split(' ').last) ?? 0;
//       final color = colors[(classNumber - 1) % colors.length];

//       sections.add(
//         PieChartSectionData(
//           color: color,
//           value: percent,
//           title: '${percent.toStringAsFixed(1)}%',
//           radius: 70,
//           titleStyle: const TextStyle(
//             fontSize: 14,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//       );
//     });

//     return SizedBox(
//       width: 400,
//       height: 450,
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               const Text(
//                 'Class Distribution :',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               SizedBox(
//                 height: 220,
//                 child: PieChart(
//                   PieChartData(
//                     sections: sections,
//                     centerSpaceRadius: 25,
//                     sectionsSpace: 2,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Wrap(
//                 alignment: WrapAlignment.center,
//                 spacing: 10,
//                 runSpacing: 8,
//                 children: classCountsMap.keys.map((className) {
//                   final classNumber =
//                       int.tryParse(className.split(' ').last) ?? 0;
//                   final color = colors[(classNumber - 1) % colors.length];

//                   return Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: color,
//                         radius: 6,
//                       ),
//                       const SizedBox(width: 6),
//                       Text(className, style: const TextStyle(fontSize: 12)),
//                     ],
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




///////////////////////////////////////////////////////////////////////////////////









import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:table_calendar/table_calendar.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final DashboardService _dashboardService = DashboardService();
  late Future<Map<String, dynamic>> _dashboardData;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _dashboardData = _dashboardService.fetchDashboardData();
  }

  Future<void> _refreshData() async {
    setState(() {
      _dashboardData = _dashboardService.fetchDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: _refreshData,
        child: FutureBuilder<Map<String, dynamic>>(
          future: _dashboardData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            final data = snapshot.data!;
            final classDistribution = Map<String, int>.from(data['class_distribution']);
            final genderDistribution = Map<String, int>.from(data['gender_distribution']);

            return SingleChildScrollView(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'D A S H B O A R D',
                    style: TextStyle(
                      color: Color(0xff4B70F5),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Navigate the future of education with MASTER !',
                    style: TextStyle(fontSize: 16, color: Color(0xff4B70F5)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildCounterCard(
                        title: 'Total Students :',
                        value: data['total_students'],
                        icon: Icons.school,
                        backgroundColor: const Color(0xff4B70F5),
                      ),
                      const SizedBox(width: 20),
                      _buildCounterCard(
                        title: 'Total Teachers :',
                        value: data['total_teachers'],
                        icon: Icons.person,
                        backgroundColor: const Color(0xff4B70F5),
                      ),
                      const SizedBox(width: 20),
                      _buildCounterCard(
                        title: 'Total Supervisors :',
                        value: data['total_supervisors'],
                        icon: Icons.work,
                        backgroundColor: const Color(0xff4B70F5),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildGenderChart(genderDistribution),
                      const Spacer(),
                      _buildClassDistributionChart(classDistribution),
                      const Spacer(),
                      _buildCalendarCard(),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildCounterCard({
    required String title,
    required dynamic value,
    required IconData icon,
    required Color backgroundColor,
  }) {
    return Expanded(
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 28,
              child: Icon(icon, color: backgroundColor, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$value',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderChart(Map<String, int> genderData) {
    final boys = genderData['male'] ?? 0;
    final girls = genderData['female'] ?? 0;
    final total = boys + girls;

    return SizedBox(
      width: 300,
      height: 300,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Students Gender Distribution',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        color: const Color(0xff4B70F5),
                        value: boys.toDouble(),
                        title: boys == 0 ? '' : '${((boys / total) * 100).toStringAsFixed(1)}%',
                        radius: 50,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      PieChartSectionData(
                        color: Colors.pinkAccent,
                        value: girls.toDouble(),
                        title: girls == 0 ? '' : '${((girls / total) * 100).toStringAsFixed(1)}%',
                        radius: 50,
                        titleStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                    centerSpaceRadius: 35,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildLegend(const Color(0xff4B70F5), "Boys", boys),
                  _buildLegend(Colors.pinkAccent, "Girls", girls),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildClassDistributionChart(Map<String, int> classCountsMap) {
    final total = classCountsMap.values.fold(0, (sum, count) => sum + count);
    if (total == 0) {
      return const Center(child: Text("No students yet."));
    }

    final colors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.teal,
      Colors.cyan,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
      Colors.pink,
      Colors.brown,
      Colors.grey,
    ];

    final sections = <PieChartSectionData>[];

    classCountsMap.forEach((className, count) {
      final percent = (count / total) * 100;
      if (percent == 0) return;

      final classNumber = int.tryParse(className.split(' ').last) ?? 0;
      final color = colors[(classNumber - 1) % colors.length];

      sections.add(
        PieChartSectionData(
          color: color,
          value: percent,
          title: '${percent.toStringAsFixed(1)}%',
          radius: 70,
          titleStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    });

    return SizedBox(
      width: 400,
      height: 450,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Text(
                'Class Distribution',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 220,
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: 25,
                    sectionsSpace: 2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 10,
                runSpacing: 8,
                children: classCountsMap.keys.map((className) {
                  final classNumber = int.tryParse(className.split(' ').last) ?? 0;
                  final color = colors[(classNumber - 1) % colors.length];

                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        backgroundColor: color,
                        radius: 6,
                      ),
                      const SizedBox(width: 6),
                      Text(className, style: const TextStyle(fontSize: 12)),
                    ],
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarCard() {
    return SizedBox(
      width: 500,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              StreamBuilder<DateTime>(
                stream: Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
                builder: (context, snapshot) {
                  final now = snapshot.data ?? DateTime.now();
                  final timeText = "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}:${now.second.toString().padLeft(2, '0')}";
                  final dateText = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";

                  return Column(
                    children: [
                      Text(
                        "Time: $timeText",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4B70F5),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Date: $dateText",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  );
                },
              ),
              TableCalendar(
                firstDay: DateTime.utc(2000, 1, 1),
                lastDay: DateTime.utc(2100, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                },
                calendarFormat: CalendarFormat.month,
                availableGestures: AvailableGestures.horizontalSwipe,
                calendarStyle: const CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Color(0xff4B70F5),
                    shape: BoxShape.circle,
                  ),
                  weekendTextStyle: TextStyle(color: Colors.red),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  leftChevronVisible: true,
                  rightChevronVisible: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLegend(Color color, String label, int value) {
    return Column(
      children: [
        Row(
          children: [
            CircleAvatar(backgroundColor: color, radius: 6),
            const SizedBox(width: 6),
            Text(
              "$value",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text(label),
      ],
    );
  }
}
