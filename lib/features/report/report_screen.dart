import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/shared/logger.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen(
      {super.key,
      required this.reportType,
      required this.id,
      required this.title});

  //chat, post, user, community, reply
  final String reportType;
  final String id;
  final String title;

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _formKey = GlobalKey<FormState>();
  String _reportText = '';
  String _emailText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              context.pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: Text('report'.tr()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      label: Text('report_type'.tr()),
                      //labelText: 'Report Type',
                      border: const OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: widget.reportType),
                    readOnly: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'title'.tr(),
                      border: const OutlineInputBorder(),
                    ),
                    controller: TextEditingController(text: widget.title),
                    readOnly: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "context".tr(),
                      border: const OutlineInputBorder(),
                      hintText:
                          "${"report_hint".tr()}\n${"writing_warning_second".tr()}\n${"report_time_check".tr()}",
                    ),
                    maxLines: 15,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "report_hint".tr();
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _reportText = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'email_optional'.tr(),
                      helperText: "report_reply_email_title".tr(),
                      hintText: "report_reply_email_hint".tr(),
                      border: const OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _emailText = value;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        // TODO: Submit report
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (BuildContext contextn) {
                              return AlertDialog.adaptive(
                                title: const Text('report').tr(),
                                content: const Text('report_time_check').tr(),
                                actions: [
                                  TextButton(
                                    onPressed: () async {
                                      try {
                                        final dio = Dio(
                                          BaseOptions(
                                            baseUrl: baseUrl,
                                            headers: {
                                              "Authorization":
                                                  Token().refreshToken,
                                            },
                                          ),
                                        );
                                        logger.d(
                                            '$baseUrl/report/${widget.reportType}');
                                        final response = await dio.post(
                                          (widget.reportType == "reply")
                                              ? "/report/community/${widget.reportType}"
                                              : "/report/${widget.reportType}",
                                          data: {
                                            if (widget.reportType == "post" ||
                                                widget.reportType ==
                                                    "community")
                                              "post_id": widget.id,
                                            if (widget.reportType == "user")
                                              "user_uniq_id": widget.id,
                                            if (widget.reportType == "chat")
                                              "chat_id": widget.id,
                                            "report_info": _reportText,
                                            "report_email": _emailText,
                                          },
                                        );
                                        if (response.statusCode == 200) {
                                          logger.d('Report submitted');
                                          context.pop();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "ask_to_again".tr())));
                                        }
                                      } on Exception catch (e) {
                                        // TODO
                                        logger.e(e);
                                      }
                                      context.pop();
                                    },
                                    child: const Text('report').tr(),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        contextn.pop();
                                      },
                                      child: const Text('cancel').tr())
                                ],
                              );
                            });
                      }
                    },
                    child: Text('submit'.tr()),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
