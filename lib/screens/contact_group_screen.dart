import 'package:flutter/material.dart';

class ContactGroupScreen extends StatefulWidget {
  const ContactGroupScreen({Key? key}) : super(key: key);

  @override
  _ContactGroupScreenState createState() => _ContactGroupScreenState();
}

class _ContactGroupScreenState extends State<ContactGroupScreen> {
  final TextEditingController _searchController = TextEditingController();

  // List of contacts with names and images
  final List<Map<String, String>> contacts = [
    {"name": "John Doe", "image": "https://randomuser.me/api/portraits/men/1.jpg"},
    {"name": "Jane Smith", "image": "https://randomuser.me/api/portraits/women/2.jpg"},
    {"name": "Michael Brown", "image": "https://randomuser.me/api/portraits/men/3.jpg"},
    {"name": "Emily Johnson", "image": "https://randomuser.me/api/portraits/women/4.jpg"},
    {"name": "David Wilson", "image": "https://randomuser.me/api/portraits/men/5.jpg"},
    {"name": "Sarah Davis", "image": "https://randomuser.me/api/portraits/women/6.jpg"},
    {"name": "Chris Miller", "image": "https://randomuser.me/api/portraits/men/7.jpg"},
    {"name": "Laura Garcia", "image": "https://randomuser.me/api/portraits/women/8.jpg"},
    {"name": "James Martinez", "image": "https://randomuser.me/api/portraits/men/9.jpg"},
    {"name": "Sophia Anderson", "image": "https://randomuser.me/api/portraits/women/10.jpg"},
  ];

  List<Map<String, String>> filteredContacts = [];
  Set<int> selectedContacts = {}; // Set to store selected contacts

  @override
  void initState() {
    super.initState();
    filteredContacts = contacts;
    _searchController.addListener(_filterContacts);
  }

  void _filterContacts() {
    setState(() {
      filteredContacts = contacts
          .where((contact) =>
              contact["name"]!.toLowerCase().contains(_searchController.text.toLowerCase()))
          .toList();
    });
  }

  void _toggleSelection(int index) {
    setState(() {
      if (selectedContacts.contains(index)) {
        selectedContacts.remove(index);
      } else {
        selectedContacts.add(index);
      }
    });
  }

  void _createGroup() {
    if (selectedContacts.isNotEmpty) {
      final selectedNames = selectedContacts
          .map((index) => filteredContacts[index]["name"])
          .join(", ");
      print("Creating group with: $selectedNames");
      Navigator.pop(context); // Close the screen
    } else {
      print("No contacts selected!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _createGroup, // Trigger group creation
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Who would you like to add?', // Updated hint text
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey[300],
                        child: ClipOval(
                          child: Image.network(
                            filteredContacts[index]["image"]!,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const CircularProgressIndicator();
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.person);
                            },
                          ),
                        ),
                      ),
                      title: Text(filteredContacts[index]["name"]!),
                      onTap: () => _toggleSelection(index), // Toggle contact selection
                    ),
                    // Small circle for selection
                    if (selectedContacts.contains(index))
                      const Positioned(
                        bottom: 8,
                        right: 8,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}