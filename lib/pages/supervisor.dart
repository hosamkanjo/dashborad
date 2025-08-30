// import 'package:dashboard/counters/employee_counter.dart';
// import 'package:flutter/material.dart';

// class Employees extends StatefulWidget {
//   const Employees({super.key});

//   @override
//   State<Employees> createState() => _EmployeesPageState();
// }

// class _EmployeesPageState extends State<Employees> {
//   final _formKey = GlobalKey<FormState>();

//   final firstNameController = TextEditingController();
//   final secondNameController = TextEditingController();
//   final fatherNameController = TextEditingController();
//   final motherNameController = TextEditingController();
//   final motherSecondNameController = TextEditingController();
//   final birthDateController = TextEditingController();
//   final addressController = TextEditingController();
//   final employeePhoneController = TextEditingController();
//   final landlinePhoneController = TextEditingController();

//   String? selectedGender;

//   final genders = ['Male', 'Female'];

//   void saveEmployees() {
//     if (_formKey.currentState!.validate()) {
//       EmployeeCounter.count2.value++;
//       ScaffoldMessenger.of(context)
//           .showSnackBar(const SnackBar(content: Text('Employee Saved')));
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
//       _buildDropdown('Gender', genders, selectedGender,
//           (val) => setState(() => selectedGender = val), Icons.transgender),
//       _buildTextField(
//           'Date of Birth', birthDateController, Icons.calendar_today),
//       _buildTextField('Detailed Address', addressController, Icons.location_on),
//       _buildTextField('Employee Mobile Number', employeePhoneController,
//           Icons.phone_android),
//       _buildTextField(
//           'Landline Phone Number', landlinePhoneController, Icons.phone),
//     ];

//     return Padding(
//       padding: EdgeInsets.all(padding),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             const Text('Add Employees',
//                 style: TextStyle(
//                     fontSize: 25,
//                     color: Color(0xff4B70F5),
//                     fontWeight: FontWeight.bold)),
//             const SizedBox(height: 25),
//             ..._buildFieldRows(fields, isWide: isWide),
//             const SizedBox(height: 25),
//             ElevatedButton(
//               onPressed: saveEmployees,
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
//         padding: const EdgeInsets.only(bottom: 175.0),
//         child: Image.asset(
//           'assets/photo_2025-06-16_16-24-27.jpg',
//           width: 350,
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }
// }


// import 'package:dashboard/main.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//    final token = storage.getString('token');
// class Supervisors extends StatefulWidget {
//   const Supervisors({super.key});

//   @override
//   State<Supervisors> createState() => _SupervisorsPageState();
// }

// class _SupervisorsPageState extends State<Supervisors> {
//   final _formKey = GlobalKey<FormState>();

//   final firstNameController = TextEditingController();
//   final lastNameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final emailController = TextEditingController();
//   final passwordController = TextEditingController();

//   bool _isLoading = false;

//   Future<void> saveSupervisor() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//       });

//       try {
//         final Map<String, dynamic> requestData = {
//           "first_name": firstNameController.text,
//           "last_name": lastNameController.text,
//           "email": emailController.text,
//           "phone": phoneController.text,
//           "password": passwordController.text,
//           "stage_id": 1 // You can modify this value as needed
//         };

//         // Send request to API
//         final response = await http.post(
//           Uri.parse('http://137.184.50.2/api/v1/dashboard/supervisor'),
//           headers: <String, String>{
//              'Authorization': 'Bearer $token', 
//             'Content-Type': 'application/json; charset=UTF-8',
     
       
//             'Accept': 'application/json',
//           },
          
//           body: jsonEncode(requestData),
//         );
     
//               print(' Response Status: ${response.statusCode}');
//                print(' Response Data: ${response.body}');


//         if (response.statusCode == 200 || response.statusCode == 201) {
//           // Success
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('Supervisor saved successfully')),
//           );
          
//           // Clear fields after saving
//           firstNameController.clear();
//           lastNameController.clear();
//           phoneController.clear();
//           emailController.clear();
//           passwordController.clear();
//         } else {
//           // Failed
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(content: Text('Failed to save: ${response.body}')),
//           );
//         }
//       } catch (e) {
//         // Connection error
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error occurred: $e')),
//         );
//       } finally {
//         setState(() {
//           _isLoading = false;
//         });
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
//       _buildTextField('First Name', firstNameController, Icons.person),
//       _buildTextField('Last Name', lastNameController, Icons.person_outline),
//       _buildTextField('Phone Number', phoneController, Icons.phone),
//       _buildTextField('Email', emailController, Icons.email),
//       _buildTextField('Password', passwordController, Icons.lock, isPassword: true),
//     ];
//     return Padding(
//       padding: EdgeInsets.all(padding),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             const Text('Add New Supervisor',
//                 style: TextStyle(
//                     fontSize: 25,
//                     color: Color(0xff4B70F5),
//                     fontWeight: FontWeight.bold)),
//             const SizedBox(height: 25),
//             ..._buildFieldRows(fields, isWide: isWide),
//             const SizedBox(height: 25),
//             _isLoading
//                 ? const CircularProgressIndicator()
//                 : ElevatedButton(
//                     onPressed: saveSupervisor,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xff4B70F5),
//                       padding:
//                           const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
//                     ),
//                     child: const Text('Save Supervisor'),
//                   ),
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
//       String label, TextEditingController controller, IconData icon, {bool isPassword = false}) {
//     return TextFormField(
//       controller: controller,
//       obscureText: isPassword,
//       decoration: InputDecoration(
//         labelText: label,
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
        
//         // Email validation
//         if (label == 'Email' && !value.contains('@')) {
//           return 'Please enter a valid email';
//         }
        
//         // Phone validation
//         if (label == 'Phone Number' && value.length < 10) {
//           return 'Please enter a valid phone number';
//         }
        
//         return null;
//       },
//     );
//   }

//   Widget _buildImageSection({double? height}) {
//     return SizedBox(
//       height: height,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 175.0),
//         child: Image.asset(
//           'assets/photo_2025-06-16_16-24-27.jpg',
//           width: 350,
//           fit: BoxFit.contain,
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     // Clean up the controllers
//     firstNameController.dispose();
//     lastNameController.dispose();
//     phoneController.dispose();
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
// }
import 'package:dashboard/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final token = storage.getString('token');

class Supervisors extends StatefulWidget {
  const Supervisors({super.key});

  @override
  State<Supervisors> createState() => _SupervisorsPageState();
}

class _SupervisorsPageState extends State<Supervisors> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;

  
  List<dynamic> _stages = [];
  int? _selectedStageId;

  @override
  void initState() {
    super.initState();
    fetchStages();
  }

  Future<void> fetchStages() async {
    try {
      final response = await http.get(
        Uri.parse("http://137.184.50.2/api/v1/dashboard/get-stages-only"),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
          
      print(' Response Status: ${response.statusCode}');
      print(' Response Data: ${response.body}');


      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _stages = data['data'];
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load stages: ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching stages: $e')),
      );
    }
  }

  Future<void> saveSupervisor() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedStageId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a stage')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        final Map<String, dynamic> requestData = {
          "first_name": firstNameController.text,
          "last_name": lastNameController.text,
          "email": emailController.text,
          "phone": phoneController.text,
          "password": passwordController.text,
          "stage_id": _selectedStageId, // المرحلة المختارة
        };

        final response = await http.post(
          Uri.parse('http://137.184.50.2/api/v1/dashboard/supervisor'),
          headers: <String, String>{
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json; charset=UTF-8',
            'Accept': 'application/json',
          },
          body: jsonEncode(requestData),
        );

        print(' Response Status: ${response.statusCode}');
        print(' Response Data: ${response.body}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Supervisor saved successfully')),
          );

          firstNameController.clear();
          lastNameController.clear();
          phoneController.clear();
          emailController.clear();
          passwordController.clear();
          setState(() {
            _selectedStageId = null;
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to save: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error occurred: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,body: LayoutBuilder(builder: (context, constraints) {
        bool isWide = constraints.maxWidth >= 800;
        return isWide
            ? Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _buildFormContent(padding: 32, isWide: true),
                  ),
                  Expanded(
                    flex: 1,
                    child: _buildImageSection(),
                  ),
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
      _buildTextField('First Name', firstNameController, Icons.person),
      _buildTextField('Last Name', lastNameController, Icons.person_outline),
      _buildTextField('Phone Number', phoneController, Icons.phone),
      _buildTextField('Email', emailController, Icons.email),
      _buildTextField('Password', passwordController, Icons.lock,
          isPassword: true),
      _buildStageDropdown(), 
    ];

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text('Add New Supervisor',
                style: TextStyle(
                    fontSize: 25,
                    color: Color(0xff4B70F5),
                    fontWeight: FontWeight.bold)),
            const SizedBox(height: 25),
            ..._buildFieldRows(fields, isWide: isWide),
            const SizedBox(height: 25),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: saveSupervisor,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff4B70F5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                    ),
                    child: const Text('Save Supervisor'),
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildStageDropdown() {
    return DropdownButtonFormField<int>(
      value: _selectedStageId,
      decoration: InputDecoration(
        labelText: "Select Stage",
        prefixIcon: const Icon(Icons.school, color: Color(0xff4B70F5)),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
      items: _stages
          .map((stage) => DropdownMenuItem<int>(
                value: stage['id'],
                child: Text(stage['name']),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          _selectedStageId = value;
        });
      },
      validator: (value) =>
          value == null ? 'Please select a stage' : null,
    );
  }

  List<Widget> _buildFieldRows(List<Widget> fields, {required bool isWide}) {
    List<Widget> rows = [];
    for (int i = 0; i < fields.length; i += isWide ? 2 : 1) {
      rows.add(
        Row(
          children: List.generate(isWide ? 2 : 1, (j) {
            int index = i + j;
            if (index < fields.length) {
              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: fields[index],
                ),
              );
            } else {
              return const Expanded(child: SizedBox());
            }
          }),
        ),
      );
    }
    return rows;
  }Widget _buildTextField(String label, TextEditingController controller,
      IconData icon,
      {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: const Color(0xff4B70F5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }

        if (label == 'Email' && !value.contains('@')) {
          return 'Please enter a valid email';
        }

        if (label == 'Phone Number' && value.length < 10) {
          return 'Please enter a valid phone number';
        }

        return null;
      },
    );
  }

  Widget _buildImageSection({double? height}) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 175.0),
        child: Image.asset(
          'assets/photo_2025-06-16_16-24-27.jpg',
          width: 350,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
