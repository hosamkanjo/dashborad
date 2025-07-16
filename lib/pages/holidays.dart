import 'package:flutter/material.dart';

class Holidays extends StatefulWidget {
  const Holidays({super.key});

  @override
  _EventsState createState() => _EventsState();
}

class _EventsState extends State<Holidays> {
  final TextEditingController dateController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final List<Map<String, String>> holidays = [];

  void addHoliday() {
    final date = dateController.text.trim();
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();

    if (date.isNotEmpty && title.isNotEmpty && description.isNotEmpty) {
      setState(() {
        holidays.add({
          'date': date,
          'title': title,
          'description': description,
        });
        dateController.clear();
        titleController.clear();
        descriptionController.clear();
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
            // Create Holiday Form
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Create Holiday",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4B70F5)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: dateController,
                      decoration: const InputDecoration(
                        hintText: 'Date *',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Title *',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        hintText: 'Description *',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: addHoliday,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          const Color(0xff4B70F5),
                        ),
                      ),
                      child: const Text('Submit'),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 30),
            const VerticalDivider(width: 1),
            const SizedBox(width: 30),
            // Holidays List Table
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "List Holiday",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xff4B70F5)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: const [
                        DataColumn(
                          label: Text("Holiday",
                              style: TextStyle(color: Color(0xff4B70F5))),
                        ),
                        DataColumn(
                          label: Text("Date",
                              style: TextStyle(color: Color(0xff4B70F5))),
                        ),
                        DataColumn(
                          label: Text("Title",
                              style: TextStyle(color: Color(0xff4B70F5))),
                        ),
                        DataColumn(
                          label: Text("Description",
                              style: TextStyle(color: Color(0xff4B70F5))),
                        ),
                        DataColumn(
                          label: Text("Action",
                              style: TextStyle(color: Color(0xff4B70F5))),
                        ),
                      ],
                      rows: holidays.asMap().entries.map((entry) {
                        final index = entry.key;
                        final holiday = entry.value;

                        return DataRow(cells: [
                          DataCell(Text((index + 1).toString())),
                          DataCell(Text(holiday['date']!)),
                          DataCell(Text(holiday['title']!)),
                          DataCell(
                            Tooltip(
                              message: holiday['description']!,
                              child: SizedBox(
                                width: 150,
                                child: Text(
                                  holiday['description']!,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ),
                          DataCell(
                            IconButton(
                              icon: const Icon(Icons.delete,
                                  color: Color(0xff4B70F5)),
                              onPressed: () {
                                setState(() {
                                  holidays.removeAt(index);
                                });
                              },
                            ),
                          ),
                        ]);
                      }).toList(),
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
