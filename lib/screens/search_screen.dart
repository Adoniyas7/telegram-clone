import 'package:flutter/material.dart';
import 'package:telegram_clone/widgets/chat/chat_list.dart';
import 'package:telegram_clone/widgets/chat/chat_tile.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _filteredChats = [];

  @override
  void initState() {
    super.initState();
    _filteredChats = [...ChatList.dummyChats];
  }

  void _performSearch(String query) {
    setState(() {
      _filteredChats = ChatList.dummyChats
          .where((chat) =>
              chat['name']!.toLowerCase().contains(query.toLowerCase()) ||
              chat['message']!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: _performSearch,
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredChats.length,
        itemBuilder: (context, index) {
          final chat = _filteredChats[index];
          return ChatTile(
            name: chat['name']!,
            message: chat['message']!,
            time: chat['time']!,
            avatarUrl: chat['avatar']!,
            unreadCount: int.parse(chat['unread']!),
            isOnline: chat['online'] == 'true',
          );
        },
      ),
    );
  }
}
