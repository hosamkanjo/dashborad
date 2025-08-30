// import 'package:dashboard/counters/teacher_counter.dart';
// import 'package:flutter/material.dart';

// class Teachers extends StatefulWidget {
//   const Teachers({super.key});

//   @override
//   State<Teachers> createState() => _TeachersPageState();
// }

// class _TeachersPageState extends State<Teachers> {
//   final _formKey = GlobalKey<FormState>();

//   final firstNameController = TextEditingController();
//   final secondNameController = TextEditingController();
//   final fatherNameController = TextEditingController();
//   final motherNameController = TextEditingController();
//   final motherSecondNameController = TextEditingController();
//   final birthDateController = TextEditingController();
//   final addressController = TextEditingController();
//   final teacherPhoneController = TextEditingController();
//   final landlinePhoneController = TextEditingController();

//   String? selectedGender;
//   String? selectedSubject;

//   final genders = ['Male', 'Female'];
//   final List<String> subjects = [
//     'Physics',
//     'Chemistry',
//     'Mathematics',
//     'Science',
//     'Arabic',
//     'English',
//     'France',
//     'Art',
//     'Music'
//   ];

//   void saveTeachers() {
//     if (_formKey.currentState!.validate()) {
//       TeacherCounter.count1.value++;
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Teacher Saved')));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: LayoutBuilder(builder: (context, constraints) {
//         bool isWide = constraints.maxWidth >= 800;
//         return isWide
//             ? Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: _buildFormContent(padding: 32, isWide: true),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: _buildImageSection(),
//                   ),
//                 ],
//               )
//             : SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     _buildImageSection(height: 200),
//                     _buildFormContent(padding: 16, isWide: false),
//                   ],
//                 ),
//               );
//       }),
//     );
//   }

//   Widget _buildFormContent({required double padding, required bool isWide}) {
//     final fields = [
//       _buildTextField('First Name', firstNameController, Icons.person),
//       _buildTextField('Last Name', secondNameController, Icons.person_outline),
//       _buildTextField('Father’s Name', fatherNameController, Icons.man),
//       _buildTextField('Mother’s Name', motherNameController, Icons.woman),
//       _buildTextField(
//           'Mother’s Last Name', motherSecondNameController, Icons.woman),
//       _buildDropdown('Subject', subjects, selectedSubject,
//           (val) => setState(() => selectedSubject = val), Icons.class_),
//       _buildDropdown('Gender', genders, selectedGender,
//           (val) => setState(() => selectedGender = val), Icons.transgender),
//       _buildTextField(
//           'Date of Birth', birthDateController, Icons.calendar_today),
//       _buildTextField('Detailed Address', addressController, Icons.location_on),
//       _buildTextField(
//           'Teacher Mobile Number', teacherPhoneController, Icons.phone_android),
//       _buildTextField(
//           'Landline Phone Number', landlinePhoneController, Icons.phone),
//     ];

//     return Padding(
//       padding: EdgeInsets.all(padding),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             const Text('Add Teachers',
//                 style: TextStyle(
//                     fontSize: 25,
//                     color: Color(0xff4B70F5),
//                     fontWeight: FontWeight.bold)),
//             const SizedBox(height: 25),
//             ..._buildFieldRows(fields, isWide: isWide),
//             const SizedBox(height: 25),
//             ElevatedButton(
//               onPressed: saveTeachers,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff4B70F5),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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
//       String label, TextEditingController controller, IconData icon) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: label,
//         hintStyle: const TextStyle(fontSize: 14),
//         prefixIcon: Icon(icon, color: const Color(0xff4B70F5)),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       ),
//       validator: (value) =>
//           (value == null || value.isEmpty) ? 'Please enter $label' : null,
//     );
//   }

//   Widget _buildDropdown(String label, List<String> items, String? selectedValue,
//       void Function(String?) onChanged, IconData icon) {
//     return DropdownButtonFormField<String>(
//       value: selectedValue,
//       decoration: InputDecoration(
//         hintText: label,
//         hintStyle: const TextStyle(fontSize: 14),
//         prefixIcon: Icon(icon, color: const Color(0xff4B70F5)),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
//         padding: const EdgeInsets.only(bottom: 160.0),
//         child: Image.asset(
//           'assets/photo_2025-06-16_16-04-47.jpg',
//           width: 350,
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
// }


// import 'package:dashboard/counters/teacher_counter.dart';
// import 'package:dashboard/main.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Teachers extends StatefulWidget {
//   const Teachers({super.key});

//   @override
//   State<Teachers> createState() => _TeachersPageState();
// }

// class _TeachersPageState extends State<Teachers> {
//   final _formKey = GlobalKey<FormState>();

//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();
//   final phoneController = TextEditingController();
//   final List<Map<String, int>> sectionSubjects = [
//     {"section_id": 2, "subject_id": 3},
//     {"section_id": 3, "subject_id": 2}
//   ];

//   Future<void> saveTeachers() async {
//     if (_formKey.currentState!.validate()) {
//       try {
  
//         final Map<String, dynamic> requestData = {
//           "first_name": firstNameController.text,
//           "last_name": lastNameController.text,
//           "email": emailController.text,
//           "password": passwordController.text,
//           "phone": phoneController.text,
//           "section_subjects": sectionSubjects,
//         };
//           final token = storage.getString('token');
//         // إرسال الطلب إلى API
//         final response = await http.post(
//           Uri.parse('http://137.184.50.2/api/v1/dashboard/teacher'),
//           headers: <String, String>{

//              'Authorization': 'Bearer $token', 
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//           },
//           body: jsonEncode(requestData),
//         );
//    print(' Response Status: ${response.statusCode}');
//     print(' Response Data: ${response.body}');

//         // التحقق من نجاح العملية
//         if (response.statusCode == 200 || response.statusCode == 201) {
//           TeacherCounter.count1.value++;
//           ScaffoldMessenger.of(context)
//               .showSnackBar(const SnackBar(content: Text('Teacher Saved Successfully')));
          
//           // مسح الحقول بعد الحفظ الناجح
//           firstNameController.clear();
//           lastNameController.clear();
//           emailController.clear();
//           passwordController.clear();
//           phoneController.clear();
//         } else {
//           // في حالة وجود خطأ من الخادم
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Error: ${response.statusCode} - ${response.body}')),
//           );
//         }
//       } catch (e) {
//         // في حالة وجود خطأ في الاتصال
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Connection Error: $e')),
//         );
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: LayoutBuilder(builder: (context, constraints) {
//         bool isWide = constraints.maxWidth >= 800;
//         return isWide
//             ? Row(
//                 children: [
//                   Expanded(
//                     flex: 2,
//                     child: _buildFormContent(padding: 32, isWide: true),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: _buildImageSection(),
//                   ),
//                 ],
//               )
//             : SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     _buildImageSection(height: 200),
//                     _buildFormContent(padding: 16, isWide: false),
//                   ],
//                 ),
//               );
//       }),
//     );
//   }

//   Widget _buildFormContent({required double padding, required bool isWide}) {
//     final fields = [
//       _buildTextField('First Name', firstNameController, Icons.person, TextInputType.name),
//       _buildTextField('Last Name', lastNameController, Icons.person_outline, TextInputType.name),
//       _buildTextField('Email', emailController, Icons.email, TextInputType.emailAddress),
//       _buildTextField('Password', passwordController, Icons.lock, TextInputType.visiblePassword, isPassword: true),
//       _buildTextField('Phone Number', phoneController, Icons.phone, TextInputType.phone),
//     ];return Padding(
//       padding: EdgeInsets.all(padding),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             const Text('Add New Teacher',
//                 style: TextStyle(
//                     fontSize: 25,
//                     color: Color(0xff4B70F5),
//                     fontWeight: FontWeight.bold)),
//             const SizedBox(height: 25),
//             ..._buildFieldRows(fields, isWide: isWide),
//             const SizedBox(height: 25),
//             ElevatedButton(
//               onPressed: saveTeachers,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff4B70F5),
//                 padding:
//                     const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
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
//     for (int i = 0; i < fields.length; i += isWide ? 2 : 1) {
//       rows.add(
//         Row(
//           children: List.generate(isWide ? 2 : 1, (j) {
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
//       String label, TextEditingController controller, IconData icon, TextInputType keyboardType,
//       {bool isPassword = false}) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       obscureText: isPassword,
//       decoration: InputDecoration(
//         hintText: label,
//         hintStyle: const TextStyle(fontSize: 14),
//         prefixIcon: Icon(icon, color: const Color(0xff4B70F5)),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter $label';
//         }
        
//         // تحقق إضافي للإيميل
//         if (label.toLowerCase().contains('email') && !value.contains('@')) {
//           return 'Please enter a valid email';
//         }
        
//         // تحقق إضافي للهاتف
//         if (label.toLowerCase().contains('phone') && value.length < 10) {
//           return 'Please enter a valid phone number';
//         }
        
//         // تحقق إضافي لكلمة السر
//         if (label.toLowerCase().contains('password') && value.length < 6) {
//           return 'Password must be at least 6 characters';
//         }
        
//         return null;
//       },
//     );
//   }

//   Widget _buildImageSection({double? height}) {
//     return SizedBox(
//       height: height,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 160.0),
//         child: Image.asset(
//           'assets/photo_2025-06-16_16-04-47.jpg',
//           width: 350,
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
// }
import 'package:dashboard/counters/teacher_counter.dart';
import 'package:dashboard/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Teachers extends StatefulWidget {
  const Teachers({super.key});

  @override
  State<Teachers> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<Teachers> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();


  List<dynamic> _stages = [];
  dynamic _selectedStage;
  dynamic _selectedClassroom;

  
  List<int> selectedSectionIds = [];
  List<int> selectedSubjectIds = [];

  @override
  void initState() {
    super.initState();
    fetchStages();
  }

  Future<void> fetchStages() async {
    final token = storage.getString('token');
    try {
      final response = await http.get(
        Uri.parse("http://137.184.50.2/api/v1/dashboard/get-stages"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );
          
      print(' Response Status: ${response.statusCode}');
      print(' Response Data: ${response.body}');


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _stages = data["data"];
        });
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Failed to load stages")));
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> saveTeachers() async {
    if (_formKey.currentState!.validate()) {
      try {
        // تجهيز section_subjects
        List<Map<String, int>> sectionSubjects = [];
        for (var sectionId in selectedSectionIds) {
          for (var subjectId in selectedSubjectIds) {
            sectionSubjects.add({
              "section_id": sectionId,
              "subject_id": subjectId,
            });
          }
        }

        final Map<String, dynamic> requestData = {
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "email": emailController.text,
          "password": passwordController.text,
          "phone": phoneController.text,
          "section_subjects": sectionSubjects,
        };

        final token = storage.getString('token');
        final response = await http.post(
          Uri.parse("http://137.184.50.2/api/v1/dashboard/teacher"),
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
          body: jsonEncode(requestData),
        );

        print("Response Status: ${response.statusCode}");
        print("Response Data: ${response.body}");

        if (response.statusCode == 200 || response.statusCode == 201) {
          TeacherCounter.count1.value++;
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Teacher Saved Successfully")));

          // مسح كلشي
          firstNameController.clear();
          lastNameController.clear();
          emailController.clear();
          passwordController.clear();
          phoneController.clear();
          setState(() {
            _selectedStage = null;
            _selectedClassroom = null;
            selectedSectionIds.clear();
            selectedSubjectIds.clear();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Error: ${response.statusCode} - ${response.body}")));
        }
      } catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Connection Error: $e")));
      }
    }
  }@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        bool isWide = constraints.maxWidth >= 800;
        return isWide
            ? Row(
                children: [
                  Expanded(
                      flex: 2, child: _buildFormContent(padding: 32, isWide: true)),
                  Expanded(flex: 1, child: _buildImageSection()),
                ],
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    _buildImageSection(height: 200),
                    _buildFormContent(padding: 16, isWide: false),
                  ],
                ),
              );
      }),
    );
  }

  Widget _buildFormContent({required double padding, required bool isWide}) {
    final fields = [
      _buildTextField("First Name", firstNameController, Icons.person,
          TextInputType.name),
      _buildTextField("Last Name", lastNameController, Icons.person_outline,
          TextInputType.name),
      _buildTextField("Email", emailController, Icons.email,
          TextInputType.emailAddress),
      _buildTextField("Password", passwordController, Icons.lock,
          TextInputType.visiblePassword,
          isPassword: true),
      _buildTextField(
          "Phone Number", phoneController, Icons.phone, TextInputType.phone),
      _buildStageDropdown(),
      if (_selectedStage != null) _buildClassroomDropdown(),
      if (_selectedClassroom != null) _buildSectionSelector(),
      if (_selectedClassroom != null) _buildSubjectSelector(),
    ];

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text("Add New Teacher",
                style: TextStyle(
                    fontSize: 25,
                    color: Color(0xff4B70F5),
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 25),
            ..._buildFieldRows(fields, isWide: isWide),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: saveTeachers,
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff4B70F5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 12)),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageDropdown() {
    return DropdownButtonFormField<dynamic>(
      value: _selectedStage,
      decoration: const InputDecoration(
          labelText: "Select Stage", border: OutlineInputBorder()),
      items: _stages
          .map((stage) => DropdownMenuItem(
                value: stage,
                child: Text(stage["name"]),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedStage = value;
          _selectedClassroom = null;
          selectedSectionIds.clear();
          selectedSubjectIds.clear();
        });
      },
    );
  }

  Widget _buildClassroomDropdown() {
    List classrooms = _selectedStage["classrooms"];
    return DropdownButtonFormField<dynamic>(
      value: _selectedClassroom,
      decoration: const InputDecoration(
          labelText: "Select Classroom", border: OutlineInputBorder()),
      items: classrooms
          .map((c) => DropdownMenuItem(
                value: c,
                child: Text(c["name"]),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedClassroom = value;
          selectedSectionIds.clear();
          selectedSubjectIds.clear();
        });
      },
    );
  }Widget _buildSectionSelector() {
    List sections = _selectedClassroom["sections"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Sections:"),
        ...sections.map((s) => CheckboxListTile(
              title: Text(s["name"]),
              value: selectedSectionIds.contains(s["id"]),
              onChanged: (checked) {
                setState(() {
                  if (checked == true) {
                    selectedSectionIds.add(s["id"]);
                  } else {
                    selectedSectionIds.remove(s["id"]);
                  }
                });
              },
            )),
      ],
    );
  }

  Widget _buildSubjectSelector() {
    List subjects = _selectedClassroom["subjects"];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Select Subjects:"),
        ...subjects.map((sub) => CheckboxListTile(
              title: Text(sub["name"]),
              value: selectedSubjectIds.contains(sub["id"]),
              onChanged: (checked) {
                setState(() {
                  if (checked == true) {
                    selectedSubjectIds.add(sub["id"]);
                  } else {
                    selectedSubjectIds.remove(sub["id"]);
                  }
                });
              },
            )),
      ],
    );
  }

  List<Widget> _buildFieldRows(List<Widget> fields, {required bool isWide}) {
    List<Widget> rows = [];
    for (int i = 0; i < fields.length; i += isWide ? 2 : 1) {
      rows.add(Row(
        children: List.generate(isWide ? 2 : 1, (j) {
          int index = i + j;
          if (index < fields.length) {
            return Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: fields[index],
            ));
          } else {
            return const Expanded(child: SizedBox());
          }
        }),
      ));
    }
    return rows;
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon,
      TextInputType keyboardType,
      {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xff4B70F5)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please enter $label";
        }
        if (label.toLowerCase().contains("email") && !value.contains("@")) {
          return "Please enter a valid email";
        }
        if (label.toLowerCase().contains("phone") && value.length < 10) {
          return "Please enter a valid phone number";
        }
        if (label.toLowerCase().contains("password") && value.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
    );
  }

  Widget _buildImageSection({double? height}) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 160.0),
        child: Image.asset(
          "assets/photo_2025-06-16_16-04-47.jpg",
          width: 350,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}