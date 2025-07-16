import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? selectedType;
  final TextEditingController searchController = TextEditingController();

  final List<String> types = ['Student', 'Teacher', 'Employee'];

  void performSearch(String query) {
    if (selectedType == null || query.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Please select a type and enter a search keyword')),
      );
      return;
    }

    print('Searching for $query in $selectedType');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Center(
              child: Text(
                'Searching',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff4B70F5)),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: SearchBar(
                    controller: searchController,
                    hintText: 'Search...',
                    leading: const Icon(Icons.search, color: Color(0xff4B70F5)),
                    onSubmitted: (query) => performSearch(query),
                  ),
                ),
                const Spacer(),
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
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedType = value;
                      });
                    },
                  ),
                ),
                const SizedBox(width: 10),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
