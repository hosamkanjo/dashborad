import 'package:dashboard/counters/teacher_counter.dart';
import 'package:flutter/material.dart';

class Teachers extends StatefulWidget {
  const Teachers({super.key});

  @override
  State<Teachers> createState() => _TeachersPageState();
}

class _TeachersPageState extends State<Teachers> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();
  final fatherNameController = TextEditingController();
  final motherNameController = TextEditingController();
  final motherSecondNameController = TextEditingController();
  final birthDateController = TextEditingController();
  final addressController = TextEditingController();
  final teacherPhoneController = TextEditingController();
  final landlinePhoneController = TextEditingController();

  String? selectedGender;
  String? selectedSubject;

  final genders = ['Male', 'Female'];
  final List<String> subjects = [
    'Physics',
    'Chemistry',
    'Mathematics',
    'Science',
    'Arabic',
    'English',
    'France',
    'Art',
    'Music'
  ];

  void saveTeachers() {
    if (_formKey.currentState!.validate()) {
      TeacherCounter.count1.value++;
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Teacher Saved')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
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
      _buildTextField('Last Name', secondNameController, Icons.person_outline),
      _buildTextField('Father’s Name', fatherNameController, Icons.man),
      _buildTextField('Mother’s Name', motherNameController, Icons.woman),
      _buildTextField(
          'Mother’s Last Name', motherSecondNameController, Icons.woman),
      _buildDropdown('Subject', subjects, selectedSubject,
          (val) => setState(() => selectedSubject = val), Icons.class_),
      _buildDropdown('Gender', genders, selectedGender,
          (val) => setState(() => selectedGender = val), Icons.transgender),
      _buildTextField(
          'Date of Birth', birthDateController, Icons.calendar_today),
      _buildTextField('Detailed Address', addressController, Icons.location_on),
      _buildTextField(
          'Teacher Mobile Number', teacherPhoneController, Icons.phone_android),
      _buildTextField(
          'Landline Phone Number', landlinePhoneController, Icons.phone),
    ];

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const Text('Add Teachers',
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
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              ),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFieldRows(List<Widget> fields, {required bool isWide}) {
    List<Widget> rows = [];
    for (int i = 0; i < fields.length; i += isWide ? 3 : 1) {
      rows.add(
        Row(
          children: List.generate(isWide ? 3 : 1, (j) {
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
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(fontSize: 14),
        prefixIcon: Icon(icon, color: const Color(0xff4B70F5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Please enter $label' : null,
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selectedValue,
      void Function(String?) onChanged, IconData icon) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: const TextStyle(fontSize: 14),
        prefixIcon: Icon(icon, color: const Color(0xff4B70F5)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      items: items
          .map((val) => DropdownMenuItem(value: val, child: Text(val)))
          .toList(),
      onChanged: onChanged,
      validator: (value) =>
          (value == null || value.isEmpty) ? 'Please select $label' : null,
    );
  }

  Widget _buildImageSection({double? height}) {
    return SizedBox(
      height: height,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 160.0),
        child: Image.asset(
          'assets/photo_2025-06-16_16-04-47.jpg',
          width: 350,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
