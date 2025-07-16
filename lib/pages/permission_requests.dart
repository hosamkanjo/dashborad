import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PermissionRequest extends StatefulWidget {
  const PermissionRequest({super.key});

  @override
  _PermissionRequestState createState() => _PermissionRequestState();
}

class _PermissionRequestState extends State<PermissionRequest> {
  final _formKey = GlobalKey<FormState>();
  final List<Map<String, String>> _leaveRequests = [];

  final _nameController = TextEditingController();
  final _gradeController = TextEditingController();
  final _classController = TextEditingController();
  final _descriptionController = TextEditingController();

  String _selectedLeaveType = 'Sick';
  DateTime? _startDate;
  DateTime? _endDate;

  final List<String> _leaveTypes = ['Sick', 'Travel', 'Family Reasons'];

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        _startDate != null &&
        _endDate != null) {
      final now = DateTime.now();
      final formattedDate = DateFormat('yyyy-MM-dd hh:mm a').format(now);

      setState(() {
        _leaveRequests.add({
          'name': _nameController.text,
          'class': _classController.text,
          'type': _selectedLeaveType,
          'description': _descriptionController.text,
          'startDate': DateFormat('yyyy-MM-dd').format(_startDate!),
          'endDate': DateFormat('yyyy-MM-dd').format(_endDate!),
          'requestDate': formattedDate,
        });

        _nameController.clear();
        _gradeController.clear();
        _classController.clear();
        _descriptionController.clear();
        _startDate = null;
        _endDate = null;
      });
    }
  }

  void _deleteRequest(int index) {
    setState(() {
      _leaveRequests.removeAt(index);
    });
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );

    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Row(children: [
              Text('Request :',
                  style: TextStyle(
                      color: Color(0xff4B70F5),
                      fontWeight: FontWeight.bold,
                      fontSize: 22))
            ]),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                      hintText: 'Student Name',
                      hintStyle: TextStyle(color: Color(0xff4B70F5))),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter student name' : null,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _classController,
                  decoration: const InputDecoration(
                      hintText: 'Class',
                      hintStyle: TextStyle(color: Color(0xff4B70F5))),
                  validator: (value) => value!.isEmpty ? 'Enter class' : null,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: _selectedLeaveType,
                  style: const TextStyle(color: Color(0xff4B70F5)),
                  items: _leaveTypes.map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (val) => setState(() => _selectedLeaveType = val!),
                  decoration: const InputDecoration(
                      hintText: 'Leave Type',
                      hintStyle: TextStyle(color: Color(0xff4B70F5))),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                      hintText: 'Description',
                      hintStyle: TextStyle(color: Color(0xff4B70F5))),
                  validator: (value) =>
                      value!.isEmpty ? 'Enter description' : null,
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          _startDate == null
                              ? 'Start Date : Not selected'
                              : 'Start Date: ${DateFormat('yyyy-MM-dd').format(_startDate!)}',
                          style: const TextStyle(color: Color(0xff4B70F5))),
                    ),
                    TextButton(
                      onPressed: () => _pickDate(context, true),
                      child: const Text(
                        'Pick Start Date',
                        style: TextStyle(color: Color(0xff4B70F5)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                          _endDate == null
                              ? 'End Date : Not selected'
                              : 'End Date: ${DateFormat('yyyy-MM-dd').format(_endDate!)}',
                          style: const TextStyle(color: Color(0xff4B70F5))),
                    ),
                    TextButton(
                      onPressed: () => _pickDate(context, false),
                      child: const Text('Pick End Date',
                          style: TextStyle(color: Color(0xff4B70F5))),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStateProperty.all(const Color(0xff4B70F5))),
                  child: const Text('Submit'),
                ),
              ]),
            ),
            const SizedBox(height: 30),
            const Text('Pervious Requests',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4B70F5))),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: const [
                  DataColumn(
                      label: Text('Student Name',
                          style: TextStyle(color: Color(0xff4B70F5)))),
                  DataColumn(
                      label: Text('Class',
                          style: TextStyle(color: Color(0xff4B70F5)))),
                  DataColumn(
                      label: Text('Leave Type',
                          style: TextStyle(color: Color(0xff4B70F5)))),
                  DataColumn(
                      label: Text('Description',
                          style: TextStyle(color: Color(0xff4B70F5)))),
                  DataColumn(
                      label: Text('Start Date',
                          style: TextStyle(color: Color(0xff4B70F5)))),
                  DataColumn(
                      label: Text('End Date',
                          style: TextStyle(color: Color(0xff4B70F5)))),
                  DataColumn(
                      label: Text('Request Date',
                          style: TextStyle(color: Color(0xff4B70F5)))),
                  DataColumn(
                      label: Text('Action',
                          style: TextStyle(color: Color(0xff4B70F5)))),
                ],
                rows: List<DataRow>.generate(
                  _leaveRequests.length,
                  (index) {
                    final request = _leaveRequests[index];
                    return DataRow(cells: [
                      DataCell(Text(request['name']!)),
                      DataCell(Text(request['class']!)),
                      DataCell(Text(request['type']!)),
                      DataCell(
                        Tooltip(
                          message: request['description']!,
                          child: SizedBox(
                            width: 120,
                            child: Text(
                              request['description']!,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      DataCell(Text(request['startDate']!)),
                      DataCell(Text(request['endDate']!)),
                      DataCell(Text(request['requestDate']!)),
                      DataCell(
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteRequest(index),
                          tooltip: 'Delete request',
                        ),
                      ),
                    ]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
