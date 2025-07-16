import 'package:flutter/material.dart';

class Activities extends StatefulWidget {
  const Activities({super.key});

  @override
  _ActivitiesState createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  final List<Map<String, String>> activities = [];

  void addActivity() {
    final name = nameController.text.trim();
    final date = dateController.text.trim();

    if (name.isNotEmpty && date.isNotEmpty) {
      setState(() {
        activities.add({'name': name, 'date': date});
        nameController.clear();
        dateController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Create Activity",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4B70F5))),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      hintText: 'Activity Name *',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: dateController,
                    decoration: const InputDecoration(
                      hintText: 'Date *',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: ElevatedButton(
                      onPressed: addActivity,
                      style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.all(
                              const Color(0xff4B70F5))),
                      child: const Text('Submit'),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 40),
            const VerticalDivider(width: 1),
            const SizedBox(width: 40),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("List of Activities",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff4B70F5))),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text("Activity")),
                        DataColumn(label: Text("Activity Name")),
                        DataColumn(label: Text("Date")),
                        DataColumn(label: Text("Action")),
                      ],
                      rows: activities
                          .asMap()
                          .entries
                          .map((entry) => DataRow(cells: [
                                DataCell(Text((entry.key + 1).toString())),
                                DataCell(Text(entry.value['name']!)),
                                DataCell(Text(entry.value['date']!)),
                                DataCell(IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      activities.removeAt(entry.key);
                                    });
                                  },
                                )),
                              ]))
                          .toList(),
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
}
