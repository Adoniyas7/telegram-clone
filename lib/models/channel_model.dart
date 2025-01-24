class Channel {
  final String id;
  final String name;
  final String description;
  final String avatarUrl;
  final int subscribersCount;
  final bool isVerified;
  final String lastMessage;
  final String lastMessageTime;

  Channel({
    required this.id,
    required this.name,
    required this.description,
    required this.avatarUrl,
    required this.subscribersCount,
    required this.isVerified,
    required this.lastMessage,
    required this.lastMessageTime,
  });
}
