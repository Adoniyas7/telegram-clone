class Contact {
  final String id;
  final String name;
  final String phoneNumber;
  final String? username;
  final String avatarUrl;
  final bool isOnline;
  final String? bio;

  Contact({
    required this.id,
    required this.name,
    required this.phoneNumber,
    this.username,
    required this.avatarUrl,
    required this.isOnline,
    this.bio,
  });
}
