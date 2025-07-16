import 'package:flutter/material.dart';

class SessionYear extends StatefulWidget {
  const SessionYear({super.key});

  @override
  State<SessionYear> createState() => _SessionYearState();
}

class _SessionYearState extends State<SessionYear> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  final List<Map<String, String>> sessionYears = [];

  void addSessionYear() {
    final name = nameController.text.trim();
    final startDate = startDateController.text.trim();
    final endDate = endDateController.text.trim();

    if (name.isNotEmpty && startDate.isNotEmpty && endDate.isNotEmpty) {
      setState(() {
        sessionYears.add({
          'name': name,
          'startDate': startDate,
          'endDate': endDate,
        });

        nameController.clear();
        startDateController.clear();
        endDateController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Manage Session Year",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4B70F5))),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Create Session Year",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff4B70F5))),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: 'Year *', border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: startDateController,
                  decoration: const InputDecoration(
                      hintText: 'Start Date *', border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: endDateController,
                  decoration: const InputDecoration(
                      hintText: 'End Date *', border: OutlineInputBorder()),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                    onPressed: addSessionYear,
                    style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            const Color(0xff4B70F5))),
                    child: const Text('Submit')),
              )
            ],
          ),
        ),
        const SizedBox(width: 40),
        const VerticalDivider(width: 1),
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("List Session Year",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xff4B70F5))),
              ),
              const SizedBox(height: 10),
              DataTable(
                columns: const [
                  DataColumn(
                      label: Text("Session",
                          style: TextStyle(color: Color(0xff4B70F5)))),
                  DataColumn(
                      label: Text("Year",
                          style: TextStyle(color: Color(0xff4B70F5)))),
                  DataColumn(
                      label: Text("Start Date",
                          style: TextStyle(color: Color(0xff4B70F5)))),
                  DataColumn(
                      label: Text("End Date",
                          style: TextStyle(color: Color(0xff4B70F5)))),
                  DataColumn(
                      label: Text("Action",
                          style: TextStyle(color: Color(0xff4B70F5)))),
                ],
                rows: sessionYears
                    .asMap()
                    .entries
                    .map((entry) => DataRow(cells: [
                          DataCell(Text((entry.key + 1).toString())),
                          DataCell(Text(entry.value['name']!)),
                          DataCell(Text(entry.value['startDate']!)),
                          DataCell(Text(entry.value['endDate']!)),
                          DataCell(Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.delete,
                                    color: Color(0xff4B70F5)),
                                onPressed: () {
                                  setState(() {
                                    sessionYears.removeAt(entry.key);
                                  });
                                },
                              ),
                            ],
                          )),
                        ]))
                    .toList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
