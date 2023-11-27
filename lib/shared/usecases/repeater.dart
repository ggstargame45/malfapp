import 'dart:async';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:malf/shared/check.dart';
import 'package:malf/shared/collections/iuserstatus.dart';
import 'package:malf/shared/network/token.dart';

Future<void> checkUserStatus() async {
  final isar = Isar.getInstance();
  if (isar!.iUserStatus
      .filter()
      .ownUserUniqIdMatches(Token().userUniqId)
      .findAllSync()
      .isEmpty) {
    final userStatus = IUserStatus();
    userStatus.ownUserUniqId = Token().userUniqId;
    userStatus.status = await checkStatus();
    isar.writeTxnSync(() {
      isar.iUserStatus.putSync(userStatus);
    });
  }

  if (isar.iUserStatus
          .filter()
          .ownUserUniqIdMatches(Token().userUniqId)
          .findAllSync()
          .first
          .status ==
      0) {
    final ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(userStatusChangeEvent, [receivePort.sendPort]);
    receivePort.listen((message) {
      if (message == 1) {
      } else if (message == -1) {}
    });
  }
}

void userStatusChangeEvent(List<dynamic> args) {
  SendPort sendPort = args[0];
  Timer.periodic(const Duration(seconds: 30), (timer) async {
    final int status = await checkStatus();
    if (status == 1) {
      final isar = Isar.getInstance();
      isar!.writeTxnSync(() {
        isar.iUserStatus
            .filter()
            .ownUserUniqIdMatches(Token().userUniqId)
            .findAllSync()
            .first
            .status = 1;
      });
      sendPort.send(status);
      timer.cancel();
    } else if (status == -1) {
      final isar = Isar.getInstance();
      isar!.writeTxnSync(() {
        isar.iUserStatus
            .filter()
            .ownUserUniqIdMatches(Token().userUniqId)
            .findAllSync()
            .first
            .status = -1;
      });
      sendPort.send(status);
      timer.cancel();
    } else if (status == 0) {
    } else {
      timer.cancel();
    }
  });
}
