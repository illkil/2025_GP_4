class ChatStore {
  ChatStore._();
  static final ChatStore instance = ChatStore._();

  final Set<String> users = {};

  void addUser(String name) => users.add(name);
  bool hasUser(String name) => users.contains(name);
}
