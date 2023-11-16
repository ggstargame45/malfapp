import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  static const String routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    bool some = false;
    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 0,
        centerTitle: false,
        title: Text('notification'.tr()),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 0,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.push('/reviewList/10');
                      },
                      child: Container(
                        height: 105,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ListTile(
                              style: ListTileStyle.drawer,
                              leading: CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(
                                    'assets/images/login_background.png'),
                              ),
                              title: Text(index % 2 == 0
                                  ? "apply_rejected".tr()
                                  : "apply_accepted".tr()),
                              subtitle: Text('메시지'),
                              trailing: Checkbox(
                                shape: CircleBorder(),
                                  value: true,
                                  onChanged: (value) {
                                    if (value == null) return;
                                    some = value;
                                  }),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
