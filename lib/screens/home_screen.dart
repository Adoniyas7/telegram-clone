import 'package:flutter/material.dart';
import 'package:telegram_clone/screens/search_screen.dart';
import 'package:telegram_clone/screens/settings_screen.dart';
import 'package:telegram_clone/widgets/chat/chat_list.dart';
import 'package:telegram_clone/widgets/chat/group_list.dart';
import 'package:telegram_clone/widgets/chat/channel_list.dart';
import 'package:telegram_clone/widgets/chat/bot_list.dart';
import 'package:telegram_clone/widgets/stories/collapsed_stories_bar.dart';
import 'package:telegram_clone/widgets/stories/expanded_stories_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                  Tab(text: 'All'),
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

  String _getTitleForCurrentTab() {
    switch (_tabController.index) {
      case 0:
        return 'All';
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
