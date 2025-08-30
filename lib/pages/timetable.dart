// import 'dart:convert';
// import 'package:dashboard/main.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ScheduleInitializer extends StatefulWidget {
//   @override
//   _ScheduleInitializerState createState() => _ScheduleInitializerState();
// }

// class _ScheduleInitializerState extends State<ScheduleInitializer> {
//   final List<Teacher> _teachers = [];
//   final List<Classroom> _classrooms = [];
//   final List<Period> _periods = [];

//   final List<TeacherAvailability> teacherAvailabilities = [];
//   final List<ClassroomSchedule> classrooms = [];

//   bool _loading = true;
//   String? _loadError;

//   final List<String> daysOfWeek = const [
//     'saturday',
//     'sunday',
//     'monday',
//     'tuesday',
//     'wednesday',
//     'thursday',
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _bootstrap();
//   }

//   Future<void> _bootstrap() async {
//     setState(() {
//       _loading = true;
//       _loadError = null;
//     });
//     try {
//       await Future.wait([
//         _fetchTeachers(),
//         _fetchPeriods(),
//         _fetchClassrooms(),
//       ]);
//     } catch (e) {
//       _loadError = e.toString();
//     } finally {
//       if (mounted) {
//         setState(() => _loading = false);
//       }
//     }
//   }

//   Map<String, String> _authHeaders() {
//     final token = storage.getString('token');
//     return {
//       'Authorization': 'Bearer $token',
//       'Content-Type': 'application/json',
//       'Accept': 'application/json',
//     };
//   }

//   Future<void> _fetchTeachers() async {
//     final url = Uri.parse('http://137.184.50.2/api/v1/dashboard/teacher');
//     final res = await http.get(url, headers: _authHeaders());
//     print(' Response Status: ${res.statusCode}');
//     print(' Response Data: ${res.body}');
//     if (res.statusCode != 200) {
//       throw Exception('Failed to load teachers (${res.statusCode})');
//     }
//     final data = jsonDecode(res.body);
//     // Expecting list of teachers under data or the body itself depending on API
//     final List list = data is Map && data['data'] != null
//         ? data['data']
//         : (data as List);
//     _teachers
//       ..clear()
//       ..addAll(
//         list.map(
//           (e) => Teacher(
//             id: e['id'] is int ? e['id'] : int.tryParse('${e['id']}') ?? 0,
//             name: e['name']?.toString() ?? '—',
//           ),
//         ),
//       );
//   }

//   Future<void> _fetchPeriods() async {
//     final url = Uri.parse(
//       'http://137.184.50.2/api/v1/dashboard/schedule/periods',
//     );

//     final res = await http.get(url, headers: _authHeaders());
//     print(' Response Status: ${res.statusCode}');
//     print(' Response Data: ${res.body}');
//     if (res.statusCode != 200) {
//       throw Exception('Failed to load periods (${res.statusCode})');
//     }
//     final data = jsonDecode(res.body);
//     final List list = data is Map && data['data'] != null
//         ? data['data']
//         : (data as List);
//     _periods
//       ..clear()
//       ..addAll(
//         list.map(
//           (e) => Period(
//             id: e['id'] is int ? e['id'] : int.tryParse('${e['id']}') ?? 0,
//             name: e['name']?.toString() ?? '—',
//           ),
//         ),
//       );
//   }

//   Future<void> _fetchClassrooms() async {
//     final url = Uri.parse('http://137.184.50.2/api/v1/dashboard/classrooms');
//     final res = await http.get(url, headers: _authHeaders());
//     print(' Response Status: ${res.statusCode}');
//     print(' Response Data: ${res.body}');
//     if (res.statusCode != 200) {
//       throw Exception('Failed to load classrooms (${res.statusCode})');
//     }
//     final data = jsonDecode(res.body);
//     final List list = data is Map && data['data'] != null
//         ? data['data']
//         : (data as List);
//     _classrooms
//       ..clear()
//       ..addAll(
//         list.map(
//           (e) => Classroom(
//             id: e['id'] is int ? e['id'] : int.tryParse('${e['id']}') ?? 0,
//             name: e['name']?.toString() ?? '—',
//           ),
//         ),
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text(
//           'Weekly Schedule Initialization',
//           style: TextStyle(color: Colors.white),
//         ),
//         backgroundColor: const Color(0xff4B70F5),
//         iconTheme: const IconThemeData(color: Colors.white),
//         actions: [
//           IconButton(
//             onPressed: _loading ? null : _bootstrap,
//             icon: const Icon(Icons.refresh),
//             tooltip: 'Reload lists',
//           ),
//         ],
//       ),
//       body: _loading
//           ? const Center(child: CircularProgressIndicator())
//           : _loadError != null
//           ? _ErrorState(message: _loadError!, onRetry: _bootstrap)
//           : SingleChildScrollView(
//               padding: const EdgeInsets.all(16),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildTeacherAvailabilitySection(),
//                   const SizedBox(height: 24),
//                   _buildClassroomScheduleSection(),
//                   const SizedBox(height: 24),
//                   _buildSubmitButton(),
//                 ],
//               ),
//             ),
//     );
//   }

//   Widget _buildTeacherAvailabilitySection() {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: const BorderSide(color: Color(0xff4B70F5), width: 2),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Teacher Availability',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xff4B70F5),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ...teacherAvailabilities.asMap().entries.map((entry) {
//               final index = entry.key;
//               final availability = entry.value;
//               return _buildTeacherAvailabilityItem(availability, index);
//             }),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _teachers.isEmpty || _periods.isEmpty
//                   ? null
//                   : _addTeacherAvailability,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff4B70F5),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text('Add Teacher'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildTeacherAvailabilityItem(
//     TeacherAvailability availability,
//     int index,
//   ) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: const Color(0xff4B70F5).withOpacity(0.3)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: DropdownButtonFormField<int>(
//                   value: availability.teacherId,
//                   decoration: InputDecoration(
//                     labelText: 'Teacher',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   items: _teachers
//                       .map(
//                         (t) => DropdownMenuItem<int>(
//                           value: t.id,
//                           child: Text(t.name),
//                         ),
//                       )
//                       .toList(),
//                   onChanged: (value) =>
//                       setState(() => availability.teacherId = value!),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.delete, color: Colors.red),
//                 onPressed: () => _removeTeacherAvailability(index),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           DropdownButtonFormField<String>(
//             value: availability.dayOfWeek,
//             decoration: InputDecoration(
//               labelText: 'Day',
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//               ),
//             ),
//             items: daysOfWeek
//                 .map(
//                   (day) => DropdownMenuItem<String>(
//                     value: day,
//                     child: Text(_getEnglishDayName(day)),
//                   ),
//                 )
//                 .toList(),
//             onChanged: (value) =>
//                 setState(() => availability.dayOfWeek = value!),
//           ),
//           const SizedBox(height: 12),
//           const Text(
//             'Available Periods:',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           Wrap(
//             spacing: 8,
//             children: _periods.map((p) {
//               final isSelected = availability.periodIds.contains(p.id);
//               return FilterChip(
//                 label: Text(p.name),
//                 selected: isSelected,
//                 onSelected: (selected) {
//                   setState(() {
//                     if (selected) {
//                       availability.periodIds.add(p.id);
//                     } else {
//                       availability.periodIds.remove(p.id);
//                     }
//                   });
//                 },
//                 selectedColor: const Color(0xff4B70F5),
//                 checkmarkColor: Colors.white,
//                 labelStyle: TextStyle(
//                   color: isSelected ? Colors.white : Colors.black,
//                 ),
//               );
//             }).toList(),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildClassroomScheduleSection() {
//     return Card(
//       elevation: 4,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//         side: const BorderSide(color: Color(0xff4B70F5), width: 2),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Classroom Schedule',
//               style: TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xff4B70F5),
//               ),
//             ),
//             const SizedBox(height: 16),
//             ...classrooms.asMap().entries.map((entry) {
//               final index = entry.key;
//               final classroom = entry.value;
//               return _buildClassroomScheduleItem(classroom, index);
//             }),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _classrooms.isEmpty ? null : _addClassroomSchedule,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff4B70F5),
//                 foregroundColor: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//               ),
//               child: const Text('Add Classroom'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildClassroomScheduleItem(ClassroomSchedule classroom, int index) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.grey[50],
//         borderRadius: BorderRadius.circular(8),
//         border: Border.all(color: const Color(0xff4B70F5).withOpacity(0.3)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                 child: DropdownButtonFormField<int>(
//                   value: classroom.classroomId,
//                   decoration: InputDecoration(
//                     labelText: 'Classroom',
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                   ),
//                   items: _classrooms
//                       .map(
//                         (c) => DropdownMenuItem<int>(
//                           value: c.id,
//                           child: Text(c.name),
//                         ),
//                       )
//                       .toList(),
//                   onChanged: (value) =>
//                       setState(() => classroom.classroomId = value!),
//                 ),
//               ),
//               IconButton(
//                 icon: const Icon(Icons.delete, color: Colors.red),
//                 onPressed: () => _removeClassroomSchedule(index),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),
//           const Text(
//             'Periods per Day:',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           ...daysOfWeek.map((day) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(vertical: 4),
//               child: Row(
//                 children: [
//                   Expanded(flex: 2, child: Text(_getEnglishDayName(day))),
//                   Expanded(
//                     flex: 3,
//                     child: TextFormField(
//                       initialValue:
//                           classroom.periodsPerDay[day]?.toString() ?? '0',
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 12,
//                         ),
//                       ),
//                       onChanged: (value) {
//                         classroom.periodsPerDay[day] = int.tryParse(value) ?? 0;
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           }).toList(),
//         ],
//       ),
//     );
//   }

//   Widget _buildSubmitButton() {
//     return Center(
//       child: ElevatedButton(
//         onPressed: _submitSchedule,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: const Color(0xff4B70F5),
//           foregroundColor: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: const Text(
//           'Initialize Schedule',
//           style: TextStyle(fontSize: 16),
//         ),



        
//       ),
//     );
//   }

//   void _addTeacherAvailability() {
//     if (_teachers.isEmpty) return;
//     setState(() {
//       teacherAvailabilities.add(
//         TeacherAvailability(
//           teacherId: _teachers.first.id,
//           dayOfWeek: daysOfWeek.first,
//           periodIds: <int>[],
//         ),
//       );
//     });
//   }

//   void _removeTeacherAvailability(int index) {
//     setState(() => teacherAvailabilities.removeAt(index));
//   }

//   void _addClassroomSchedule() {
//     if (_classrooms.isEmpty) return;
//     setState(() {
//       classrooms.add(
//         ClassroomSchedule(
//           classroomId: _classrooms.first.id,
//           periodsPerDay: {
//             'saturday': 0,
//             'sunday': 0,
//             'monday': 0,
//             'tuesday': 0,
//             'wednesday': 0,
//             'thursday': 0,
//           },
//         ),
//       );
//     });
//   }

//   void _removeClassroomSchedule(int index) {
//     setState(() => classrooms.removeAt(index));
//   }

//   Future<void> _submitSchedule() async {
//     final url = Uri.parse(
//       'http://137.184.50.2/api/v1/dashboard/schedule/initialize-weekly',
//     );

//     final requestBody = {
//       'teacher_availabilities': teacherAvailabilities.map((availability) {
//         return {
//           'teacher_id': availability.teacherId,
//           'day_of_week': availability.dayOfWeek,
//           'period_ids': availability.periodIds,
//         };
//       }).toList(),
//       'classrooms': classrooms.map((classroom) {
//         return {
//           'classroom_id': classroom.classroomId,
//           'periods_per_day': classroom.periodsPerDay,
//         };
//       }).toList(),
//     };

//     debugPrint('Sending request: ${jsonEncode(requestBody)}');

//     try {
//       final response = await http.post(
//         url,
//         headers: _authHeaders(),
//         body: jsonEncode(requestBody),
//       );
//       print(' Response Status: ${response.statusCode}');
//       print(' Response Data: ${response.body}');
//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         if ((responseData is Map) && responseData['success'] == true) {
//           if (!mounted) return;
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(responseData['message']?.toString() ?? 'Success'),
//               backgroundColor: Colors.green,
//             ),
//           );
//           _showResults(Map<String, dynamic>.from(responseData['data'] as Map));
//         } else {
//           if (!mounted) return;
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text(
//                 responseData['message']?.toString() ??
//                     'Failed to initialize schedule',
//               ),
//               backgroundColor: Colors.red,
//             ),
//           );
//         }
//       } else {
//         SnackBar(content: Text(response.body), backgroundColor: Colors.red);
//         if (!mounted) return;
//         // ScaffoldMessenger.of(context).showSnackBar(
//         //   const SnackBar(
//         //     content: Text('Server connection error'),
//         //     backgroundColor: Colors.red,
//         //   ),
//         // );
//       }
//     } catch (e) {
//       if (!mounted) return;
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
//       );
//     }
//   }

//   void _showResults(Map<String, dynamic> data) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text(
//           'Schedule Initialization Results',
//           style: TextStyle(color: Color(0xff4B70F5)),
//         ),
//         content: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Teacher Availability Summary:',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               ...(data['teacher_availability_summary'] as List? ?? const [])
//                   .map(
//                     (summary) => Text(
//                       'Teacher ${summary['teacher_id']} - ${_getEnglishDayName(summary['day_of_week'])}: ${summary['count']} periods',
//                     ),
//                   )
//                   .toList(),
//               const SizedBox(height: 16),
//               const Text(
//                 'Classroom Schedule Summary:',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               ...(data['section_schedules_summary'] as List? ?? const [])
//                   .map(
//                     (summary) => Text(
//                       'Classroom ${summary['classroom_id']}: ${summary['sections_count']} sections - ${summary['rows_created']} rows',
//                     ),
//                   )
//                   .toList(),
//             ],
//           ),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK', style: TextStyle(color: Color(0xff4B70F5))),
//           ),
//         ],
//       ),
//     );
//   }

//   String _getEnglishDayName(String day) {
//     const dayMap = {
//       'saturday': 'Saturday',
//       'sunday': 'Sunday',
//       'monday': 'Monday',
//       'tuesday': 'Tuesday',
//       'wednesday': 'Wednesday',
//       'thursday': 'Thursday',
//     };
//     return dayMap[day] ?? day;
//   }
// }

// // ===== Models =====
// class TeacherAvailability {
//   int teacherId;
//   String dayOfWeek;
//   List<int> periodIds;

//   TeacherAvailability({
//     required this.teacherId,
//     required this.dayOfWeek,
//     required this.periodIds,
//   });
// }

// class ClassroomSchedule {
//   int classroomId;
//   Map<String, int> periodsPerDay;

//   ClassroomSchedule({required this.classroomId, required this.periodsPerDay});
// }

// class Teacher {
//   final int id;
//   final String name;
//   Teacher({required this.id, required this.name});
// }

// class Period {
//   final int id;
//   final String name;
//   Period({required this.id, required this.name});
// }

// class Classroom {
//   final int id;
//   final String name;
//   Classroom({required this.id, required this.name});
// }

// class _ErrorState extends StatelessWidget {
//   final String message;
//   final VoidCallback onRetry;
//   const _ErrorState({required this.message, required this.onRetry});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.error_outline, size: 48, color: Colors.red),
//             const SizedBox(height: 12),
//             Text(message, textAlign: TextAlign.center),
//             const SizedBox(height: 12),
//             ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
//           ],
//         ),
//       ),
//     );
//   }
// }
// schedule_initializer.dart
import 'dart:convert';
import 'package:dashboard/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ScheduleInitializer extends StatefulWidget {
  const ScheduleInitializer({super.key});

  @override
  _ScheduleInitializerState createState() => _ScheduleInitializerState();
}

class _ScheduleInitializerState extends State<ScheduleInitializer> {
  // ===== Data Lists =====
  final List<Teacher> _teachers = [];
  final List<Classroom> _classrooms = [];
  final List<Period> _periods = [];

  final List<TeacherAvailability> teacherAvailabilities = [];
  final List<ClassroomSchedule> classrooms = [];

  // ===== UI State =====
  bool _loading = true;
  String? _loadError;

  final List<String> daysOfWeek = const [
    'saturday',
    'sunday',
    'monday',
    'tuesday',
    'wednesday',
    'thursday',
  ];

  // ===== Generate API State =====
  List<GeneratedScheduleItem> _generated = [];
  String? _generateError;
  bool _generating = false;

  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    setState(() {
      _loading = true;
      _loadError = null;
    });
    try {
      await Future.wait([
        _fetchTeachers(),
        _fetchPeriods(),
        _fetchClassrooms(),
      ]);
    } catch (e) {
      _loadError = e.toString();
    } finally {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  // ===== Helpers =====
  Map<String, String> _authHeaders() {
    final token = storage.getString('token');
    return {
      'Authorization': 'Bearer ${token ?? ''}',
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
  }

  String _getEnglishDayName(String day) {
    const dayMap = {
      'saturday': 'Saturday',
      'sunday': 'Sunday',
      'monday': 'Monday',
      'tuesday': 'Tuesday',
      'wednesday': 'Wednesday',
      'thursday': 'Thursday',
    };
    return dayMap[day] ?? day;
  }

  String _dayEnToTitle(String d) => _getEnglishDayName(d);

  // ===== Fetchers =====
  Future<void> _fetchTeachers() async {
    final url = Uri.parse('http://137.184.50.2/api/v1/dashboard/teacher');
    final res = await http.get(url, headers: _authHeaders());
    debugPrint('Teachers Status: ${res.statusCode}');
    debugPrint('Teachers Body: ${res.body}');
    if (res.statusCode != 200) {
      throw Exception('Failed to load teachers (${res.statusCode})');
    }
    final data = jsonDecode(res.body);
    final List list =
        data is Map && data['data'] != null ? data['data'] : (data as List);
    _teachers
      ..clear()
      ..addAll(
        list.map(
          (e) => Teacher(
            id: e['id'] is int ? e['id'] : int.tryParse('${e['id']}') ?? 0,
            name: e['name']?.toString() ?? '—',
          ),
        ),
      );
  }

  Future<void> _fetchPeriods() async {
    final url =
        Uri.parse('http://137.184.50.2/api/v1/dashboard/schedule/periods');
    final res = await http.get(url, headers: _authHeaders());
    debugPrint('Periods Status: ${res.statusCode}');
    debugPrint('Periods Body: ${res.body}');
    if (res.statusCode != 200) {
      throw Exception('Failed to load periods (${res.statusCode})');
    }
    final data = jsonDecode(res.body);
    final List list =
        data is Map && data['data'] != null ? data['data'] : (data as List);
    _periods
      ..clear()
      ..addAll(
        list.map(
          (e) => Period(
            id: e['id'] is int ? e['id'] : int.tryParse('${e['id']}') ?? 0,
            name: e['name']?.toString() ?? '—',
          ),
        ),
      );
  }

  Future<void> _fetchClassrooms() async {
    final url = Uri.parse('http://137.184.50.2/api/v1/dashboard/classrooms');
    final res = await http.get(url, headers: _authHeaders());
    debugPrint('Classrooms Status: ${res.statusCode}');
    debugPrint('Classrooms Body: ${res.body}');
    if (res.statusCode != 200) {
      throw Exception('Failed to load classrooms (${res.statusCode})');
    }
    final data = jsonDecode(res.body);
    final List list =
        data is Map && data['data'] != null ? data['data'] : (data as List);
    _classrooms
      ..clear()
      ..addAll(
        list.map(
          (e) => Classroom(
            id: e['id'] is int ? e['id'] : int.tryParse('${e['id']}') ?? 0,
            name: e['name']?.toString() ?? '—',
          ),
        ),
      );
  }

  // ===== Build =====
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Weekly Schedule Initialization',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff4B70F5),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            onPressed: _loading ? null : _bootstrap,
            icon: const Icon(Icons.refresh),
            tooltip: 'Reload lists',
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _loadError != null
              ? _ErrorState(message: _loadError!, onRetry: _bootstrap)
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTeacherAvailabilitySection(),
                      const SizedBox(height: 24),
                      _buildClassroomScheduleSection(),
                      const SizedBox(height: 24),
                      _buildSubmitButton(),
                      const SizedBox(height: 24),
                      _buildGenerateButton(),
                      const SizedBox(height: 12),
                      _buildGeneratedResultCard(),
                    ],
                  ),
                ),
    );
  }

  // ===== Sections =====
  Widget _buildTeacherAvailabilitySection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xff4B70F5), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Teacher Availability',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff4B70F5),
              ),
            ),
            const SizedBox(height: 16),
            ...teacherAvailabilities.asMap().entries.map((entry) {
              final index = entry.key;
              final availability = entry.value;
              return _buildTeacherAvailabilityItem(availability, index);
            }),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed:
                  _teachers.isEmpty || _periods.isEmpty ? null : _addTeacherAvailability,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4B70F5),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Add Teacher'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeacherAvailabilityItem(
    TeacherAvailability availability,
    int index,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xff4B70F5).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: availability.teacherId,
                  decoration: InputDecoration(
                    labelText: 'Teacher',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: _teachers
                      .map(
                        (t) => DropdownMenuItem<int>(
                          value: t.id,
                          child: Text(t.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => availability.teacherId = value!),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeTeacherAvailability(index),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            value: availability.dayOfWeek,
            decoration: InputDecoration(
              labelText: 'Day',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            items: daysOfWeek
                .map(
                  (day) => DropdownMenuItem<String>(
                    value: day,
                    child: Text(_getEnglishDayName(day)),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => availability.dayOfWeek = value!),
          ),
          const SizedBox(height: 12),
          const Text(
            'Available Periods:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Wrap(
            spacing: 8,
            children: _periods.map((p) {
              final isSelected = availability.periodIds.contains(p.id);
              return FilterChip(
                label: Text(p.name),
                selected: isSelected,
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      availability.periodIds.add(p.id);
                    } else {
                      availability.periodIds.remove(p.id);
                    }
                  });
                },
                selectedColor: const Color(0xff4B70F5),
                checkmarkColor: Colors.white,
                labelStyle: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildClassroomScheduleSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Color(0xff4B70F5), width: 2),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Classroom Schedule',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff4B70F5),
              ),
            ),
            const SizedBox(height: 16),
            ...classrooms.asMap().entries.map((entry) {
              final index = entry.key;
              final classroom = entry.value;
              return _buildClassroomScheduleItem(classroom, index);
            }),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _classrooms.isEmpty ? null : _addClassroomSchedule,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4B70F5),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Add Classroom'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassroomScheduleItem(ClassroomSchedule classroom, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xff4B70F5).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  value: classroom.classroomId,
                  decoration: InputDecoration(
                    labelText: 'Classroom',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  items: _classrooms
                      .map(
                        (c) => DropdownMenuItem<int>(
                          value: c.id,
                          child: Text(c.name),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => classroom.classroomId = value!),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeClassroomSchedule(index),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Periods per Day:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          ...daysOfWeek.map((day) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(flex: 2, child: Text(_getEnglishDayName(day))),
                  Expanded(
                    flex: 3,
                    child: TextFormField(
                      initialValue:
                          classroom.periodsPerDay[day]?.toString() ?? '0',
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      onChanged: (value) {
                        classroom.periodsPerDay[day] =
                            int.tryParse(value) ?? 0;
                      },
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(
        onPressed: _submitSchedule,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff4B70F5),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Initialize Schedule',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Widget _buildGenerateButton() {
    return Center(
      child: ElevatedButton.icon(
        onPressed: _generating ? null : _generateSchedule,
        icon: const Icon(Icons.auto_fix_high),
        label: const Text('Generate & Show Schedule (Web)'),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff4B70F5),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildGeneratedResultCard() {
    if (_generating) {
      return const Center(
          child: Padding(
        padding: EdgeInsets.all(16),
        child: CircularProgressIndicator(),
      ));
    }
    if (_generateError != null) {
      return Card(
        color: Colors.red.withOpacity(.06),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            _generateError!,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      );
    }
    if (_generated.isEmpty) return const SizedBox.shrink();

    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Generated Schedule (Web)',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4B70F5))),
            const SizedBox(height: 12),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Day')),
                  DataColumn(label: Text('Section')),
                  DataColumn(label: Text('Subject')),
                  DataColumn(label: Text('Teacher')),
                  DataColumn(label: Text('Period')),
                ],
                rows: _generated
                    .map(
                      (g) => DataRow(
                        cells: [
                          DataCell(Text(_dayEnToTitle(g.dayOfWeek))),
                          DataCell(Text('${g.sectionId}')),
                          DataCell(Text('${g.subjectId}')),
                          DataCell(Text('${g.teacherId}')),
                          DataCell(Text('${g.periodId}')),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ===== Actions =====
  void _addTeacherAvailability() {
    if (_teachers.isEmpty) return;
    setState(() {
      teacherAvailabilities.add(
        TeacherAvailability(
          teacherId: _teachers.first.id,
          dayOfWeek: daysOfWeek.first,
          periodIds: <int>[],
        ),
      );
    });
  }

  void _removeTeacherAvailability(int index) {
    setState(() => teacherAvailabilities.removeAt(index));
  }

  void _addClassroomSchedule() {
    if (_classrooms.isEmpty) return;
    setState(() {
      classrooms.add(
        ClassroomSchedule(
          classroomId: _classrooms.first.id,
          periodsPerDay: {
            'saturday': 0,
            'sunday': 0,
            'monday': 0,
            'tuesday': 0,
            'wednesday': 0,
            'thursday': 0,
          },
        ),
      );
    });
  }

  void _removeClassroomSchedule(int index) {
    setState(() => classrooms.removeAt(index));
  }

  Future<void> _submitSchedule() async {
    final url = Uri.parse(
      'http://137.184.50.2/api/v1/dashboard/schedule/initialize-weekly',
    );

    final requestBody = {
      'teacher_availabilities': teacherAvailabilities.map((availability) {
        return {
          'teacher_id': availability.teacherId,
          'day_of_week': availability.dayOfWeek,
          'period_ids': availability.periodIds,
        };
      }).toList(),
      'classrooms': classrooms.map((classroom) {
        return {
          'classroom_id': classroom.classroomId,
          'periods_per_day': classroom.periodsPerDay,
        };
      }).toList(),
    };

    debugPrint('Sending request: ${jsonEncode(requestBody)}');

    try {
      final response = await http.post(
        url,
        headers: _authHeaders(),
        body: jsonEncode(requestBody),
      );
      debugPrint('Init Status: ${response.statusCode}');
      debugPrint('Init Body: ${response.body}');
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if ((responseData is Map) && responseData['success'] == true) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message']?.toString() ?? 'Success'),
              backgroundColor: Colors.green,
            ),
          );
          _showResults(
              Map<String, dynamic>.from(responseData['data'] as Map? ?? {}));
        } else {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                responseData['message']?.toString() ??
                    'Failed to initialize schedule',
              ),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Server error: ${response.statusCode} — ${response.body}',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _generateSchedule() async {
    setState(() {
      _generating = true;
      _generateError = null;
      _generated = [];
    });

    final url = Uri.parse(
        'http://137.184.50.2/api/v1/dashboard/schedule/generate');

    try {
      final res = await http.get(url, headers: _authHeaders());
      debugPrint('Generate Status: ${res.statusCode}');
      debugPrint('Generate Body: ${res.body}');

      if (res.statusCode != 200) {
        throw Exception('Failed to generate schedule (${res.statusCode})');
      }

      final body = jsonDecode(res.body);
      final success = (body is Map) ? (body['success'] == true) : false;

      if (!success) {
        setState(() =>
            _generateError = (body['message']?.toString() ?? 'Unknown error'));
        return;
      }

      final List raw = (body['schedule'] as List?) ?? const [];
      final list = raw
          .map((e) =>
              GeneratedScheduleItem.fromMap(Map<String, dynamic>.from(e)))
          .toList();

      setState(() => _generated = list);

      if (!mounted) return;

      // Dialog نهائي لعرض ملخص الناتج (تأكيد أن المشروع ويب)
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Generated Schedule (Web)',
              style: TextStyle(color: Color(0xff4B70F5))),
          content: SizedBox(
            width: 480,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: list
                    .map(
                      (g) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Day ${_dayEnToTitle(g.dayOfWeek)} | Section ${g.sectionId} | '
                          'Subject ${g.subjectId} | Teacher ${g.teacherId} | Period ${g.periodId}',
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK',
                  style: TextStyle(color: Color(0xff4B70F5))),
            ),
          ],
        ),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(body['message']?.toString() ?? 'Generated successfully'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      setState(() => _generateError = 'Error: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _generating = false);
    }
  }

  void _showResults(Map<String, dynamic> data) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Schedule Initialization Results',
          style: TextStyle(color: Color(0xff4B70F5)),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Teacher Availability Summary:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...(data['teacher_availability_summary'] as List? ?? const [])
                  .map(
                    (summary) => Text(
                      'Teacher ${summary['teacher_id']} - '
                      '${_getEnglishDayName(summary['day_of_week'])}: '
                      '${summary['count']} periods',
                    ),
                  )
                  .toList(),
              const SizedBox(height: 16),
              const Text(
                'Classroom Schedule Summary:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              ...(data['section_schedules_summary'] as List? ?? const [])
                  .map(
                    (summary) => Text(
                      'Classroom ${summary['classroom_id']}: '
                      '${summary['sections_count']} sections - '
                      '${summary['rows_created']} rows',
                    ),
                  )
                  .toList(),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child:
                const Text('OK', style: TextStyle(color: Color(0xff4B70F5))),
          ),
        ],
      ),
    );
  }
}

// ===== Models =====
class TeacherAvailability {
  int teacherId;
  String dayOfWeek;
  List<int> periodIds;

  TeacherAvailability({
    required this.teacherId,
    required this.dayOfWeek,
    required this.periodIds,
  });
}

class ClassroomSchedule {
  int classroomId;
  Map<String, int> periodsPerDay;

  ClassroomSchedule({required this.classroomId, required this.periodsPerDay});
}

class Teacher {
  final int id;
  final String name;
  Teacher({required this.id, required this.name});
}

class Period {
  final int id;
  final String name;
  Period({required this.id, required this.name});
}

class Classroom {
  final int id;
  final String name;
  Classroom({required this.id, required this.name});
}

class GeneratedScheduleItem {
  final int sectionId;
  final int subjectId;
  final int teacherId;
  final int periodId;
  final String dayOfWeek;

  GeneratedScheduleItem({
    required this.sectionId,
    required this.subjectId,
    required this.teacherId,
    required this.periodId,
    required this.dayOfWeek,
  });

  factory GeneratedScheduleItem.fromMap(Map<String, dynamic> e) {
    int _asInt(dynamic v) => v is int ? v : int.tryParse('$v') ?? 0;
    return GeneratedScheduleItem(
      sectionId: _asInt(e['section_id']),
      subjectId: _asInt(e['subject_id']),
      teacherId: _asInt(e['teacher_id']),
      periodId: _asInt(e['period_id']),
      dayOfWeek: e['day_of_week']?.toString() ?? '',
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, size: 48, color: Colors.red),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            ElevatedButton(onPressed: onRetry, child: const Text('Retry')),
          ],
        ),
      ),
    );
  }
}
