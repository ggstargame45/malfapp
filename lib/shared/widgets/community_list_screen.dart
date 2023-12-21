import 'package:flutter/material.dart';



class CommunityListScreen extends StatefulWidget {
  const CommunityListScreen({super.key, required this.kind, this.kindId = 1, this.extraData});
  final String kind;
  final int kindId;
  final Object? extraData;

  @override
  State<CommunityListScreen> createState() => _CommunityListScreenState();
}

class _CommunityListScreenState extends State<CommunityListScreen> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}