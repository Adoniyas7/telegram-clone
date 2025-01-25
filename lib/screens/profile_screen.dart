import 'package:flutter/material.dart';
import 'package:telegram_clone/models/contact_model.dart';

class ProfileScreen extends StatefulWidget {
  final bool isEditing;
  final Contact contact;

  const ProfileScreen({
    super.key,
    this.isEditing = false,
    required this.contact,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;
  late TextEditingController _usernameController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _isEditing = widget.isEditing;
    _nameController = TextEditingController(text: widget.contact.name);
    _bioController = TextEditingController(text: widget.contact.bio ?? '');
    _usernameController =
        TextEditingController(text: widget.contact.username ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Profile' : 'Profile'),
        actions: [
          if (!widget.isEditing)
            IconButton(
              icon: Icon(_isEditing ? Icons.done : Icons.edit),
              onPressed: () => setState(() => _isEditing = !_isEditing),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.contact.avatarUrl),
                ),
                if (_isEditing)
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: () {},
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            _buildTextField(
              'Name',
              _nameController,
              enabled: _isEditing,
            ),
            _buildTextField(
              'Username',
              _usernameController,
              enabled: _isEditing,
              prefix: '@',
            ),
            _buildTextField(
              'Bio',
              _bioController,
              enabled: _isEditing,
              maxLines: 3,
            ),
            if (!_isEditing) ...[
              _buildInfoTile('Phone', widget.contact.phoneNumber),
              _buildInfoTile('Joined', 'February 2024'),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    bool enabled = true,
    String? prefix,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        enabled: enabled,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefix: prefix != null ? Text(prefix) : null,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return ListTile(
      title: Text(label),
      subtitle: Text(value),
    );
  }
}
