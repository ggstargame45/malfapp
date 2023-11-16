import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';

Future<int> checkStatus() async {
  return (await Dio(BaseOptions(
              baseUrl: baseUrl,
              headers: {'Authorization': Token().refreshToken}))
          .get("/user/status"))
      .data['data'][0]["user_status"];
}

Future<bool> doAuth(BuildContext context) async {
  int status = await checkStatus();
  if (status == 1) {
    return true;
    // _pagingController.refresh();
  } else if (status == -1) {
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("school_auth_title".tr()),
            content: Text("school_auth_title".tr()),
            actions: [
              TextButton(
                  onPressed: () async {
                    await context.push("/schoolAuth");
                    context.pop();
                  },
                  child: Text("next".tr())),
              TextButton(
                  onPressed: () {
                    context.pop();
                  },
                  child: Text("cancel".tr())),
            ],
          );
        });
  } else if (status == 0) {
    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (BuildContext contexts) {
          return AlertDialog(
            title: Text("school_auth_process_message".tr()),
            content: Text("school_auth_progress".tr()),
            actions: [
              TextButton(
                  onPressed: () async {
                    await context.push("/schoolAuth");
                    context.pop();
                  },
                  child: Text("confirm".tr())),
              TextButton(
                  onPressed: () {
                    contexts.pop();
                  },
                  child: Text("cancel".tr()))
            ],
          );
        });
  }
  return false;
}
