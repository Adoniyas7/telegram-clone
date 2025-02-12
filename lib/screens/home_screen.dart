import 'package:flutter/material.dart';
import 'package:telegram_clone/screens/contact_screen.dart';
import 'package:telegram_clone/screens/search_screen.dart';
import 'package:telegram_clone/screens/settings_screen.dart';
import 'package:telegram_clone/widgets/chat/bot_list.dart';
import 'package:telegram_clone/widgets/chat/channel_list.dart';
import 'package:telegram_clone/widgets/chat/chat_list.dart';
import 'package:telegram_clone/widgets/chat/group_list.dart';
import 'contact_group_screen.dart';
import 'new_channel_screen.dart'; // Import the NewChannelScreen
import 'my_profile_screen.dart';
import 'package:telegram_clone/widgets/stories/collapsed_stories_bar.dart';
import 'package:telegram_clone/widgets/stories/expanded_stories_bar.dart';

class HomeScreen extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback toggleDarkMode;

  const HomeScreen(
      {Key? key, required this.isDarkMode, required this.toggleDarkMode})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isStoriesExpanded = false;
  bool _showStoriesBar = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _toggleStoriesExpanded() {
    setState(() {
      _isStoriesExpanded = !_isStoriesExpanded;
    });
  }

  double _lastScrollOffset = 0.0;

  void _handleScroll(double offset) {
    setState(() {
      if (offset > _lastScrollOffset &&
          _tabController.indexIsChanging == false) {
        // scrl down
        _isStoriesExpanded = true;
        _showStoriesBar = true;
      } else if (offset < _lastScrollOffset &&
          _tabController.indexIsChanging == false) {
        // scrl up
        _isStoriesExpanded = false;
        _showStoriesBar = true;
      }
      _lastScrollOffset = offset;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: _showStoriesBar && !_isStoriesExpanded
                  ? CollapsedStoriesBar(onTap: _toggleStoriesExpanded)
                  : Text(
                      _getTitleForCurrentTab()), // Title when stories bar is hidden
            ),
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
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(
              _showStoriesBar && _isStoriesExpanded ? 150.0 : 48.0),
          child: Column(
            children: [
              if (_showStoriesBar && _isStoriesExpanded)
                const ExpandedStoriesBar(),
              TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: 'People'),
                  Tab(text: 'Groups'),
                  Tab(text: 'Channels'),
                  Tab(text: 'Bots'),
                ],
              ),
            ],
          ),
        ),
      ),
      drawer: _buildDrawer(context),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification) {
            _handleScroll(scrollNotification.metrics.pixels);
          }
          return true;
        },
        child: TabBarView(
          controller: _tabController,
          children: [
            ChatList(),
            GroupList(),
            ChannelList(channels: ['mm', 'nn', 'oo', 'pp', 'qq']),
            BotList(),
          ],
        ),
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
            leading: const Icon(Icons.account_circle),
            title: const Text('My Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MyProfileScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.account_balance_wallet),
            title: const Text('Wallet'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.group),
            title: const Text('New Group'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ContactGroupScreen()),
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
                  builder: (context) =>
                      ContactScreen(onMessageSent: (String message) {}),
                ),
              );
            },
          ),
          ListTile(
              leading: const Icon(Icons.call),
              title: const Text('Calls'),
              onTap: () {}),
          ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Saved Messages'),
              onTap: () {}),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SettingsScreen())),
          ),
          ListTile(
            leading: const Icon(Icons.campaign),
            title: const Text('New Channel'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const NewChannelScreen()), // Navigate to NewChannelScreen
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Invite Friends'),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Telegram Features'),
            onTap: () {},
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
                  builder: (context) =>
                      ContactScreen(onMessageSent: (String message) {}),
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
                MaterialPageRoute(
                    builder: (context) => const NewChannelScreen()),
              ); // Navigate to NewChannelScreen
            },
          ),
        ],
      ),
    );
  }

  String _getTitleForCurrentTab() {
    switch (_tabController.index) {
      case 0:
        return 'People';
      case 1:
        return 'Groups';
      case 2:
        return 'Channels';
      case 3:
        return 'Bots';
      default:
        return 'Home';
    }
  }
}
