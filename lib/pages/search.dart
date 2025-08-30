// import 'package:flutter/material.dart';

// class Search extends StatefulWidget {
//   const Search({super.key});

//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   String? selectedType;
//   final TextEditingController searchController = TextEditingController();

//   final List<String> types = ['Student', 'Teacher', 'Employee'];

//   void performSearch(String query) {
//     if (selectedType == null || query.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Please select a type and enter a search keyword')),
//       );
//       return;
//     }

//     print('Searching for $query in $selectedType');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const Center(
//               child: Text(
//                 'Searching',
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xff4B70F5)),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   flex: 3,
//                   child: SearchBar(
//                     controller: searchController,
//                     hintText: 'Search...',
//                     leading: const Icon(Icons.search, color: Color(0xff4B70F5)),
//                     onSubmitted: (query) => performSearch(query),
//                   ),
//                 ),
//                 const Spacer(),
//                 Expanded(
//                   flex: 2,
//                   child: DropdownButtonFormField<String>(
//                     value: selectedType,
//                     decoration: const InputDecoration(
//                         hintText: 'Type',
//                         prefixIcon: Icon(
//                           Icons.person,
//                           color: Color(0xff4B70F5),
//                         ),
//                         border: OutlineInputBorder(),
//                         hintStyle: TextStyle(color: Color(0xff4B70F5))),
//                     items: types
//                         .map((type) => DropdownMenuItem(
//                               value: type,
//                               child: Text(type),
//                             ))
//                         .toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedType = value;
//                       });
//                     },
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:dashboard/main.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Search extends StatefulWidget {
//   const Search({super.key});

//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   String? selectedType;
//   final TextEditingController searchController = TextEditingController();
//   bool isLoading = false;
//   List<dynamic> searchResults = [];

//   final List<String> types = ['student', 'teacher', 'employee'];

//   Future<void> performSearch(String query) async {
//     if (selectedType == null || query.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Please select a type and enter a search keyword')),
//       );
//       return;
//     }

//     setState(() {
//       isLoading = true;
//       searchResults.clear();
//     });
//          final token = storage.getString('token');
//     try {
//       final response = await http.post(
//         Uri.parse('http://137.184.50.2/api/v1/dashboard/search'),
//         headers: {
//             'Authorization': 'Bearer $token', 
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//         },
//         body: json.encode({
//           'q': query,
//           'type': selectedType, 
//         }),
//       );
//          print(' Response Status: ${response.statusCode}');
//       print(' Response Data: ${response.body}');


//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         setState(() {
         
//           searchResults = data['data'] ?? [];
//         });
        
//         if (searchResults.isEmpty) {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('No results found')),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${response.statusCode}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   String formatType(String type) {
//     return type[0].toUpperCase() + type.substring(1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             const Center(
//               child: Text(
//                 'Searching',
//                 style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                     color: Color(0xff4B70F5)),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Row(
//               children: [
//                 Expanded(
//                   flex: 3,
//                   child: SearchBar(
//                     controller: searchController,
//                     hintText: 'Search...',
//                     leading: const Icon(Icons.search, color: Color(0xff4B70F5)),
//                     onSubmitted: (query) => performSearch(query),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   flex: 2,
//                   child: DropdownButtonFormField<String>(
//                     value: selectedType,
//                     decoration: const InputDecoration(
//                         hintText: 'Type',
//                         prefixIcon: Icon(
//                           Icons.person,
//                           color: Color(0xff4B70F5),
//                         ),
//                         border: OutlineInputBorder(),
//                         hintStyle: TextStyle(color: Color(0xff4B70F5))),
//                     items: types
//                         .map((type) => DropdownMenuItem(value: type,
//                               child: Text(formatType(type)),
//                             ))
//                         .toList(),
//                     onChanged: (value) {
//                       setState(() {
//                         selectedType = value;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
          
//             ElevatedButton(
//               onPressed: () => performSearch(searchController.text),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff4B70F5),
//                 foregroundColor: Colors.white,
//               ),
//               child: const Text('Search'),
//             ),
//             const SizedBox(height: 20),
            
//             if (isLoading)
//               const CircularProgressIndicator(),
//             const SizedBox(height: 20),
          
//             if (searchResults.isNotEmpty)
//               Text(
//                 'Found ${searchResults.length} results',
//                 style: const TextStyle(
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff4B70F5),
//                 ),
//               ),
//             const SizedBox(height: 10),
           
//             Expanded(
//               child: ListView.builder(
//                 itemCount: searchResults.length,
//                 itemBuilder: (context, index) {
//                   final item = searchResults[index];
//                   return Card(
//                     margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
//                     child: ListTile(
//                       title: Text(
//                         item['name'] ?? 'No Name',
//                         style: const TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       subtitle: Text(item['email'] ?? 'No Email'),
//                       trailing: Text(
//                         item['type'] != null ? formatType(item['type']) : 'Unknown',
//                         style: TextStyle(
//                           color: const Color(0xff4B70F5),
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'package:dashboard/main.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class Search extends StatefulWidget {
//   const Search({super.key});

//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   String? selectedType;
//   final TextEditingController searchController = TextEditingController();
//   bool isLoading = false;
//   Map<String, dynamic>? studentData;

//   final List<String> types = ['student', 'teacher', 'employee'];

//   Future<void> performSearch(String query) async {
//     if (selectedType == null || query.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//             content: Text('Please select a type and enter a search keyword')),
//       );
//       return;
//     }

//     setState(() {
//       isLoading = true;
//       studentData = null;
//     });


//      final token = storage.getString('token');
//     try {
//       final response = await http.post(
//         Uri.parse('http://137.184.50.2/api/v1/dashboard/search'),
//         headers: {
//            'Authorization': 'Bearer $token', 
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//         },
//         body: json.encode({
//           'q': query,
//           'type': selectedType,
//         }),
//       );

//       print('Response Status: ${response.statusCode}');
//       print('Response Data: ${response.body}');

//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
        
//         if (data['success'] == true && data['data'] != null && data['data'].isNotEmpty) {
//           setState(() {
//             studentData = data['data'][0]; // أخذ أول نتيجة فقط
//           });
//         } else {
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(content: Text('No results found')),
//           );
//         }
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Error: ${response.statusCode}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   String formatType(String type) {
//     return type[0].toUpperCase() + type.substring(1);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const Text('Search Page'),
//         backgroundColor: const Color(0xff4B70F5),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   flex: 3,
//                   child: SearchBar(
//                     controller: searchController,
//                     hintText: 'Search by name, email or number...',
//                     leading: const Icon(Icons.search, color: Color(0xff4B70F5)),
//                     onSubmitted: (query) => performSearch(query),
//                   ),
//                 ),
//                 const SizedBox(width: 10),
//                 Expanded(
//                   flex: 2,
//                   child: DropdownButtonFormField<String>(
//                     value: selectedType,
//                     decoration: const InputDecoration(
//                         hintText: 'Type',
//                         prefixIcon: Icon(
//                           Icons.person,
//                           color: Color(0xff4B70F5),
//                         ),
//                         border: OutlineInputBorder(),
//                         hintStyle: TextStyle(color: Color(0xff4B70F5))),
//                     items: types
//                         .map((type) => DropdownMenuItem(
//                               value: type,
//                               child: Text(formatType(type)),
//                             ))
//                         .toList(),
//                     onChanged: (value) {setState(() {
//                         selectedType = value;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//             ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () => performSearch(searchController.text),
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: const Color(0xff4B70F5),
//                 foregroundColor: Colors.white,
//                 minimumSize: const Size(double.infinity, 50),
//               ),
//               child: const Text('Search'),
//             ),
//             const SizedBox(height: 20),
//             if (isLoading)
//               const CircularProgressIndicator(),
//             if (studentData != null) ...[
//               const SizedBox(height: 20),
//               const Text(
//                 'Student Information',
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Color(0xff4B70F5),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildInfoCard('Personal Information', [
//                         _buildInfoRow('ID', studentData!['id'].toString()),
//                         _buildInfoRow('First Name', studentData!['user']['first_name']),
//                         _buildInfoRow('Last Name', studentData!['user']['last_name']),
//                         _buildInfoRow('Email', studentData!['user']['email']),
//                         _buildInfoRow('Gender', studentData!['gender']),
//                         _buildInfoRow('Location', studentData!['location']),
//                       ]),
//                       const SizedBox(height: 15),
//                       _buildInfoCard('Family Information', [
//                         _buildInfoRow('Father Name', studentData!['father_name']),
//                         _buildInfoRow('Mother Name', studentData!['mother_name']),
//                         _buildInfoRow('Father Number', studentData!['father_number']),
//                         _buildInfoRow('Mother Number', studentData!['mother_number']),
//                       ]),
//                       const SizedBox(height: 15),
//                       _buildInfoCard('Academic Information', [
//                         _buildInfoRow('Stage', studentData!['stage']),
//                         _buildInfoRow('Classroom', studentData!['classroom']),
//                         _buildInfoRow('Section', studentData!['section']),
//                       ]),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoCard(String title, List<Widget> children) {
//     return Card(
//       elevation: 3,
//       margin: const EdgeInsets.only(bottom: 10),
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               title,
//               style: const TextStyle(
//                 fontSize: 18,
//                 fontWeight: FontWeight.bold,
//                 color: Color(0xff4B70F5),
//               ),
//             ),
//             const Divider(),
//             ...children,
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildInfoRow(String label, String value) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(
//             flex: 2,
//             child: Text('$label:',
//               style: const TextStyle(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           Expanded(
//             flex: 3,
//             child: Text(
//               value.isNotEmpty ? value : 'Not provided',
//               style: TextStyle(
//                 color: value.isNotEmpty ? Colors.black : Colors.grey,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:dashboard/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? selectedType;
  final TextEditingController searchController = TextEditingController();
  bool isLoading = false;
  Map<String, dynamic>? searchData;
  List<dynamic> searchResults = [];

  
  final List<String> types = ['student', 'teacher', 'supervisor'];

  Future<void> performSearch(String query) async {
    if (selectedType == null || query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a type and enter a search keyword')),
      );
      return;
    }

    setState(() {
      isLoading = true;
      searchData = null;
      searchResults.clear();
    });


 final token = storage.getString('token');
    try {
      final response = await http.post(
        Uri.parse('http://137.184.50.2/api/v1/dashboard/search'),
        headers: {
             'Authorization': 'Bearer $token', 
            'Content-Type': 'application/json',
            'Accept': 'application/json',
        },
        body: json.encode({
          'q': query,
          'type': selectedType,
        }),
      );

      print('Response Status: ${response.statusCode}');
      print('Response Data: ${response.body}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        
        if (data['success'] == true && data['data'] != null && data['data'].isNotEmpty) {
          setState(() {
            searchResults = data['data'];
            searchData = data['data'][0];  
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No results found')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  String formatType(String type) {
    return type[0].toUpperCase() + type.substring(1);
  }


  Widget _buildInfoByType() {
    if (searchData == null) return Container();

    final type = searchData!['type'];
    
    if (type == 'student') {
      return _buildStudentInfo();
    } else if (type == 'teacher' || type == 'supervisor') {
      return _buildTeacherSupervisorInfo();
    } else {
      return const Text('Unknown type');
    }
  }

  
  Widget _buildStudentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoCard('Personal Information', [
          _buildInfoRow('ID', searchData!['id'].toString()),
          _buildInfoRow('First Name', searchData!['user']['first_name']),
          _buildInfoRow('Last Name', searchData!['user']['last_name']),
          _buildInfoRow('Email', searchData!['user']['email']),
          _buildInfoRow('Gender', searchData!['gender'] ?? 'Not provided'),
          _buildInfoRow('Location', searchData!['location'] ?? 'Not provided'),
        ]),
        const SizedBox(height: 15),
        _buildInfoCard('Family Information', [
          _buildInfoRow('Father Name', searchData!['father_name'] ?? 'Not provided'),
          _buildInfoRow('Mother Name', searchData!['mother_name'] ?? 'Not provided'),
          _buildInfoRow('Father Number', searchData!['father_number'] ?? 'Not provided'),
          _buildInfoRow('Mother Number', searchData!['mother_number'] ?? 'Not provided'),
          ]),
        const SizedBox(height: 15),
        _buildInfoCard('Academic Information', [
          _buildInfoRow('Stage', searchData!['stage'] ?? 'Not provided'),
          _buildInfoRow('Classroom', searchData!['classroom'] ?? 'Not provided'),
          _buildInfoRow('Section', searchData!['section'] ?? 'Not provided'),
        ]),
      ],
    );
  }

  Widget _buildTeacherSupervisorInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoCard('Personal Information', [
          _buildInfoRow('ID', searchData!['id'].toString()),
          _buildInfoRow('First Name', searchData!['user']['first_name']),
          _buildInfoRow('Last Name', searchData!['user']['last_name']),
          _buildInfoRow('Email', searchData!['user']['email']),
          _buildInfoRow('Phone', searchData!['phone_number'] ?? 'Not provided'),
        ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Search'),
        backgroundColor: const Color(0xff4B70F5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SearchBar(
                    controller: searchController,
                    hintText: 'Search by name, email or number...',
                    leading: const Icon(Icons.search, color: Color(0xff4B70F5)),
                    onSubmitted: (query) => performSearch(query),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: DropdownButtonFormField<String>(
                    value: selectedType,
                    decoration: const InputDecoration(
                        hintText: 'Type',
                        prefixIcon: Icon(
                          Icons.person,
                          color: Color(0xff4B70F5),
                        ),
                        border: OutlineInputBorder(),
                        hintStyle: TextStyle(color: Color(0xff4B70F5))),
                    items: types
                        .map((type) => DropdownMenuItem(
                              value: type,
                              child: Text(formatType(type)),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                        searchData = null;
                        searchResults.clear();
                      });
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => performSearch(searchController.text),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff4B70F5),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text('Search'),
            ),
            const SizedBox(height: 20),
            
            if (isLoading)
              const CircularProgressIndicator(),
            
            if (searchResults.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                'Found ${searchResults.length} result(s)',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4B70F5),
                ),),
            ],
            
            if (searchData != null) ...[
              const SizedBox(height: 20),
              Text(
                '${formatType(searchData!['type'])} Information',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff4B70F5),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildInfoByType(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff4B70F5),
              ),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value.isNotEmpty ? value : 'Not provided',
              style: TextStyle(
                color: value.isNotEmpty ? Colors.black : Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}