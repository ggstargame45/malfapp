//singleton
class ChatTimeMap{
  Map<String, String> map = Map<String, String>();

  static final ChatTimeMap _instance = ChatTimeMap._internal();

  factory ChatTimeMap() {
    return _instance;
  }

  ChatTimeMap._internal();

  void init(){
    
  }
}