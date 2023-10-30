import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';



class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  static const String routeName = '/notification';

  @override
  Widget build(BuildContext context) {
    double maxHeight = MediaQuery.of(context).size.height;
    double maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('메시지'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("채팅방 수 : "),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                        side: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      elevation: 16,
                      shadowColor: Colors.grey,
                      child: ListTile(
                        style: ListTileStyle.drawer,
                        leading: CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage('assets/images/login_background.png'),
                        ),
                        title: Text('이름'),
                        subtitle: Text('메시지'),
                        trailing: Text('시간'),
                        onTap: () {
                          
                          GoRouter.of(context).push('/chatRoom/$index');
                        },
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