import 'package:flutter/material.dart';

class CommunityDetailScreen extends StatefulWidget {
  final int postId;
  const CommunityDetailScreen({super.key, required this.postId});
  static const routeName = '/communityDetail';

  @override
  State<CommunityDetailScreen> createState() => _CommunityDetailScreenState();
}

class _CommunityDetailScreenState extends State<CommunityDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
