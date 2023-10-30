import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:malf/shared/theme/test_styles.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dio/dio.dart';
import 'package:malf/shared/network/base_url.dart';

final logger = Logger();
Color mainColor = const Color.fromARGB(255, 97, 195, 255);
double maxHeight(BuildContext context) => MediaQuery.of(context).size.height;
double maxWidth(BuildContext context) => MediaQuery.of(context).size.width;

const version = 'R1.0.0';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const String routeName = '/login';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void checkVersion(BuildContext context) async {
    final dioCheck = Dio(BaseOptions(
      baseUrl: checkUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    try {
      final response = await dioCheck.get('/version');
      if (response.data['version'] != version) {
        logger.i('update');
        //show alertdialog
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext contextn) {
              return AlertDialog.adaptive(
                title: const Text('update_title').tr(),
                content: const Text('update_message').tr(),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(contextn);
                      checkVersion(context);
                    },
                    child: const Text('confirm').tr(),
                  ),
                ],
              );
            });
      }
    } catch (e) {
      logger.e(e);
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext contextn) {
            return AlertDialog(
              title: const Text('device_error_title').tr(),
              // content: const Text('device_error_message').tr(),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(contextn);
                    checkServer(context);
                  },
                  child: const Text('confirm').tr(),
                ),
              ],
            );
          });
    }
  }

  void checkServer(BuildContext context) async {
    final dioCheck = Dio(BaseOptions(
      baseUrl: checkUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    try {
      final response = await dioCheck.get('/server');
      if (response.data['status'] == 1) {
        logger.i('server ok');
      } else {
        logger.i('server not ok');
        //show alertdialog
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext contextn) {
              return AlertDialog.adaptive(
                title: const Text('server_error_title').tr(),
                content: Text(response.data['message']),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(contextn);
                      checkServer(context);
                    },
                    child: const Text('confirm').tr(),
                  ),
                ],
              );
            });
      }
    } catch (e) {
      logger.e(e);
      //show alertdialog
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext contextn) {
            return AlertDialog(
              title: const Text('device_error_title').tr(),
              // content: const Text('device_error_message').tr(),
              content: Text(e.toString()),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(contextn);
                    checkServer(context);
                  },
                  child: const Text('confirm').tr(),
                ),
              ],
            );
          });
    }
  }

  Future<void> initer(BuildContext context) async {
    checkVersion(context);
    checkServer(context);

    // if (Token().refreshToken != "") {
    //   context.go('/home');
    // }
  }

  @override
  Widget build(BuildContext context) {
    initer(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            image: AssetImage('assets/images/login_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    alignment: Alignment.center,
                    child: const Image(
                      fit: BoxFit.contain,
                      image: AssetImage('assets/logos/login_logo.png'),
                    )),
                Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 5,
                    ),
                    child: const Text("SNS_login_title",
                        style: TextStyle(
                          fontFamily: AppTextStyles.fontFamily,
                          color: Colors.white,
                          fontSize: 13,
                        )).tr()),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.height * 0.1,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image:
                                      AssetImage('assets/images/kakao.png'))),
                          child: GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push('/loginAuth/kakao');
                              // showDialog(
                              //     context: context,
                              //     builder: (BuildContext contexnt) {
                              //       return AlertDialog(
                              //         title: const Text('sign_up_title').tr(),
                              //         content: const Text('kakao_login_message')
                              //             .tr(),
                              //         actions: [
                              //           TextButton(
                              //             onPressed: () {
                              //               Navigator.pop(contexnt);
                              //               GoRouter.of(context)
                              //                   .push('/loginAuth/kakao');
                              //             },
                              //             child: const Text('confirm').tr(),
                              //           ),
                              //         ],
                              //       );
                              //     });
                            },
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.height * 0.1,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image: AssetImage('assets/images/line.png'))),
                          child: GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push('/loginAuth/line');
                            },
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * 0.1,
                          width: MediaQuery.of(context).size.height * 0.1,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image:
                                      AssetImage('assets/images/google.png'))),
                          child: GestureDetector(
                            onTap: () {
                              GoRouter.of(context).push('/loginAuth/google');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //email login button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 5,
                  ),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.05,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        GoRouter.of(context).push('/emailLogin');
                      },
                      child: Text(
                        "email_login".tr(),
                        style: const TextStyle(
                          fontFamily: AppTextStyles.fontFamily,
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ).tr(),
                    ),
                  ),
                ),

                Expanded(child: Container()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                          "가입을 진행할 경우, 서비스 약관 및 개인정보 처리방침에 동의하는 것으로 간주됩니다.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontFamily: AppTextStyles.fontFamily,
                            color: Colors.white,
                            fontSize: 10,
                          )).tr(),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          launchUrl(
                            Uri.parse(
                                'https://marsh-swordtail-f9e.notion.site/MALF-6807b32f4ad2497c8ec544d82a156435?pvs=4'),
                          );
                        },
                        child: Text("see_terms",
                            style: const TextStyle(
                              fontFamily: AppTextStyles.fontFamily,
                              color: Colors.white,
                              fontSize: 10,
                            )).tr()),
                    TextButton(
                        onPressed: () {
                          launchUrl(
                            Uri.parse(
                                'https://marsh-swordtail-f9e.notion.site/MALF-4c701b51a0c34c71b2047962374036d2?pvs=4'),
                          );
                        },
                        child: Text("see_policy",
                            style: const TextStyle(
                              fontFamily: AppTextStyles.fontFamily,
                              color: Colors.white,
                              fontSize: 10,
                            )).tr())
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.kind});

  final String kind;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late WebViewController _controller;
  String accessToken = '';
  String refreshToken = '';

  @override
  void initState() {
    super.initState();

    final PlatformWebViewControllerCreationParams params =
        (WebViewPlatform.instance is WebKitWebViewPlatform)
            ? WebKitWebViewControllerCreationParams(
                allowsInlineMediaPlayback: true,
                mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
              )
            : const PlatformWebViewControllerCreationParams();

    final WebViewCookieManager cookieManager = WebViewCookieManager();
    cookieManager.clearCookies();

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent("random")
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
              Page resource error:
                code: ${error.errorCode}
                description: ${error.description}
                errorType: ${error.errorType}
                isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) async {
            logger.i('allowing navigation to ${request.url}');
            if (request.url.startsWith(
                'https://malftravel.com/auth/${widget.kind}/callback')) {
              Response response = await Dio().get(request.url);
              logger.d(response.data);
              await Token().setToken(response.data['token']['refreshToken'],
                  response.data['token']['accessToken']);
              loadHome(request.url);
              //destroy WebView
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      // ..addJavaScriptChannel(
      //   'Toaster',
      //   onMessageReceived: (JavaScriptMessage message) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text(message.message)),
      //     );
      //   },
      // )
      ..loadRequest(Uri.parse('$baseUrl/auth/${widget.kind}'));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    _controller = controller;
  }

  void loadHome(String url) async {
    checkProfile();

    logger.d('accessToken : ${Token().accessToken}}');
    logger.d('refreshToken : ${Token().refreshToken}');
    logger.d('userUniqId : ${Token().userUniqId}');

    Response response =
        await Dio(BaseOptions(headers: {'Authorization': Token().refreshToken}))
            .get("${baseUrl}/user/profile/${Token().userUniqId}");
    logger.d(response.data['data']);
    try {
      if (response.data['data'].toString() == "[]") {
        logger.d("가입되지 않은 유저");
        final dio = Dio(BaseOptions(
          headers: {'Authorization': Token().refreshToken},
          contentType: "multipart/form-data",
        ));
        final formData = FormData.fromMap({
          'user_type': 1,
          'nation': 410,
          'gender': 1,
          'nickname': Token().userUniqId,
          'birthday': "2021-10-10T10:10:10",
          'default_language': -1,
          "description": "프로필 설명을 꾸며주세요!",
          "able_language": "[]",
          "interest": "[\"당신의 관심사를 알려주세요!\"]",
        });

        response = await dio.post("${baseUrl}/user/profile", data: formData);

        logger.d(response.data);
      } else {
        logger.d("이미 가입된 유저");
      }
    } catch (e) {
      logger.e(e);
    }
    context
      ..pop()
      ..go('/home');
  }

  void checkProfile() {}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WebViewWidget(controller: _controller)));
  }
}
