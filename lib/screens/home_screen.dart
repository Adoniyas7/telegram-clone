import 'package:flutter/material.dart';
import 'package:telegram_clone/screens/search_screen.dart';
import 'package:telegram_clone/screens/settings_screen.dart';
import 'package:telegram_clone/widgets/chat/chat_list.dart';
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
      body: Column(
        children: [
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                const ChatList(),
                GroupList(),
                ChannelList(
                  channels: ['mm', 'nn', 'oo', 'pp', 'qq'],
                ),
                BotList(),
              ],
            ),
          ),
        ],
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

  Widget _buildDrawer(context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            accountName: Text('John Doe'),
            accountEmail: Text('+1 234 567 8900'),
            currentAccountPicture: CircleAvatar(
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
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('New Group'),
            onTap: () {
              // Handle new group
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.campaign),
            title: const Text('New Channel'),
            onTap: () {
              // Handle new channel
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
