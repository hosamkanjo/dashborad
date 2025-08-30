// import 'package:flutter/material.dart';
// import 'package:dashboard/counters/student_counter.dart';

// class Students extends StatefulWidget {
//   const Students({super.key});

//   @override
//   State<Students> createState() => _AddStudentPageState();
// }

// class _AddStudentPageState extends State<Students> {
//   final _formKey = GlobalKey<FormState>();

//   final firstNameController = TextEditingController();
//   final secondNameController = TextEditingController();
//   final fatherNameController = TextEditingController();
//   final motherNameController = TextEditingController();
//   final motherSecondNameController = TextEditingController();
//   final birthDateController = TextEditingController();
//   final addressController = TextEditingController();
//   final studentPhoneController = TextEditingController();
//   final parentPhoneController = TextEditingController();
//   final landlinePhoneController = TextEditingController();

//   String? selectedGender;
//   String? selectedNationality;
//   String? selectedClass;
//   String? selectedSection;

//   final genders = ['Male', 'Female'];
//   final sections = ['1', '2', '3'];
//   final nationalities = [
//     'Syrian',
//     'Iraqi',
//     'Saudi',
//     'Egyptian',
//     'Jordanian',
//     'Lebanese',
//     'Palestinian',
//   ];
//   final classes = [
//     'class 1',
//     'class 2',
//     'class 3',
//     'class 4',
//     'class 5',
//     'class 6',
//     'class 7',
//     'class 8',
//     'class 9',
//     'class 10',
//     'class 11',
//     'class 12',
//   ];

//   void saveStudent() {
//     if (_formKey.currentState!.validate()) {
//       StudentCounter.count.value++;

//       if (selectedGender != null) {
//         StudentCounter.increment(selectedGender!);
//       }

//       if (selectedClass != null) {
//         final key = selectedClass!.replaceAll('class ', 'Class ');
//         final currentMap = StudentCounter.classCounts.value;
//         currentMap[key] = (currentMap[key] ?? 0) + 1;
//         StudentCounter.classCounts.value = {...currentMap};
//       }
//       ScaffoldMessenger.of(
//         context,
//       ).showSnackBar(const SnackBar(content: Text('Student Saved')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           bool isWide = constraints.maxWidth >= 800;
//           return isWide
//               ? Row(
//                   children: [
//                     Expanded(
//                       flex: 2,
//                       child: _buildFormContent(padding: 32, isWide: true),
//                     ),
//                     Expanded(flex: 1, child: _buildImageSection()),
//                   ],
//                 )
//               : SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       _buildImageSection(height: 400),
//                       _buildFormContent(padding: 16, isWide: false),
//                     ],
//                   ),
//                 );
//         },
//       ),
//     );
//   }

//   Widget _buildFormContent({required double padding, required bool isWide}) {
//     final fields = [
//       _buildTextField('First Name', firstNameController, Icons.person),
//       _buildTextField('Last Name', secondNameController, Icons.person_outline),
//       _buildTextField('Father’s Name', fatherNameController, Icons.man),
//       _buildTextField('Mother’s Name', motherNameController, Icons.woman),
//       _buildTextField(
//         'Mother’s Last Name',
//         motherSecondNameController,
//         Icons.woman,
//       ),
//       _buildDropdown(
//         'Class',
//         classes,
//         selectedClass,
//         (val) => setState(() => selectedClass = val),
//         Icons.class_,
//       ),
//       _buildDropdown(
//         'Section',
//         sections,
//         selectedSection,
//         (val) => setState(() => selectedSection = val),
//         Icons.class_,
//       ),
//       _buildDropdown(
//         'Gender',
//         genders,
//         selectedGender,
//         (val) => setState(() => selectedGender = val),
//         Icons.transgender,
//       ),
//       _buildDropdown(
//         'Nationality',
//         nationalities,
//         selectedNationality,
//         (val) => setState(() => selectedNationality = val),
//         Icons.public,
//       ),
//       _buildTextField(
//         'Date of Birth',
//         birthDateController,
//         Icons.calendar_today,
//       ),
//       _buildTextField('Detailed Address', addressController, Icons.location_on),
//       _buildTextField(
//         'Student Mobile Number',
//         studentPhoneController,
//         Icons.phone_android,
//       ),
//       _buildTextField('Parent Number', parentPhoneController, Icons.phone),
//       _buildTextField(
//         'Landline Phone Number',
//         landlinePhoneController,
//         Icons.phone_android_outlined,
//       ),
//     ];
//     return Padding(
//       padding: EdgeInsets.all(padding),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             const Text(
//               'Add Student',
//               style: TextStyle(
//                 fontSize: 25,
//                 color: Color(0xff4B70F5),
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 25),
//             ..._buildFieldRows(fields, isWide: isWide),
//             const SizedBox(height: 25),
//             ElevatedButton(
//               onPressed: saveStudent,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff4B70F5),
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 40,
//                   vertical: 12,
//                 ),
//               ),
//               child: const Text('Save'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   List<Widget> _buildFieldRows(List<Widget> fields, {required bool isWide}) {
//     List<Widget> rows = [];
//     for (int i = 0; i < fields.length; i += isWide ? 3 : 1) {
//       rows.add(
//         Row(
//           children: List.generate(isWide ? 3 : 1, (j) {
//             int index = i + j;
//             if (index < fields.length) {
//               return Expanded(
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: fields[index],
//                 ),
//               );
//             } else {
//               return const Expanded(child: SizedBox());
//             }
//           }),
//         ),
//       );
//     }
//     return rows;
//   }

//   Widget _buildTextField(
//     String label,
//     TextEditingController controller,
//     IconData icon,
//   ) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: label,
//         hintStyle: const TextStyle(fontSize: 14),
//         prefixIcon: Icon(icon, color: const Color(0xff4B70F5)),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 14,
//         ),
//       ),
//       validator: (value) =>
//           (value == null || value.isEmpty) ? 'Please enter $label' : null,
//     );
//   }

//   Widget _buildDropdown(
//     String label,
//     List<String> items,
//     String? selectedValue,
//     void Function(String?) onChanged,
//     IconData icon,
//   ) {
//     return DropdownButtonFormField<String>(
//       value: selectedValue,
//       decoration: InputDecoration(
//         hintText: label,
//         hintStyle: const TextStyle(fontSize: 14),
//         prefixIcon: Icon(icon, color: const Color(0xff4B70F5)),
//         border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 14,
//         ),
//       ),
//       items: items
//           .map((val) => DropdownMenuItem(value: val, child: Text(val)))
//           .toList(),
//       onChanged: onChanged,
//       validator: (value) =>
//           (value == null || value.isEmpty) ? 'Please select $label' : null,
//     );
//   }

//   Widget _buildImageSection({double? height}) {
//     return SizedBox(
//       height: height,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 115.0),
//         child: Image.asset(
//           'assets/photo_2025-06-14_17-45-23.jpg',
//           width: 350,
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
// }

// // import 'package:flutter/material.dart';
// // import 'package:dashboard/counters/student_counter.dart';

// // class Students extends StatefulWidget {
// //   const Students({super.key});

// //   @override
// //   State<Students> createState() => _AddStudentPageState();
// // }

// // class _AddStudentPageState extends State<Students> {
// //   final _formKey = GlobalKey<FormState>();

// //   final firstNameController = TextEditingController();
// //   final secondNameController = TextEditingController();
// //   final fatherNameController = TextEditingController();
// //   final motherNameController = TextEditingController();
// //   final motherSecondNameController = TextEditingController();
// //   final birthDateController = TextEditingController();
// //   final addressController = TextEditingController();
// //   final studentPhoneController = TextEditingController();
// //   final parentPhoneController = TextEditingController();
// //   final landlinePhoneController = TextEditingController();

// //   String? selectedGender;
// //   String? selectedNationality;
// //   String? selectedClass;

// //   final genders = ['Male', 'Female'];
// //   final nationalities = [
// //     'Syrian',
// //     'Iraqi',
// //     'Saudi',
// //     'Egyptian',
// //     'Jordanian',
// //     'Lebanese',
// //     'Palestinian'
// //   ];
// //   final classes = [
// //     'class 1',
// //     'class 2',
// //     'class 3',
// //     'class 4',
// //     'class 5',
// //     'class 6',
// //     'class 7',
// //     'class 8',
// //     'class 9',
// //     'class 10',
// //     'class 11',
// //     'class 12'
// //   ];

// //   void saveStudent() {
// //     if (_formKey.currentState!.validate()) {
// //       StudentCounter.count.value++;

// //       if (selectedGender != null) {
// //         StudentCounter.increment(selectedGender!);
// //       }

// //       if (selectedClass != null) {
// //         // تحديث عدد الصفوف في Dashboard
// //         final key = selectedClass!.replaceAll('class ', 'Class ');
// //         final currentMap = StudentCounter.classCounts.value;
// //         currentMap[key] = (currentMap[key] ?? 0) + 1;
// //         StudentCounter.classCounts.value = {...currentMap}; // إعادة التحديث

// //         // إذا كنت تستخدم أيضاً مخطط داخلي في الصفحة
// //         // يمكنك إضافة كود مماثل هنا إن لزم الأمر
// //       }
// //       ScaffoldMessenger.of(context)
// //           .showSnackBar(const SnackBar(content: Text('Student Saved')));
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.white,
// //       body: LayoutBuilder(builder: (context, constraints) {
// //         bool isWide = constraints.maxWidth >= 800;
// //         return isWide
// //             ? Row(
// //                 children: [
// //                   Expanded(
// //                     flex: 2,
// //                     child: _buildFormContent(padding: 32, isWide: true),
// //                   ),
// //                   Expanded(
// //                     flex: 1,
// //                     child: _buildImageSection(),
// //                   ),
// //                 ],
// //               )
// //             : SingleChildScrollView(
// //                 child: Column(
// //                   children: [
// //                     _buildImageSection(height: 400),
// //                     _buildFormContent(padding: 16, isWide: false),
// //                   ],
// //                 ),
// //               );
// //       }),
// //     );
// //   }

// //   Widget _buildFormContent({required double padding, required bool isWide}) {
// //     final fields = [
// //       _buildTextField('First Name', firstNameController, Icons.person),
// //       _buildTextField('Last Name', secondNameController, Icons.person_outline),
// //       _buildTextField('Father’s Name', fatherNameController, Icons.man),
// //       _buildTextField('Mother’s Name', motherNameController, Icons.woman),
// //       _buildTextField(
// //           'Mother’s Last Name', motherSecondNameController, Icons.woman),
// //       _buildDropdown('Class', classes, selectedClass,
// //           (val) => setState(() => selectedClass = val), Icons.class_),
// //       _buildDropdown('Gender', genders, selectedGender,
// //           (val) => setState(() => selectedGender = val), Icons.transgender),
// //       _buildDropdown('Nationality', nationalities, selectedNationality,
// //           (val) => setState(() => selectedNationality = val), Icons.public),
// //       _buildTextField(
// //           'Date of Birth', birthDateController, Icons.calendar_today),
// //       _buildTextField('Detailed Address', addressController, Icons.location_on),
// //       _buildTextField(
// //           'Student Mobile Number', studentPhoneController, Icons.phone_android),
// //       _buildTextField('Parent Number', parentPhoneController, Icons.phone),
// //       _buildTextField('Landline Phone Number', landlinePhoneController,
// //           Icons.phone_android_outlined),
// //     ];
// //     return Padding(
// //       padding: EdgeInsets.all(padding),
// //       child: Form(
// //         key: _formKey,
// //         child: Column(
// //           children: [
// //             const Text('Add Student',
// //                 style: TextStyle(
// //                     fontSize: 25,
// //                     color: Color(0xff4B70F5),
// //                     fontWeight: FontWeight.bold)),
// //             const SizedBox(height: 25),
// //             ..._buildFieldRows(fields, isWide: isWide),
// //             const SizedBox(height: 25),
// //             ElevatedButton(
// //               onPressed: saveStudent,
// //               style: ElevatedButton.styleFrom(
// //                 backgroundColor: const Color(0xff4B70F5),
// //                 padding:
// //                     const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
// //               ),
// //               child: const Text('Save'),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }

// //   List<Widget> _buildFieldRows(List<Widget> fields, {required bool isWide}) {
// //     List<Widget> rows = [];
// //     for (int i = 0; i < fields.length; i += isWide ? 3 : 1) {
// //       rows.add(
// //         Row(
// //           children: List.generate(isWide ? 3 : 1, (j) {
// //             int index = i + j;
// //             if (index < fields.length) {
// //               return Expanded(
// //                 child: Padding(
// //                   padding: const EdgeInsets.all(8.0),
// //                   child: fields[index],
// //                 ),
// //               );
// //             } else {
// //               return const Expanded(child: SizedBox());
// //             }
// //           }),
// //         ),
// //       );
// //     }
// //     return rows;
// //   }

// //   Widget _buildTextField(
// //       String label, TextEditingController controller, IconData icon) {
// //     return TextFormField(
// //       controller: controller,
// //       decoration: InputDecoration(
// //         hintText: label,
// //         hintStyle: const TextStyle(fontSize: 14),
// //         prefixIcon: Icon(icon, color: const Color(0xff4B70F5)),
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         filled: true,
// //         fillColor: Colors.white,
// //         contentPadding:
// //             const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //       ),
// //       validator: (value) =>
// //           (value == null || value.isEmpty) ? 'Please enter $label' : null,
// //     );
// //   }

// //   Widget _buildDropdown(String label, List<String> items, String? selectedValue,
// //       void Function(String?) onChanged, IconData icon) {
// //     return DropdownButtonFormField<String>(
// //       value: selectedValue,
// //       decoration: InputDecoration(
// //         hintText: label,
// //         hintStyle: const TextStyle(fontSize: 14),
// //         prefixIcon: Icon(icon, color: const Color(0xff4B70F5)),
// //         border: OutlineInputBorder(
// //           borderRadius: BorderRadius.circular(12),
// //         ),
// //         filled: true,
// //         fillColor: Colors.white,
// //         contentPadding:
// //             const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
// //       ),
// //       items: items
// //           .map((val) => DropdownMenuItem(value: val, child: Text(val)))
// //           .toList(),
// //       onChanged: onChanged,
// //       validator: (value) =>
// //           (value == null || value.isEmpty) ? 'Please select $label' : null,
// //     );
// //   }

// //   Widget _buildImageSection({double? height}) {
// //     return SizedBox(
// //       height: height,
// //       child: Padding(
// //         padding: const EdgeInsets.only(bottom: 115.0),
// //         child: Image.asset(
// //           'assets/photo_2025-06-14_17-45-23.jpg',
// //           width: 350,
// //           fit: BoxFit.contain,
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'package:dashboard/main.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class Students extends StatefulWidget {
//   @override
//   State<Students> createState() => _AddStudentPageState();
// }

// class _AddStudentPageState extends State<Students> {
//   final _formKey = GlobalKey<FormState>();

//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final fatherNameController = TextEditingController();
//   final motherNameController = TextEditingController();
//   final fatherPhoneNumberController = TextEditingController();
//   final motherPhoneNumberController = TextEditingController();
//   final birthDateController = TextEditingController();
//   final addressController = TextEditingController();
//   final studentEmailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final fatherWorkController = TextEditingController();
//   final motherWorkController = TextEditingController();

//   String? selectedGender;
//   String? selectedSection;
//   String? selectedClass;
//   String? selectedStage;





//   final genders = ['Male', 'Female'];
//   final sections = ['1', '2', '3'];
//   final classes = ['1','2','3','4','5','6','7','8','9','10','11','12'];
//   final stages = ['1', '2', '3'];

//   Future<void> saveStudent() async {
//     if (_formKey.currentState!.validate()) {
//       final url = Uri.parse("http://137.184.50.2/api/v1/dashboard/student");
 
//       final body = {
//         "first_name": firstNameController.text,
//         "last_name": lastNameController.text,
//         "email": studentEmailController.text,
//         "password": passwordController.text,
//         "stage_id": selectedStage ?? "",
//         "classroom_id": selectedClass ?? "",
//         "section_id": selectedSection ?? "",
//         "gender": selectedGender ?? "",
//         "father_name": fatherNameController.text,
//         "mother_name": motherNameController.text,
//         // "father_work": fatherWorkController.text,
//         // "mother_work": motherWorkController.text,
//         "father_number": fatherPhoneNumberController.text,
//         "mother_number": motherPhoneNumberController.text,
//         "birth_day": birthDateController.text,
//         "location": addressController.text,
//       };

//       /*
      
      
//  'email' ,
// 'password',
// 'first_name',
// 'last_name',
// 'father_name',
// 'mother_name',
// 'gender',
// 'birth_day',
// 'location',
// 'father_number',
// 'mother_number',
// 'section_id' ,

      
      
      
      
      
      
//        */

//       final token = storage.getString('token');
//       try {
//         final response = await http.post(
//           url,
//           headers: {
//             'Authorization': 'Bearer $token',
//             "Content-Type": "application/json",
//             "Accept": "application/json",
//           },
//           body: jsonEncode(body),
//         );

//         print("STATUS CODE: ${response.statusCode}");
//         print("RAW RESPONSE: ${response.body}");

//         if (response.headers["content-type"]?.contains("application/json") == true) {
//           final data = jsonDecode(response.body);

//           if (data["success"] == true) {
//             final student = data["data"]["student"];
//             final userAccount = data["data"]["user_account"];

//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(data["message"] ?? "Student created")),
//             );

//             print("✅ Student ID: ${student["id"]}");
//             print("📧 Email: ${userAccount["email"]}");
//           } else {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(data["message"] ?? "Failed to create student")),
//             );
//             print("❌ Error: ${data["error"]}");
//           }
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text("Server did not return JSON, check logs.")),
//           );
//         }
//       } catch (e) {
//         print("ERROR: $e");
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Error: $e")),
//         );
//       }
//     }
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             children: [
//               const Text(
//                 'Add Student',
//                 style: TextStyle(
//                   fontSize: 25,
//                   color: Color(0xff4B70F5),
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               _buildTextField('First Name', firstNameController),
//               _buildTextField('Last Name', lastNameController),
//               _buildTextField('Father’s Name', fatherNameController),
//               _buildTextField('Mother’s Name', motherNameController),
//               // _buildTextField('Father Work', fatherWorkController),
//               // _buildTextField('Mother Work', motherWorkController),
//               _buildTextField('Father Phone', fatherPhoneNumberController),
//               _buildTextField('Mother Phone', motherPhoneNumberController),
//               _buildTextField('Date of Birth (yyyy-mm-dd)', birthDateController),
//               _buildTextField('Location', addressController),
//               _buildTextField('Email', studentEmailController),
//               _buildTextField('Password', passwordController, isPassword: true),
//               _buildDropdown('Gender', genders, selectedGender, (val) => setState(() => selectedGender = val)),
//               _buildDropdown('Stage', stages, selectedStage, (val) => setState(() => selectedStage = val)),
//               _buildDropdown('Class', classes, selectedClass, (val) => setState(() => selectedClass = val)),
//               _buildDropdown('Section', sections, selectedSection, (val) => setState(() => selectedSection = val)),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: saveStudent,
//                 child: const Text("Save"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: TextFormField(
//         controller: controller,
//         obscureText: isPassword,
//         validator: (value) => (value == null || value.isEmpty) ? "Please enter $label" : null,
//         decoration: InputDecoration(
//           hintText: label,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//       ),
//     );
//   }

//   Widget _buildDropdown(String label, List<String> items, String? selectedValue, void Function(String?) onChanged) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: DropdownButtonFormField<String>(
//         value: selectedValue,
//         decoration: InputDecoration(
//           hintText: label,
//           border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
//         ),
//         items: items.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
//         onChanged: onChanged,
//         validator: (value) => (value == null ||  value.isEmpty) ? "Please select $label" : null,
//       ),
//     );
//   }
// }



import 'dart:convert';
import 'package:dashboard/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Students extends StatefulWidget {
  @override
  State<Students> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<Students> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();
  final fatherPhoneNumberController = TextEditingController();
  final motherPhoneNumberController = TextEditingController();
  final birthDateController = TextEditingController();
  final addressController = TextEditingController();
  final studentEmailController = TextEditingController();
  final passwordController = TextEditingController();
  final fatherWorkController = TextEditingController();
  final motherWorkController = TextEditingController();

  String? selectedGender;
  String? selectedSection;
  String? selectedClass;
  String? selectedStage;

  final genders = ['Male', 'Female'];

  List<Stage> stages = [];
  List<Classroom> classrooms = [];
  List<Section> sections = [];

  @override
  void initState() {
    super.initState();
    fetchStages();
  }

  Future<void> fetchStages() async {
    final token = storage.getString('token');
    final url = Uri.parse("http://137.184.50.2/api/v1/dashboard/get-stages");
    
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data["success"] == true) {
          setState(() {
            stages = (data["data"] as List)
                .map((stageJson) => Stage.fromJson(stageJson))
                .toList();
          });
        }
      }
    } catch (e) {
      print("Error fetching stages: $e");
    }
  }

  void updateClassrooms(String stageId) {
    final stage = stages.firstWhere((s) => s.id == stageId, orElse: () => Stage(id: '', name: '', classrooms: []));
    setState(() {
      classrooms = stage.classrooms;
      sections = []; // Reset sections when stage changes
      selectedClass = null;
      selectedSection = null;
    });
  }

  void updateSections(String classroomId) {
    final classroom = classrooms.firstWhere((c) => c.id == classroomId, orElse: () => Classroom(id: '', name: '', subjects: [], sections: []));
    setState(() {
      sections = classroom.sections;
      selectedSection = null;
    });
  }

  Future<void> saveStudent() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse("http://137.184.50.2/api/v1/dashboard/student");
 
      final body = {
        "first_name": firstNameController.text,
        "last_name": lastNameController.text,
        "email": studentEmailController.text,
        "password": passwordController.text,
        "stage_id": selectedStage ?? "",
        "classroom_id": selectedClass ?? "",
        "section_id": selectedSection ?? "",
        "gender": selectedGender ?? "",
        "father_name": fatherNameController.text,
        "mother_name": motherNameController.text,
        "father_number": fatherPhoneNumberController.text,
        "mother_number": motherPhoneNumberController.text,
        "birth_day": birthDateController.text,
        "location": addressController.text,
      };

      final token = storage.getString('token');
      try {
        final response = await http.post(
          url,
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(body),
        );

        print("STATUS CODE: ${response.statusCode}");
        print("RAW RESPONSE: ${response.body}");
        if (response.headers["content-type"]?.contains("application/json") == true) {
          final data = jsonDecode(response.body);

          if (data["success"] == true) {
            final student = data["data"]["student"];
            final userAccount = data["data"]["user_account"];

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data["message"] ?? "Student created")),
            );
            print("✅ Student ID: ${student["id"]}");
            print("📧 Email: ${userAccount["email"]}");
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(data["message"] ?? "Failed to create student")),
            );
            print("❌ Error: ${data["error"]}");
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Server did not return JSON, check logs.")),
          );
        }
      } catch (e) {
        print("ERROR: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Add Student',
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xff4B70F5),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              _buildTextField('First Name', firstNameController),
              _buildTextField('Last Name', lastNameController),
              _buildTextField('Father’s Name', fatherNameController),
              _buildTextField('Mother’s Name', motherNameController),
              _buildTextField('Father Phone', fatherPhoneNumberController),
              _buildTextField('Mother Phone', motherPhoneNumberController),
              _buildTextField('Date of Birth (yyyy-mm-dd)', birthDateController),
              _buildTextField('Location', addressController),
              _buildTextField('Email', studentEmailController),
              _buildTextField('Password', passwordController, isPassword: true),
              _buildDropdown('Gender', genders, selectedGender, (val) => setState(() => selectedGender = val)),
              
              // Dropdowns الديناميكية
              _buildStageDropdown(),
              _buildClassDropdown(),
              _buildSectionDropdown(),
              
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: saveStudent,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        validator: (value) => (value == null || value.isEmpty) ? "Please enter $label" : null,
        decoration: InputDecoration(
          hintText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selectedValue, void Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedValue,
        decoration: InputDecoration(
          hintText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: items.map((val) => DropdownMenuItem(value: val, child: Text(val))).toList(),
        onChanged: onChanged,
        validator: (value) => (value == null || value.isEmpty) ? "Please select $label" : null,
      ),
    );
  }

  Widget _buildStageDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedStage,
        decoration: InputDecoration(
          hintText: 'Stage',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: stages.map((stage) => DropdownMenuItem(
          value: stage.id,
          child: Text(stage.name),
        )).toList(),
        onChanged: (value) {
          setState(() {
            selectedStage = value;
            updateClassrooms(value!);
          });
        },
        validator: (value) => value == null ? "Please select Stage" : null,
      ),
    );
  }

  Widget _buildClassDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedClass,
        decoration: InputDecoration(
          hintText: 'Class',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: classrooms.map((classroom) => DropdownMenuItem(
          value: classroom.id,
          child: Text(classroom.name),
        )).toList(),
        onChanged: (value) {
          setState(() {
            selectedClass = value;
            updateSections(value!);
          });
        },
        validator: (value) => value == null ? "Please select Class" : null,
      ),
    );
  }

  Widget _buildSectionDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedSection,
        decoration: InputDecoration(
          hintText: 'Section',
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        items: sections.map((section) => DropdownMenuItem(
          value: section.id,
          child: Text(section.name),
        )).toList(),
        onChanged: (value) {
          setState(() {
            selectedSection = value;
          });
        },
        validator: (value) => value == null ? "Please select Section" : null,
      ),
    );
  }
}

// نموذج البيانات
class Stage {
  final String id;
  final String name;
  final List<Classroom> classrooms;

  Stage({required this.id, required this.name, required this.classrooms});

  factory Stage.fromJson(Map<String, dynamic> json) {
    return Stage(
      id: json['id'].toString(),
      name: json['name'],
      classrooms: (json['classrooms'] as List)
          .map((classroomJson) => Classroom.fromJson(classroomJson))
          .toList(),
    );
  }
}

class Classroom {
  final String id;
  final String name;
  final List<Subject> subjects;
  final List<Section> sections;

  Classroom({required this.id, required this.name, required this.subjects, required this.sections});

  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      id: json['id'].toString(),
      name: json['name'],
      subjects: (json['subjects'] as List)
          .map((subjectJson) => Subject.fromJson(subjectJson))
          .toList(),
      sections: (json['sections'] as List)
          .map((sectionJson) => Section.fromJson(sectionJson))
          .toList(),
    );
  }
}

class Subject {
  final String id;
  final String name;
  final int? amount;

  Subject({required this.id, required this.name, this.amount});

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['id'].toString(),
      name: json['name'],
      amount: json['amount'],
    );
  }
}

class Section {
  final String id;
  final String name;

  Section({required this.id, required this.name});
  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      id: json['id'].toString(),
      name: json['name'],
    );
  }
}