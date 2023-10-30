import 'dart:convert';

class ChattingListModel {
  final int postId;
  final List<dynamic> picture;
  final String title;
  final int personnel;

  ChattingListModel(
      {required this.postId,
      required this.picture,
      required this.title,
      required this.personnel});

  // Factory method to create a Post instance from a Map (usually from JSON)
  factory ChattingListModel.fromJson(Map<String, dynamic> json) {
    return ChattingListModel(
      postId: json['post_id'],
      picture: jsonDecode(json['picture']),
      title: json['title'],
      personnel: json['personnel'],
    );
  }

  // Method to convert a Post instance into a Map (usually for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'post_id': postId,
      'picture': picture,
      'title': title,
      'personnel': personnel,
    };
  }
}
