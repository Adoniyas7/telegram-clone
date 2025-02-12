import 'package:flutter/material.dart';
import 'package:telegram_clone/screens/contact_screen.dart';
import 'package:telegram_clone/screens/search_screen.dart';
import 'package:telegram_clone/screens/settings_screen.dart';
import 'package:telegram_clone/widgets/chat/bot_list.dart';
import 'package:telegram_clone/widgets/chat/channel_list.dart';
import 'package:telegram_clone/widgets/chat/chat_list.dart';
import 'package:telegram_clone/widgets/chat/group_list.dart';
import 'package:telegram_clone/widgets/stories/stories_bar.dart';
import 'contact_group_screen.dart';
import 'new_channel_screen.dart'; // Import the NewChannelScreen

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;

  const HomeScreen({Key? key, required this.isDarkMode, required this.toggleDarkMode}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _chatList = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  void _addNewMessage(String message) {
    setState(() {
      _chatList.add(message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Telegram'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen())),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All'),
            Tab(text: 'Groups'),
            Tab(text: 'Channels'),
            Tab(text: 'Bots'),
          ],
        ),
      ),
      drawer: _buildDrawer(context),
      body: Column(
        children: [
          const StoriesBar(),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ChatList(messages: _chatList),
                GroupList(),
                const ChannelList(channels: ['mm', 'nn', 'oo', 'pp', 'qq']),
                BotList(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.edit, color: Colors.white),
        onPressed: () => _showCreateOptions(context),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
            accountName: const Text('John Doe'),
            accountEmail: const Text('+1 234 567 8900'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
            otherAccountsPictures: [
              IconButton(
                icon: Icon(
                  widget.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                  color: Colors.white,
                ),
                onPressed: widget.toggleDarkMode, // Toggle dark mode on press
              ),
            ],
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('New Group'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ContactGroupScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Contacts'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactScreen(onMessageSent: (String message) {}),
                ),
              );
            },
          ),
          ListTile(leading: const Icon(Icons.call), title: const Text('Calls'), onTap: () {}),
          ListTile(leading: const Icon(Icons.bookmark), title: const Text('Saved Messages'), onTap: () {}),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.campaign),
            title: const Text('New Channel'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewChannelScreen()), // Navigate to NewChannelScreen
              );
            },
          ),
        ],
      ),
    );
  }

  void _showCreateOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.message),
            title: const Text('New Message'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactScreen(onMessageSent: (String message) {}),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('New Group'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ContactGroupScreen(),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.campaign),
            title: const Text('New Channel'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NewChannelScreen()),
              ); // Navigate to NewChannelScreen
            },
          ),
        ],
      ),
    );
  }
}