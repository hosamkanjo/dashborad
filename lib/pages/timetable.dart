import 'package:flutter/material.dart';

class Timetable extends StatefulWidget {
  const Timetable({super.key});

  @override
  State<Timetable> createState() => _TimetablePageState();
}

class _TimetablePageState extends State<Timetable> {
  final List<String> days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
  ];
  final int lessonsPerDay = 6;

  String selectedClass = '';
  String selectedSection = '';

  List<String> availableClasses = [
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5',
    'Class 6',
    'Class 7',
    'Class 8',
    'Class 9',
    'Class 10',
    'Class 11',
    'Class 12',
  ];
  List<String> availableSections = ['Section 1', 'Section 2', 'Section 3'];
  List<String> subjects = [
    'Mathematics',
    'Physics',
    'Chemistry',
    'Science',
    'English',
    'Arabic',
    'France',
    'Art',
    'Music',
  ];

  Map<String, List<String>> schedule = {};
  List<Map<String, dynamic>> savedSchedules = [];

  @override
  void initState() {
    super.initState();
    for (var day in days) {
      schedule[day] = List.filled(lessonsPerDay, '');
    }
  }

  void saveSchedule() {
    if (selectedClass.isEmpty || selectedSection.isEmpty) return;
    setState(() {
      savedSchedules.add({
        'class': selectedClass,
        'section': selectedSection,
        'schedule': Map.from(schedule),
      });
      // Reset
      selectedClass = '';
      selectedSection = '';
      for (var day in days) {
        schedule[day] = List.filled(lessonsPerDay, '');
      }
    });
  }

  void deleteSchedule(int index) {
    setState(() {
      savedSchedules.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Create Weekly Timetable',
                  style: TextStyle(
                    color: Color(0xff4B70F5),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Select Class',
                hintStyle: TextStyle(color: Color(0xff4B70F5)),
              ),
              value: selectedClass.isNotEmpty ? selectedClass : null,
              items: availableClasses
                  .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedClass = val ?? '';
                });
              },
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                hintText: 'Select Section',
                hintStyle: TextStyle(color: Color(0xff4B70F5)),
              ),
              value: selectedSection.isNotEmpty ? selectedSection : null,
              items: availableSections
                  .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                  .toList(),
              onChanged: (val) {
                setState(() {
                  selectedSection = val ?? '';
                });
              },
            ),
            const SizedBox(height: 20),
            ...days.map(
              (day) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    day,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...List.generate(lessonsPerDay, (i) {
                    return Row(
                      children: [
                        Text(
                          'Lesson ${i + 1}:',
                          style: const TextStyle(color: Color(0xff4B70F5)),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: schedule[day]![i].isNotEmpty
                                ? schedule[day]![i]
                                : null,
                            hint: const Text(
                              'Select Subject',
                              style: TextStyle(color: Color(0xff4B70F5)),
                            ),
                            items: subjects
                                .map(
                                  (s) => DropdownMenuItem(
                                    value: s,
                                    child: Text(s),
                                  ),
                                )
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                schedule[day]![i] = val ?? '';
                              });
                            },
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 12),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: saveSchedule,
              child: const Text('Save Schedule'),
            ),
            const SizedBox(height: 30),
            const Divider(),
            const Text(
              'Saved Schedules:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            ...savedSchedules.asMap().entries.map((entry) {
              int index = entry.key;
              var sched = entry.value;
              return Card(
                child: ListTile(
                  title: Text(
                    '${sched['class']} - ${sched['section']}',
                    style: const TextStyle(color: Color(0xff4B70F5)),
                  ),
                  subtitle: Text(
                    sched['schedule'].entries
                        .map((e) => "${e.key}: ${e.value.join(', ')}")
                        .join("\n"),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => deleteSchedule(index),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// class Timetable extends StatefulWidget {
//   const Timetable({super.key});

//   @override
//   State<Timetable> createState() => _TimetablePageState();
// }

// class _TimetablePageState extends State<Timetable> {
//   final List<String> days = [
//     'Sunday',
//     'Monday',
//     'Tuesday',
//     'Wednesday',
//     'Thursday'
//   ];
//   final int lessonsPerDay = 5;

//   String selectedClass = '';
//   List<String> availableClasses = ['Grade 1', 'Grade 2', 'Grade 3'];
//   List<String> subjects = [
//     'Mathematics',
//     'Physics',
//     'Chemistry',
//     'Science',
//     'English',
//     'Arabic',
//     'France',
//     'Art',
//     'Music'
//   ];

//   Map<String, List<String>> schedule = {};
//   List<Map<String, dynamic>> savedSchedules = [];

//   @override
//   void initState() {
//     super.initState();
//     for (var day in days) {
//       schedule[day] = List.filled(lessonsPerDay, '');
//     }
//   }

//   void saveSchedule() {
//     if (selectedClass.isEmpty) return;
//     setState(() {
//       savedSchedules.add({
//         'class': selectedClass,
//         'schedule': Map.from(schedule),
//       });
//       // Reset
//       selectedClass = '';
//       for (var day in days) {
//         schedule[day] = List.filled(lessonsPerDay, '');
//       }
//     });
//   }

//   void deleteSchedule(int index) {
//     setState(() {
//       savedSchedules.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Padding(
//               padding: EdgeInsets.all(8.0),
//               child: Center(
//                 child: Text('Create Weekly Timetable',
//                     style: TextStyle(
//                         color: Color(0xff4B70F5),
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold)),
//               ),
//             ),
//             DropdownButtonFormField<String>(
//               decoration: const InputDecoration(
//                   hintText: 'Select Class',
//                   hintStyle: TextStyle(color: Color(0xff4B70F5))),
//               value: selectedClass.isNotEmpty ? selectedClass : null,
//               items: availableClasses
//                   .map((c) => DropdownMenuItem(value: c, child: Text(c)))
//                   .toList(),
//               onChanged: (val) {
//                 setState(() {
//                   selectedClass = val ?? '';
//                 });
//               },
//             ),
//             const SizedBox(height: 20),
//             ...days.map((day) => Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(day,
//                         style: const TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold)),
//                     const SizedBox(height: 8),
//                     ...List.generate(lessonsPerDay, (i) {
//                       return Row(
//                         children: [
//                           Text(
//                             'Lesson ${i + 1}:',
//                             style: const TextStyle(color: Color(0xff4B70F5)),
//                           ),
//                           const SizedBox(width: 10),
//                           Expanded(
//                             child: DropdownButton<String>(
//                               isExpanded: true,
//                               value: schedule[day]![i].isNotEmpty
//                                   ? schedule[day]![i]
//                                   : null,
//                               hint: const Text(
//                                 'Select Subject',
//                                 style: TextStyle(color: Color(0xff4B70F5)),
//                               ),
//                               items: subjects
//                                   .map((s) => DropdownMenuItem(
//                                       value: s, child: Text(s)))
//                                   .toList(),
//                               onChanged: (val) {
//                                 setState(() {
//                                   schedule[day]![i] = val ?? '';
//                                 });
//                               },
//                             ),
//                           ),
//                         ],
//                       );
//                     }),
//                     const SizedBox(height: 12),
//                   ],
//                 )),
//             ElevatedButton(
//               onPressed: saveSchedule,
//               child: const Text('Save Schedule'),
//             ),
//             const SizedBox(height: 30),
//             const Divider(),
//             const Text('Saved Schedules:',
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//             const SizedBox(height: 10),
//             ...savedSchedules.asMap().entries.map((entry) {
//               int index = entry.key;
//               var sched = entry.value;
//               return Card(
//                 child: ListTile(
//                   title: Text(
//                     sched['class'],
//                     style: const TextStyle(color: Color(0xff4B70F5)),
//                   ),
//                   subtitle: Text(sched['schedule']
//                       .entries
//                       .map((e) => "${e.key}: ${e.value.join(', ')}")
//                       .join("\n")),
//                   trailing: IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.red),
//                     onPressed: () => deleteSchedule(index),
//                   ),
//                 ),
//               );
//             }),
//           ],
//         ),
//       ),
//     );
//   }
// }
