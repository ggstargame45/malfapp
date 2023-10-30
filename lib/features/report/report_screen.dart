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

  //chat, post, user
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
            icon: Icon(
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
                TextField(
                  decoration: InputDecoration(
                    label: Text('Report Type'),
                    //labelText: 'Report Type',
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: widget.reportType),
                  readOnly: true,
                ),
                SizedBox(height: 16.0),
                TextField(
                  decoration: InputDecoration(
                    labelText: 'title'.tr(),
                    border: OutlineInputBorder(),
                  ),
                  controller: TextEditingController(text: widget.title),
                  readOnly: true,
                ),
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'report'.tr() + " " + "content".tr(),
                    border: OutlineInputBorder(),
                    hintText: "report_hint".tr(),
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
                SizedBox(height: 16.0),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email (Optional)',
                    helperText: "report_reply_email_title".tr(),
                    hintText: "report_reply_email_hint".tr(),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _emailText = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Submit report

                      try {
                        final dio = Dio(
                          BaseOptions(
                            baseUrl: baseUrl,
                            headers: {
                              "Authorization": Token().refreshToken,
                            },
                          ),
                        );
                        logger.d('$baseUrl/report/${widget.reportType}');
                        final response = await dio.post(
                          "/report/${widget.reportType}",
                          data: {
                            if (widget.reportType == "post")
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
                        } else {
                          logger.e('Report failed ${response.statusCode}');
                        }
                      } on Exception catch (e) {
                        // TODO
                        logger.e(e);
                      }
                    }
                  },
                  child: Text('submit'.tr()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
