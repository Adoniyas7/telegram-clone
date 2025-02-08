import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Added for navigation
import 'package:telegram_clone/screens/search_screen.dart';
import 'package:telegram_clone/screens/settings_screen.dart';
import 'package:telegram_clone/screens/new_message_screen.dart'; // Import the new message screen
import 'package:telegram_clone/widgets/chat/chat_list.dart';
import 'package:telegram_clone/widgets/stories/stories_bar.dart';
import 'package:telegram_clone/widgets/chat/group_list.dart';
import 'package:telegram_clone/widgets/chat/channel_list.dart';
import 'package:telegram_clone/widgets/chat/bot_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Telegram'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
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
      body: SafeArea( // Wrap the body with SafeArea to avoid overlapping with system UI
        child: Column(
          children: [
            const StoriesBar(),
            Expanded( // Use Expanded to allow the TabBarView to take available space
              child: TabBarView(
                controller: _tabController,
                children: [
                  const ChatList(),
                  GroupList(),
                  const ChannelList(
                    channels: ['mm', 'nn', 'oo', 'pp', 'qq'],
                  ),
                  BotList(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        child: const Icon(Icons.edit, color: Colors.white),
        onPressed: () {
          _showCreateOptions(context);
        },
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            accountName: const Text('John Doe'),
            accountEmail: const Text('+1 234 567 8900'),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('New Group'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Contacts'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.call),
            title: const Text('Calls'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Saved Messages'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
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
              Navigator.pop(context); // Close bottom sheet first
              Get.to(() => NewMessageScreen()); // Navigate to the New Message screen
            },
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('New Group'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.campaign),
            title: const Text('New Channel'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}