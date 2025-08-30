



import 'package:dashboard/controllers/year_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SessionYear extends StatefulWidget {
  const SessionYear({super.key});

  @override
  State<SessionYear> createState() => _SessionYearState();
}

class _SessionYearState extends State<SessionYear> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  final YearController c = Get.put(YearController());
  
  void submit() async {
    final name = nameController.text.trim();
    final startDate = startDateController.text.trim();
    final endDate = endDateController.text.trim();

    if (name.isEmpty || startDate.isEmpty || endDate.isEmpty) {
      Get.snackbar('warning', '   please fill all cells ');
      return;
    }

    await c.addYear(name: name, startDate: startDate, endDate: endDate);

  
    nameController.clear();
    startDateController.clear();
    endDateController.clear();
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
                child: Text(
                  "Manage Session Year",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xff4B70F5)),
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Create Session Year",
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff4B70F5))),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Year *', border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: startDateController,
                  decoration: const InputDecoration(
                    hintText: 'Start Date *  (example: 2024/1/1)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: endDateController,
                  decoration: const InputDecoration(
                    hintText: 'End Date *  (example: 2025/5/10)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Obx(
                  () => ElevatedButton(
                    onPressed: c.isSubmitting.value ? null : submit,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(const Color(0xff4B70F5)),
                    ),
                    child: c.isSubmitting.value ? const SizedBox(
                      height: 18, width: 18,
                      child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    ) : const Text('Submit'),
                  ),
                ),
              ),
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
                    style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xff4B70F5))),
              ),
              const SizedBox(height: 10),
              Obx(() {
                if (c.isLoading.value) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (c.years.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('There isnt data  '),
                  );
                }

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const [
                      DataColumn(label: Text("Session", style: TextStyle(color: Color(0xff4B70F5)))),
                      DataColumn(label: Text("Year", style: TextStyle(color: Color(0xff4B70F5)))),
                      DataColumn(label: Text("Start Date", style: TextStyle(color: Color(0xff4B70F5)))),
                      DataColumn(label: Text("End Date", style: TextStyle(color: Color(0xff4B70F5)))),
                      // DataColumn(label: Text("Action", style: TextStyle(color: Color(0xff4B70F5)))),
                    ],
                    rows: c.years.asMap().entries.map((entry) {
                      final index = entry.key;
                      final item = entry.value;
                      return DataRow(cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(Text(item.name)),
                        DataCell(Text(item.startDate)),
                        DataCell(Text(item.endDate)),
                        // DataCell(Row(
                        //   children: [
                        //     IconButton(
                        //       icon: const Icon(Icons.delete, color: Color(0xff4B70F5)),
                        //       onPressed: () {

                        //         c.years.removeAt(index);
                        //       },
                        //     ),
                        //   ],
                        // )),
                      ]);
                    }).toList(),
                  ),
                );
              }),
            
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton.icon(
                  onPressed: c.fetchYears,
                  icon: const Icon(Icons.refresh),
                  label: const Text(' Update the list of years'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
