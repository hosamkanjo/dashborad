// import 'package:flutter/material.dart';

// class SessionYear extends StatefulWidget {
//   const SessionYear({super.key});

//   @override
//   State<SessionYear> createState() => _SessionYearState();
// }

// class _SessionYearState extends State<SessionYear> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController startDateController = TextEditingController();
//   final TextEditingController endDateController = TextEditingController();

//   final List<Map<String, String>> sessionYears = [];

//   void addSessionYear() {
//     final name = nameController.text.trim();
//     final startDate = startDateController.text.trim();
//     final endDate = endDateController.text.trim();

//     if (name.isNotEmpty && startDate.isNotEmpty && endDate.isNotEmpty) {
//       setState(() {
//         sessionYears.add({
//           'name': name,
//           'startDate': startDate,
//           'endDate': endDate,
//         });

//         nameController.clear();
//         startDateController.clear();
//         endDateController.clear();
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Expanded(
//           flex: 1,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text("Manage Session Year",
//                     style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Color(0xff4B70F5))),
//               ),
//               const SizedBox(height: 20),
//               const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text("Create Session Year",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Color(0xff4B70F5))),
//               ),
//               const SizedBox(height: 10),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                   controller: nameController,
//                   decoration: const InputDecoration(
//                       hintText: 'Year *', border: OutlineInputBorder()),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                   controller: startDateController,
//                   decoration: const InputDecoration(
//                       hintText: 'Start Date *', border: OutlineInputBorder()),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(16.0),
//                 child: TextField(
//                   controller: endDateController,
//                   decoration: const InputDecoration(
//                       hintText: 'End Date *', border: OutlineInputBorder()),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Center(
//                 child: ElevatedButton(
//                     onPressed: addSessionYear,
//                     style: ButtonStyle(
//                         backgroundColor: WidgetStateProperty.all(
//                             const Color(0xff4B70F5))),
//                     child: const Text('Submit')),
//               )
//             ],
//           ),
//         ),
//         const SizedBox(width: 40),
//         const VerticalDivider(width: 1),
//         Expanded(
//           flex: 2,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Text("List Session Year",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold, color: Color(0xff4B70F5))),
//               ),
//               const SizedBox(height: 10),
//               DataTable(
//                 columns: const [
//                   DataColumn(
//                       label: Text("Session",
//                           style: TextStyle(color: Color(0xff4B70F5)))),
//                   DataColumn(
//                       label: Text("Year",
//                           style: TextStyle(color: Color(0xff4B70F5)))),
//                   DataColumn(
//                       label: Text("Start Date",
//                           style: TextStyle(color: Color(0xff4B70F5)))),
//                   DataColumn(
//                       label: Text("End Date",
//                           style: TextStyle(color: Color(0xff4B70F5)))),
//                   DataColumn(
//                       label: Text("Action",
//                           style: TextStyle(color: Color(0xff4B70F5)))),
//                 ],
//                 rows: sessionYears
//                     .asMap()
//                     .entries
//                     .map((entry) => DataRow(cells: [
//                           DataCell(Text((entry.key + 1).toString())),
//                           DataCell(Text(entry.value['name']!)),
//                           DataCell(Text(entry.value['startDate']!)),
//                           DataCell(Text(entry.value['endDate']!)),
//                           DataCell(Row(
//                             children: [
//                               IconButton(
//                                 icon: const Icon(Icons.delete,
//                                     color: Color(0xff4B70F5)),
//                                 onPressed: () {
//                                   setState(() {
//                                     sessionYears.removeAt(entry.key);
//                                   });
//                                 },
//                               ),
//                             ],
//                           )),
//                         ]))
//                     .toList(),
//               ),
//             ],
//           ),
//         )
//       ],
//     );
//   }
// }

///////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////

import 'package:dashboard/main.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class SessionYear extends StatefulWidget {
  const SessionYear({super.key});

  @override
  State<SessionYear> createState() => _SessionYearState();
}

class _SessionYearState extends State<SessionYear> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController startDateController = TextEditingController();
  final TextEditingController endDateController = TextEditingController();

  final List<Map<String, dynamic>> sessionYears = [];
  late Dio _dio;
  bool isLoading = false;

  final authToken = storage.getString('token');

  @override
  void initState() {
    super.initState();

    _dio = Dio(
      BaseOptions(
        baseUrl: 'http://localhost:8000/api/v1/dashboard/years/',
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    fetchSessionYears();
  }

  Future<void> fetchSessionYears() async {
    setState(() {
      isLoading = true;
    });

      

    try {
      final response = await _dio.post('');
     print(' Response Status: ${response.statusCode}');
      print(' Response Data: ${response.data}');

      if (response.statusCode == 200) {
        setState(() {
          sessionYears.clear();
          for (var item in response.data) {
            sessionYears.add({
              'id': item['id'],
              'name': item['name'],
              'startDate': item['start_date'],
              'endDate': item['end_date'],
              'created_at': item['created_at'],
              'updated_at': item['updated_at'],
            });
          }
        });
      }
    } on DioException catch (error) {
      print('Error fetching session years: $error');
      String errorMessage = 'Failed to load session years.';

      if (error.response?.statusCode == 401) {
        errorMessage = 'Authentication failed. Please check your token.';
      } else if (error.response?.statusCode == 403) {
        errorMessage = 'You do not have permission to access this resource.';
      }

      showErrorDialog(errorMessage);
    } catch (error) {
      print('Unexpected error: $error');
      showErrorDialog('An unexpected error occurred.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addSessionYear() async {
    final name = nameController.text.trim();
    final startDate = startDateController.text.trim();
    final endDate = endDateController.text.trim();

    if (name.isNotEmpty && startDate.isNotEmpty && endDate.isNotEmpty) {
      setState(() {
        isLoading = true;
      });

      try {
        final response = await _dio.post(
          '',
          data: {'name': name, 'start_date': startDate, 'end_date': endDate},
        );
print(' Response Status: ${response.statusCode}');
      print(' Response Data: ${response.data}');

        if (response.statusCode == 200 || response.statusCode == 201) {
          setState(() {
            sessionYears.add({
              'id': response.data['id'],
              'name': response.data['name'],
              'startDate': response.data['start_date'],
              'endDate': response.data['end_date'],
              'created_at': response.data['created_at'],
              'updated_at': response.data['updated_at'],
            });
          });
          nameController.clear();
          startDateController.clear();
          endDateController.clear();

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Session year added successfully')),
          );
        }
      } on DioException catch (error) {
        print('Error adding session year: $error');
        String errorMessage = 'Failed to add session year.';

        if (error.response?.statusCode == 401) {
          errorMessage = 'Authentication failed. Please check your token.';
        } else if (error.response?.statusCode == 403) {
          errorMessage = 'You do not have permission to add session years.';
        } else if (error.response?.statusCode == 422) {
          errorMessage = 'Validation error. Please check your input.';
        }

        showErrorDialog(errorMessage);
      } catch (error) {
        print('Unexpected error: $error');
        showErrorDialog('An unexpected error occurred.');
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      showErrorDialog('Please fill all fields.');
    }
  }


  Future<void> deleteSessionYear(int id, int index) async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await _dio.delete('$id/');

      if (response.statusCode == 200 || response.statusCode == 204) {
        setState(() {
          sessionYears.removeAt(index);
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Session year deleted successfully')),
        );
      }
    } on DioException catch (error) {
      print('Error deleting session year: $error');
      String errorMessage = 'Failed to delete session year.';

      if (error.response?.statusCode == 401) {
        errorMessage = 'Authentication failed. Please check your token.';
      } else if (error.response?.statusCode == 403) {
        errorMessage = 'You do not have permission to delete session years.';
      } else if (error.response?.statusCode == 404) {
        errorMessage =
            'Session year not found. It may have been already deleted.';
      }

      showErrorDialog(errorMessage);
    } catch (error) {
      print('Unexpected error: $error');
      showErrorDialog('An unexpected error occurred.');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
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
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4B70F5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "Create Session Year",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4B70F5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        hintText: 'Year *',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: startDateController,
                      decoration: const InputDecoration(
                        hintText: 'Start Date *',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () async {
                        // يمكن إضافة منتقي تواريخ هنا
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: endDateController,
                      decoration: const InputDecoration(
                        hintText: 'End Date *',
                        border: OutlineInputBorder(),
                      ),
                      onTap: () async {
                     
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: isLoading ? null : addSessionYear,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                          const Color(0xff4B70F5),
                        ),
                      ),
                      child: const Text('Submit'),
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
                    child: Text(
                      "List Session Year",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff4B70F5),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : sessionYears.isEmpty
                      ? const Center(child: Text('No session years found.'))
                      : DataTable(
                          columns: const [
                            DataColumn(
                              label: Text(
                                "Session",
                                style: TextStyle(color: Color(0xff4B70F5)),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Year",
                                style: TextStyle(color: Color(0xff4B70F5)),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Start Date",
                                style: TextStyle(color: Color(0xff4B70F5)),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "End Date",
                                style: TextStyle(color: Color(0xff4B70F5)),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Action",
                                style: TextStyle(color: Color(0xff4B70F5)),
                              ),
                            ),
                          ],
                          rows: sessionYears
                              .asMap()
                              .entries
                              .map(
                                (entry) => DataRow(
                                  cells: [
                                    DataCell(Text((entry.key + 1).toString())),
                                    DataCell(Text(entry.value['name'])),
                                    DataCell(Text(entry.value['startDate'])),
                                    DataCell(Text(entry.value['endDate'])),
                                    DataCell(
                                      Row(
                                        children: [


                                          IconButton(
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Color(0xff4B70F5),
                                            ),
                                            onPressed: isLoading
                                                ? null
                                                : () => deleteSessionYear(
                                                    entry.value['id'],
                                                    entry.key,
                                                  ),
                                          ),


                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                ],
              ),
            ),
          ],
        ),
        if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
