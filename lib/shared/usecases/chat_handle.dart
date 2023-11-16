


class ChatHandler{
  static final ChatHandler _singletonModel = ChatHandler._internal();
  factory ChatHandler() => _singletonModel;
  ChatHandler._internal();
}