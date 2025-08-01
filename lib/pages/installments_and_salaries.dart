import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class InstallmentsAndSalaries extends StatefulWidget {
  const InstallmentsAndSalaries({super.key});

  @override
  State<InstallmentsAndSalaries> createState() =>
      _InstallmentsAndSalariesState();
}

class _InstallmentsAndSalariesState extends State<InstallmentsAndSalaries>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Salaries
  final List<Map<String, String>> _salaries = [];
  final _employeeNameController = TextEditingController();
  final _salaryAmountController = TextEditingController();
  String? _selectedTeacherOrEmployee;
  final List<String> _jobTitles = ['Teacher', 'Employee'];
  DateTime? _salaryDate;

  // Installments
  final List<Map<String, String>> _installments = [];
  final _studentNameController = TextEditingController();
  final _feeAmountController = TextEditingController();
  DateTime? _date;
  String _selectedInstallment = 'First';
  final List<String> _installment = ['First', 'Second', 'Third', 'Final'];

  final List<String> _classes = [
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
  final List<String> _sections = ['Section 1', 'Section 2', 'Section 3'];
  String? _selectedClass;
  String? _selectedSection;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  Future<void> _pickDate(BuildContext context, bool isSalary) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      setState(() {
        if (isSalary) {
          _salaryDate = picked;
        } else {
          _date = picked;
        }
      });
    }
  }

  void _submitSalary() {
    if (_employeeNameController.text.isEmpty ||
        _selectedTeacherOrEmployee == null ||
        _salaryAmountController.text.isEmpty ||
        _salaryDate == null) {
      return;
    }

    setState(() {
      _salaries.add({
        'employee': _employeeNameController.text,
        'title': _selectedTeacherOrEmployee!,
        'amount': _salaryAmountController.text,
        'date': DateFormat('yyyy-MM-dd').format(_salaryDate!),
      });

      _employeeNameController.clear();
      _selectedTeacherOrEmployee = null;
      _salaryAmountController.clear();
      _salaryDate = null;
    });
  }

  void _submitFee() {
    if (_studentNameController.text.isEmpty ||
        _selectedClass == null ||
        _selectedSection == null ||
        _feeAmountController.text.isEmpty ||
        _date == null) {
      return;
    }

    setState(() {
      _installments.add({
        'student': _studentNameController.text,
        'class': _selectedClass!,
        'section': _selectedSection!,
        'amount': _feeAmountController.text,
        'installment': _selectedInstallment,
        'date': DateFormat('yyyy-MM-dd').format(_date!),
      });

      _studentNameController.clear();
      _selectedClass = null;
      _selectedSection = null;
      _feeAmountController.clear();
      _date = null;
      _selectedInstallment = 'First';
    });
  }

  void _deleteSalary(int index) {
    setState(() {
      _salaries.removeAt(index);
    });
  }

  void _deleteFee(int index) {
    setState(() {
      _installments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final groupedInstallments = groupBy(
      _installments,
      (e) => "${e['class']} - ${e['section']}",
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Salaries & Installments'),
        backgroundColor: const Color(0xff4B70F5),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Salaries'),
            Tab(text: 'Installments'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // ---------------------- Salaries Tab ----------------------
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _employeeNameController,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedTeacherOrEmployee,
                  items: _jobTitles
                      .map(
                        (title) =>
                            DropdownMenuItem(value: title, child: Text(title)),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedTeacherOrEmployee = value),
                  decoration: const InputDecoration(
                    hintText: 'Teacher or Employee',
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _salaryAmountController,
                  decoration: const InputDecoration(hintText: 'Salary Amount'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _salaryDate == null
                            ? 'Payment Date: Not selected'
                            : 'Payment Date: ${DateFormat('yyyy-MM-dd').format(_salaryDate!)}',
                      ),
                    ),
                    TextButton(
                      onPressed: () => _pickDate(context, true),
                      child: const Text('Pick Date'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _submitSalary,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      const Color(0xff4B70F5),
                    ),
                  ),
                  child: const Text('Submit Salary'),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Paid Salaries:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4B70F5),
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: SingleChildScrollView(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Employee')),
                          DataColumn(label: Text('Title')),
                          DataColumn(label: Text('Amount')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Delete')),
                        ],
                        rows: List.generate(_salaries.length, (index) {
                          final s = _salaries[index];
                          return DataRow(
                            cells: [
                              DataCell(Text(s['employee']!)),
                              DataCell(Text(s['title']!)),
                              DataCell(Text(s['amount']!)),
                              DataCell(Text(s['date']!)),
                              DataCell(
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => _deleteSalary(index),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ---------------------- Installments Tab ----------------------
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  controller: _studentNameController,
                  decoration: const InputDecoration(hintText: 'Student Name'),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedClass,
                  items: _classes
                      .map(
                        (grade) =>
                            DropdownMenuItem(value: grade, child: Text(grade)),
                      )
                      .toList(),
                  onChanged: (val) => setState(() => _selectedClass = val),
                  decoration: const InputDecoration(hintText: 'Select Class'),
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedSection,
                  items: _sections
                      .map(
                        (sec) => DropdownMenuItem(value: sec, child: Text(sec)),
                      )
                      .toList(),
                  onChanged: (val) => setState(() => _selectedSection = val),
                  decoration: const InputDecoration(hintText: 'Select Section'),
                ), // ✅ حقل الشعبة
                const SizedBox(height: 8),
                TextField(
                  controller: _feeAmountController,
                  decoration: const InputDecoration(hintText: 'Amount Paid'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 8),
                DropdownButtonFormField<String>(
                  value: _selectedInstallment,
                  items: _installment
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (val) =>
                      setState(() => _selectedInstallment = val!),
                  decoration: const InputDecoration(
                    labelText: 'Installment Type',
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _date == null
                            ? 'Payment Date: Not selected'
                            : 'Payment Date: ${DateFormat('yyyy-MM-dd').format(_date!)}',
                      ),
                    ),
                    TextButton(
                      onPressed: () => _pickDate(context, false),
                      child: const Text('Pick Date'),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _submitFee,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      const Color(0xff4B70F5),
                    ),
                  ),
                  child: const Text('Submit'),
                ),
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Received Installments:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Color(0xff4B70F5),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView(
                    children: groupedInstallments.entries.map((entry) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Class & Section: ${entry.key}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff4B70F5),
                            ),
                          ),
                          const SizedBox(height: 5),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columns: const [
                                DataColumn(label: Text('Student')),
                                DataColumn(label: Text('Amount')),
                                DataColumn(label: Text('Installment')),
                                DataColumn(label: Text('Date')),
                                DataColumn(label: Text('Delete')),
                              ],
                              rows: entry.value.map((f) {
                                final index = _installments.indexOf(f);
                                return DataRow(
                                  cells: [
                                    DataCell(Text(f['student']!)),
                                    DataCell(Text(f['amount']!)),
                                    DataCell(Text(f['installment']!)),
                                    DataCell(Text(f['date']!)),
                                    DataCell(
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        onPressed: () => _deleteFee(index),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                          const Divider(),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:collection/collection.dart'; // لتجميع الأقساط حسب الصف

// class InstallmentsAndSalaries extends StatefulWidget {
//   const InstallmentsAndSalaries({super.key});

//   @override
//   State<InstallmentsAndSalaries> createState() =>
//       _InstallmentsAndSalariesState();
// }

// class _InstallmentsAndSalariesState extends State<InstallmentsAndSalaries>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;

//   // Salaries
//   final List<Map<String, String>> _salaries = [];
//   final _employeeNameController = TextEditingController();
//   final _salaryAmountController = TextEditingController();
//   String? _selectedTeacherOrEmployee;
//   final List<String> _jobTitles = ['Teacher', 'Employee'];
//   DateTime? _salaryDate;

//   // Installments
//   final List<Map<String, String>> _installments = [];
//   final _studentNameController = TextEditingController();
//   final _feeAmountController = TextEditingController();
//   DateTime? _date;
//   String _selectedInstallment = 'First';
//   final List<String> _installment = ['First', 'Second', 'Third', 'Final'];

//   final List<String> _classes = [
//     'Class 1',
//     'Class 2',
//     'Class 3',
//     'Class 4',
//     'Class 5',
//     'Class 6',
//     'Class 7',
//     'Class 8',
//     'Class 9',
//     'Class 10',
//     'Class 11',
//     'Class 12',
//   ];
//   String? _selectedClass;

//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 2, vsync: this);
//   }

//   Future<void> _pickDate(BuildContext context, bool isSalary) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2023),
//       lastDate: DateTime(2050),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isSalary) {
//           _salaryDate = picked;
//         } else {
//           _date = picked;
//         }
//       });
//     }
//   }

//   void _submitSalary() {
//     if (_employeeNameController.text.isEmpty ||
//         _selectedTeacherOrEmployee == null ||
//         _salaryAmountController.text.isEmpty ||
//         _salaryDate == null) return;

//     setState(() {
//       _salaries.add({
//         'employee': _employeeNameController.text,
//         'title': _selectedTeacherOrEmployee!,
//         'amount': _salaryAmountController.text,
//         'date': DateFormat('yyyy-MM-dd').format(_salaryDate!),
//       });

//       _employeeNameController.clear();
//       _selectedTeacherOrEmployee = null;
//       _salaryAmountController.clear();
//       _salaryDate = null;
//     });
//   }

//   void _submitFee() {
//     if (_studentNameController.text.isEmpty ||
//         _selectedClass == null ||
//         _feeAmountController.text.isEmpty ||
//         _date == null) return;

//     setState(() {
//       _installments.add({
//         'student': _studentNameController.text,
//         'class': _selectedClass!,
//         'amount': _feeAmountController.text,
//         'installment': _selectedInstallment,
//         'date': DateFormat('yyyy-MM-dd').format(_date!),
//       });

//       _studentNameController.clear();
//       _selectedClass = null;
//       _feeAmountController.clear();
//       _date = null;
//       _selectedInstallment = 'First';
//     });
//   }

//   void _deleteSalary(int index) {
//     setState(() {
//       _salaries.removeAt(index);
//     });
//   }

//   void _deleteFee(int index) {
//     setState(() {
//       _installments.removeAt(index);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final groupedInstallments = groupBy(_installments, (e) => e['class']);

//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: const Text('Salaries & Installments'),
//         backgroundColor: const Color(0xff4B70F5),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: const [
//             Tab(text: 'Salaries'),
//             Tab(text: 'Installments'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         controller: _tabController,
//         children: [
//           // ---------------------- Salaries Tab ----------------------
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _employeeNameController,
//                   decoration: const InputDecoration(hintText: 'Name'),
//                 ),
//                 const SizedBox(height: 8),
//                 DropdownButtonFormField<String>(
//                   value: _selectedTeacherOrEmployee,
//                   items: _jobTitles
//                       .map((title) =>
//                           DropdownMenuItem(value: title, child: Text(title)))
//                       .toList(),
//                   onChanged: (value) =>
//                       setState(() => _selectedTeacherOrEmployee = value),
//                   decoration:
//                       const InputDecoration(hintText: 'Teacher or Employee'),
//                 ),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: _salaryAmountController,
//                   decoration: const InputDecoration(hintText: 'Salary Amount'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(_salaryDate == null
//                           ? 'Payment Date: Not selected'
//                           : 'Payment Date: ${DateFormat('yyyy-MM-dd').format(_salaryDate!)}'),
//                     ),
//                     TextButton(
//                       onPressed: () => _pickDate(context, true),
//                       child: const Text('Pick Date'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: _submitSalary,
//                   style: ButtonStyle(
//                       backgroundColor:
//                           WidgetStateProperty.all(const Color(0xff4B70F5))),
//                   child: const Text('Submit Salary'),
//                 ),
//                 const SizedBox(height: 20),
//                 const Text('Paid Salaries:',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Color(0xff4B70F5))),
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         columns: const [
//                           DataColumn(label: Text('Employee')),
//                           DataColumn(label: Text('Title')),
//                           DataColumn(label: Text('Amount')),
//                           DataColumn(label: Text('Date')),
//                           DataColumn(label: Text('Delete')),
//                         ],
//                         rows: List.generate(_salaries.length, (index) {
//                           final s = _salaries[index];
//                           return DataRow(cells: [
//                             DataCell(Text(s['employee']!)),
//                             DataCell(Text(s['title']!)),
//                             DataCell(Text(s['amount']!)),
//                             DataCell(Text(s['date']!)),
//                             DataCell(IconButton(
//                               icon: const Icon(Icons.delete, color: Colors.red),
//                               onPressed: () => _deleteSalary(index),
//                             )),
//                           ]);
//                         }),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),

//           // ---------------------- Installments Tab ----------------------
//           Padding(
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 TextField(
//                   controller: _studentNameController,
//                   decoration: const InputDecoration(hintText: 'Student Name'),
//                 ),
//                 const SizedBox(height: 8),
//                 DropdownButtonFormField<String>(
//                   value: _selectedClass,
//                   items: _classes
//                       .map((grade) =>
//                           DropdownMenuItem(value: grade, child: Text(grade)))
//                       .toList(),
//                   onChanged: (val) => setState(() => _selectedClass = val),
//                   decoration: const InputDecoration(hintText: 'Select Class'),
//                 ),
//                 const SizedBox(height: 8),
//                 TextField(
//                   controller: _feeAmountController,
//                   decoration: const InputDecoration(hintText: 'Amount Paid'),
//                   keyboardType: TextInputType.number,
//                 ),
//                 const SizedBox(height: 8),
//                 DropdownButtonFormField<String>(
//                   value: _selectedInstallment,
//                   items: _installment
//                       .map((e) => DropdownMenuItem(value: e, child: Text(e)))
//                       .toList(),
//                   onChanged: (val) =>
//                       setState(() => _selectedInstallment = val!),
//                   decoration:
//                       const InputDecoration(labelText: 'Installment Type'),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   children: [
//                     Expanded(
//                       child: Text(_date == null
//                           ? 'Payment Date: Not selected'
//                           : 'Payment Date: ${DateFormat('yyyy-MM-dd').format(_date!)}'),
//                     ),
//                     TextButton(
//                       onPressed: () => _pickDate(context, false),
//                       child: const Text('Pick Date'),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(height: 8),
//                 ElevatedButton(
//                   onPressed: _submitFee,
//                   style: ButtonStyle(
//                       backgroundColor:
//                           WidgetStateProperty.all(const Color(0xff4B70F5))),
//                   child: const Text('Submit'),
//                 ),
//                 const SizedBox(height: 20),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Received Installments:',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                             color: Color(0xff4B70F5))),
//                   ],
//                 ),
//                 const SizedBox(height: 10),
//                 Expanded(
//                   child: ListView(
//                     children: groupedInstallments.entries.map((entry) {
//                       return Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           Text('Class: ${entry.key}',
//                               style: const TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                   color: Color(0xff4B70F5))),
//                           const SizedBox(height: 5),
//                           SingleChildScrollView(
//                             scrollDirection: Axis.horizontal,
//                             child: DataTable(
//                               columns: const [
//                                 DataColumn(label: Text('Student')),
//                                 DataColumn(label: Text('Amount')),
//                                 DataColumn(label: Text('Installment')),
//                                 DataColumn(label: Text('Date')),
//                                 DataColumn(label: Text('Delete')),
//                               ],
//                               rows: entry.value.map((f) {
//                                 final index = _installments.indexOf(f);
//                                 return DataRow(cells: [
//                                   DataCell(Text(f['student']!)),
//                                   DataCell(Text(f['amount']!)),
//                                   DataCell(Text(f['installment']!)),
//                                   DataCell(Text(f['date']!)),
//                                   DataCell(IconButton(
//                                     icon: const Icon(Icons.delete,
//                                         color: Colors.red),
//                                     onPressed: () => _deleteFee(index),
//                                   )),
//                                 ]);
//                               }).toList(),
//                             ),
//                           ),
//                           const Divider(),
//                         ],
//                       );
//                     }).toList(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
