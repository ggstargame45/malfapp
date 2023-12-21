import 'package:flutter/material.dart';

class CommunityWriteScreen extends StatefulWidget {
  const CommunityWriteScreen({super.key, required this.kind, this.extraData});

  final String kind;
  final Object? extraData;

  @override
  State<CommunityWriteScreen> createState() => _CommunityWriteScreenState();
}

class _CommunityWriteScreenState extends State<CommunityWriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}