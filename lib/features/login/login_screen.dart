import 'dart:convert';
import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/shared/network/token.dart';
import 'package:malf/shared/theme/app_colors.dart';
import 'package:malf/shared/theme/test_styles.dart';
import 'package:malf/shared/usecases/block_handle.dart';
import 'package:malf/shared/usecases/loading.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dio/dio.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/shorebird.dart';

import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:malf/shared/logger.dart';
import 'package:random_name_generator/random_name_generator.dart';
import 'package:restart_app/restart_app.dart';
import 'package:update_available/update_available.dart';

const Color mainColor = Color.fromARGB(255, 97, 195, 255);
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
  Future<void> checkVersion() async {
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
                      checkVersion();
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
                    checkVersion();
                  },
                  child: const Text('confirm').tr(),
                ),
              ],
            );
          });
    }
  }

  Future<void> checkServer() async {
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
                      checkServer();
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
                    checkServer();
                  },
                  child: const Text('confirm').tr(),
                ),
              ],
            );
          });
    }
  }

  Future<void> patchAvailable() async {
    bool isUpdated = false;
    while (shorebirdCodePush.isShorebirdAvailable()) {
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext contextn) {
            return AlertDialog.adaptive(
              title: const Text('server_error_title').tr(),
              content: const Text('server_error_title').tr(),
              actions: [
                TextButton(
                  onPressed: () async {
                    contextn.pop();
                    return;
                  },
                  child: const Text('confirm').tr(),
                ),
              ],
            );
          });
    }
    //TODO
    while ((await shorebirdCodePush.isNewPatchAvailableForDownload())) {
      await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext contextn) {
            return AlertDialog(
              title: Text("update_title".tr()),
              content: Text("update_message".tr()),
              actions: [
                TextButton(
                  onPressed: () async {
                    await patch();
                    isUpdated = true;
                    contextn.pop();
                  },
                  child: const Text('confirm').tr(),
                ),
                TextButton(
                    onPressed: () {
                      contextn.pop();
                    },
                    child: const Text('cancel',
                        style: TextStyle(
                          color: Colors.grey,
                        )).tr())
              ],
            );
          });
    }
    if (isUpdated) {
      Restart.restartApp();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initer();
    });
  }

  Future<void> patch() async {
    loading(context);
    await shorebirdCodePush.downloadUpdateIfAvailable();
    context.pop();
  }

  Future<void> initer() async {
    loading(context);

    // await _showUpdateDialog();

    await patchAvailable();

    await checkVersion();
    await checkServer();

    logger.d("refreshToken : ${Token().refreshToken}");
    context.pop();
    if (Token().refreshToken != "") {
      context.go('/home');
    }
  }

  _showUpdateDialog() async {
    while ((await getUpdateAvailability()) == const UpdateAvailable()) {
      await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("update_title".tr()),
              content: Text("update_message".tr()),
              actions: [
                TextButton(
                  onPressed: () async {
                    if(Platform.isAndroid){
                      await launchUrl(Uri.parse("https://play.google.com/store/apps/details?id=com.malf.malf"));
                    }
                    if(Platform.isIOS){
                      await launchUrl(Uri.parse("https://apps.apple.com/kr/app/malf/id6469673658"));
                    }
                    context.pop();
                  },
                  child: const Text('confirm').tr(),
                ),
                TextButton(
                    onPressed: () {
                      context.pop();
                    },
                    child: const Text('cancel',
                        style: TextStyle(
                          color: Colors.grey,
                        )).tr())
              ],
            );
          });
    }
  }

  // Future<void> getUpdateAvailability() async {
  //   final updateInfo = await InAppUpdate.checkForUpdate();
  //   // await InAppUpdate.completeFlexibleUpdate();
  //   // await InAppUpdate.startFlexibleUpdate();
  //   await InAppUpdate.performImmediateUpdate();
  //   setState(() {
  //     _updateInfo = updateInfo;
  //   });
  // }

  Future<void> makeTermSheet(String kind) async {
    bool allAgree = false;
    bool termAgree = false;
    bool privacyAgree = false;
    await showModalBottomSheet(
        context: context,
        showDragHandle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
        ),
        builder: (context) {
          return StatefulBuilder(builder: (context, setstate) {
            return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, bottom: 16),
                    child: Text(
                      "agree_terms".tr(),
                      style: const TextStyle(
                        color: Color(0xFF292524),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: CheckboxListTile.adaptive(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        tileColor: Color.fromARGB(255, 239, 239, 239),
                        value: allAgree,
                        onChanged: (value) {
                          setstate(() {
                            allAgree = value ?? false;
                            termAgree = value ?? false;
                            privacyAgree = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("agree_all".tr())),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: CheckboxListTile.adaptive(
                        value: termAgree,
                        onChanged: (value) {
                          setstate(() {
                            termAgree = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("agree_terms".tr())),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: CheckboxListTile.adaptive(
                        value: privacyAgree,
                        onChanged: (value) {
                          setstate(() {
                            privacyAgree = value ?? false;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text("agree_policy".tr())),
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
                                fontSize: 10,
                              )).tr())
                    ],
                  ),
                  Expanded(child: Container()),
                  SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8, top: 8),
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (termAgree && privacyAgree)
                                    ? AppColors.primary
                                    : Colors.grey,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              onPressed: () {
                                if (termAgree && privacyAgree) {
                                  context.pop();
                                  GoRouter.of(context).push('/loginAuth/$kind');
                                }
                              },
                              child: Text(
                                "start".tr(),
                                style: const TextStyle(
                                  fontFamily: AppTextStyles.fontFamily,
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ).tr(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]);
          });
        });
  }

  @override
  Widget build(BuildContext context) {
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
                    child: ExtendedImage.asset(
                        "assets/logos/new_login_logo.png",
                        fit: BoxFit.contain)),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      if (Platform.isIOS)
                        Container(
                          height: 64,
                          width: 64,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  fit: BoxFit.fitHeight,
                                  image:
                                      AssetImage('assets/images/apple.png'))),
                          child: GestureDetector(
                            onTap: () async {
                              makeTermSheet("apple");
                            },
                          ),
                        ),
                      Container(
                        height: 64,
                        width: 64,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage('assets/images/kakao.png'))),
                        child: GestureDetector(
                          onTap: () {
                            makeTermSheet("kakao");
                          },
                        ),
                      ),
                      Container(
                        height: 64,
                        width: 64,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage('assets/images/line.png'))),
                        child: GestureDetector(
                          onTap: () {
                            makeTermSheet("line");
                          },
                        ),
                      ),
                      Container(
                        height: 64,
                        width: 64,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage('assets/images/google.png'))),
                        child: GestureDetector(
                          onTap: () {
                            makeTermSheet("google");
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                //email login button
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 5,
                  ),
                  child: Container(
                    height: 50,
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

                // Expanded(child: Container()),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: [
                //     Expanded(
                //       child: Text(
                //           "가입을 진행할 경우, 서비스 약관 및 개인정보 처리방침에 동의하는 것으로 간주됩니다.",
                //           textAlign: TextAlign.center,
                //           style: const TextStyle(
                //             fontFamily: AppTextStyles.fontFamily,
                //             color: Colors.white,
                //             fontSize: 10,
                //           )).tr(),
                //     )
                //   ],
                // ),
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
      ..setUserAgent("Mozilla/5.0 Chrome/119.0.0.0 Safari/537.36")
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel("getToken",
          onMessageReceived: (JavaScriptMessage message) async {
        logger.d("log : ${message.message}");
        final Map<String, dynamic> data = jsonDecode(message.message);
        logger.d(data);
        if (data['token']['refreshToken'] == null) {
          logger.e("로그인 실패");
          context.pop();
          return;
        }
        Token().setToken(
            data['token']['refreshToken'], data['token']['accessToken']);
        loadHome();
      })
      // ..addJavaScriptChannel(
      //   'Toaster',
      //   onMessageReceived: (JavaScriptMessage message) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text(message.message)),
      //     );
      //   },
      // )
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            debugPrint('Page finished loading: $url');

            if (url.startsWith(
                'https://malftravel.com/auth/${widget.kind}/callback')) {
              controller.runJavaScript(
                  "getToken.postMessage(document.body.outerText);");
              // Response response = await Dio().get(url);
              // logger.d(response.data);
              // await Token().setToken(response.data['token']['refreshToken'],
              //     response.data['token']['accessToken']);
              // loadHome();
              //destroy WebView
            }
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
          onNavigationRequest: (NavigationRequest request) {
            logger.i('allowing navigation to ${request.url}');
            if (request.url.startsWith(
                'https://malftravel.com/auth/${widget.kind}/callback')) {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  barrierColor: Colors.black,
                  builder: (BuildContext context) {
                    return LoadingAnimationWidget.inkDrop(
                      color: AppColors.primary,
                      size: 100,
                    );
                  });
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('$baseUrl/auth/${widget.kind}'));

    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    _controller = controller;
  }

  void loadHome() async {
    logger.d('accessToken : ${Token().accessToken}}');
    logger.d('refreshToken : ${Token().refreshToken}');
    logger.d('userUniqId : ${Token().userUniqId}');

    Response response;
    final dio = Dio(BaseOptions(
      headers: {'Authorization': Token().refreshToken},
      contentType: "multipart/form-data",
    ));
    final formData = FormData.fromMap({
      'user_type': 1,
      'nation': 410,
      'gender': 1,
      'nickname': RandomNames(context.locale.languageCode == "zh"
              ? Zone.china
              : context.locale.languageCode == "ja"
                  ? Zone.japan
                  : Zone.us)
          .name(),
      'birthday': "2021-10-10T10:10:10",
      'default_language': -1,
      "description": "first_profile_description".tr(),
      "able_language": "[]",
      "interest": "first_profile_interest".tr(),
    });

    while (await checkProfile()) {
      try {
        logger.d("가입되지 않은 유저");

        response = await dio.post("$baseUrl/user/profile", data: formData);

        logger.d(response.data);
      } catch (e) {
        logger.e(e);
      }
    }

    BlockSet().setInit();

    context
      ..pop()
      ..go('/home');
  }

  Future<bool> checkProfile() async {
    Response response =
        await Dio(BaseOptions(headers: {'Authorization': Token().refreshToken}))
            .get("${baseUrl}/user/profile/${Token().userUniqId}");
    return response.data['data'].toString() == "[]";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WebViewWidget(controller: _controller)),
      ),
    );
  }
}
