import 'package:flutter/material.dart';
import 'package:telegram_clone/screens/new_message_screen.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({Key? key, required void Function(String message) onMessageSent}) : super(key: key);

  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
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
    {"name": "Daniel Thomas", "image": "https://randomuser.me/api/portraits/men/11.jpg"},
    {"name": "Olivia White", "image": "https://randomuser.me/api/portraits/women/12.jpg"},
    {"name": "Matthew Harris", "image": "https://randomuser.me/api/portraits/men/13.jpg"},
    {"name": "Isabella Martin", "image": "https://randomuser.me/api/portraits/women/14.jpg"},
    {"name": "Ethan Thompson", "image": "https://randomuser.me/api/portraits/men/15.jpg"},
    {"name": "Mia Robinson", "image": "https://randomuser.me/api/portraits/women/16.jpg"},
    {"name": "Alexander Clark", "image": "https://randomuser.me/api/portraits/men/17.jpg"},
    {"name": "Charlotte Lewis", "image": "https://randomuser.me/api/portraits/women/18.jpg"},
    {"name": "Benjamin Walker", "image": "https://randomuser.me/api/portraits/men/19.jpg"},
    {"name": "Amelia Hall", "image": "https://randomuser.me/api/portraits/women/20.jpg"},
  ];

  List<Map<String, String>> filteredContacts = [];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Message'),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
          // Contact List
          Expanded(
            child: ListView.builder(
              itemCount: filteredContacts.length,
              itemBuilder: (context, index) {
                return ListTile(
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => NewMessageScreen(
                          // ignore: avoid_types_as_parameter_names
                          contactName: filteredContacts[index]["name"]!, onMessageSent: (String ) {  },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
