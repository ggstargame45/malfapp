import 'dart:convert';
import 'dart:io';

import 'package:app_version_update/app_version_update.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/features/home/home_screen.dart';
import 'package:malf/shared/network/base_url.dart';
import 'package:malf/shared/network/token.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String version = '';
  @override
  void initState() {
    super.initState();

    // InAppUpdateManager manager = InAppUpdateManager();
    // manager.checkForUpdate().then(
    //   (value) {
    //     if (value == null) return;
    //     if (value.updateAvailability ==
    //         UpdateAvailability.developerTriggeredUpdateInProgress) {
    //       ///If an in-app update is already running, resume the update.
    //       manager.startAnUpdate(type: AppUpdateType.immediate);

    //       ///message return null when run update success
    //     } else if (value.updateAvailability ==
    //         UpdateAvailability.updateAvailable) {
    //       ///Update available
    //       if (value.immediateAllowed) {
    //         debugPrint('Start an immediate update');
    //         manager.startAnUpdate(type: AppUpdateType.immediate);

    //         ///message return null when run update success
    //       } else if (value.flexibleAllowed) {
    //         debugPrint('Start an flexible update');
    //         manager.startAnUpdate(type: AppUpdateType.flexible);

    //         ///message return null when run update success
    //       } else {
    //         debugPrint(
    //             'Update available. Immediate & Flexible Update Flow not allow');
    //       }
    //     }
    //   },
    // );

    // AppUpdateInfo? appUpdateInfo = await ;
    //   appUpdateInfo!.availableVersionCode;
    // PackageManager.getPackageInfo().then((value) {
    //   UpgradeVersion.getiOSStoreVersion(
    //     packageInfo: value,
    //     // regionCode:
    //     //     WidgetsBinding.instance.platformDispatcher.locale.countryCode
    //   ).then(
    //     (value) {
    //       setState(() {
    //         version = value.appStoreLink;
    //       });
    //     },
    //   );
    //   // setState(() {
    //   //   version = value.version;
    //   // });
    // });
    //"https://apps.apple.com/kr/app/malf/id6469673658"
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('setting'.tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                // logger.d(await _getAndroidStoreVersion(await PackageInfo.fromPlatform()));
                // logger.d(await _getiOSStoreVersion(await PackageInfo.fromPlatform()));
                final appleId =
                    '6469673658'; // If this value is null, its packagename will be considered
                final playStoreId =
                    'com.malf.malf'; // If this value is null, its packagename will be considered
                // final country =
                //     'br'; // If this value is null 'us' will be the default value
                
                await AppVersionUpdate.checkForUpdates(
                  appleId: appleId,
                  playStoreId: playStoreId,
                ).then((data) async {
                  logger.d(data.storeUrl);
                  logger.d(data.storeVersion);
                  
                });
              },
              color: Colors.black,
              icon: const Icon(Icons.close_outlined)),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('language_setting'.tr()),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LanguageSettingsScreen(),
                ),
              );
            },
          ),
          ListTile(
            title: Text("block_list".tr()),
            onTap: () {
              context.push('/blockList');
            },
          ),
          ListTile(
            title: Text("privacy_policy".tr()),
            onTap: () {
              launchUrl(
                Uri.parse(
                    'https://marsh-swordtail-f9e.notion.site/MALF-4c701b51a0c34c71b2047962374036d2?pvs=4'),
              );
            },
          ),
          ListTile(
            title: Text("service_terms".tr()),
            onTap: () {
              launchUrl(
                Uri.parse(
                    'https://marsh-swordtail-f9e.notion.site/MALF-6807b32f4ad2497c8ec544d82a156435?pvs=4'),
              );
            },
          ),
          ListTile(
            title: Text("contact_with_us".tr()),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                          title: Text("contact_with_us".tr()),
                          content: Text(
                              "${"contact_with_us_message".tr()}\nmalfcorp@gmail.com"),
                          actions: [
                            TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('cancel'.tr())),
                          ]));
            },
          ),
          //app version
          ListTile(
            title: Text("app_version".tr()),
            subtitle: Text(version),
            onTap: () async {
              // try {
              //   final image =
              //       await ImagePicker().pickImage(source: ImageSource.gallery);

              //   http.MultipartRequest request =
              //       http.MultipartRequest('POST', Uri.parse("$baseUrl/user/student-id"));

              //   request.files.add(await http.MultipartFile.fromPath(
              //       'image', image!.path));

              //   String token = Token().refreshToken;

              //   request.headers['Authorization'] = token;
              //   request.headers['Content-Type'] = 'multipart/form-data;';

              //   final response = await request.send();
              //   if (response.statusCode == 200) {
              //     logger.d('요청이 성공적으로 처리되었습니다.');
              //   } else {
              //     logger.e('요청이 실패하였습니다. 상태 코드: ${response.statusCode}');
              //     logger.e("이유 : ${response.reasonPhrase}");
              //     logger.e("요청 : ${response.request}");
              //   }
              // } on Exception catch (e) {
              //   logger.e(e);
              // }
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    child: Text("delete_account".tr(),
                        style: const TextStyle(color: Colors.red)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (contexnt) => AlertDialog(
                          title: Text("delete_account_title".tr()),
                          content: Text("delete_account_message".tr()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(contexnt).pop(),
                              child: Text('cancel'.tr()),
                            ),
                            TextButton(
                              onPressed: () async {
                                Dio dio = Dio(BaseOptions(
                                    baseUrl: baseUrl,
                                    headers: {
                                      "Authorization": Token().refreshToken
                                    }));

                                try {
                                  final response =
                                      await dio.delete('/user/profile');
                                  if (response.statusCode == 200) {
                                    Token().deleteToken();
                                    contexnt.pop();
                                    context.go('/login');
                                  } else {
                                    contexnt.pop();
                                  }
                                } on Exception catch (e) {
                                  // TODO
                                  contexnt.pop();
                                }
                              },
                              child: Text('confirm'.tr()),
                            )
                          ],
                        ),
                      );
                    }),
                TextButton(
                    child: Text('logout'.tr()),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (contexnt) => AlertDialog(
                          title: Text("logout_title".tr()),
                          content: Text("logout_title".tr()),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: Text('cancel'.tr()),
                            ),
                            TextButton(
                              onPressed: () {
                                Token().deleteToken();

                                context
                                  ..pop()
                                  ..go('/login');
                              },
                              child: Text('confirm'.tr()),
                            )
                          ],
                        ),
                      );
                    })
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class LanguageSettingsScreen extends StatefulWidget {
  const LanguageSettingsScreen({super.key});

  @override
  State<LanguageSettingsScreen> createState() => _LanguageSettingsScreenState();
}

class _LanguageSettingsScreenState extends State<LanguageSettingsScreen> {
  bool _isEnglish = true;
  bool _isKorean = false;
  bool _isJapanese = false;
  bool _isChinese = false;

  @override
  Widget build(BuildContext context) {
    switch (context.locale.languageCode) {
      case 'en':
        _isEnglish = true;
        _isChinese = false;
        _isJapanese = false;
        _isKorean = false;
        break;
      case 'ko':
        _isEnglish = false;
        _isChinese = false;
        _isJapanese = false;
        _isKorean = true;
        break;
      case 'ja':
        _isEnglish = false;
        _isChinese = false;
        _isJapanese = true;
        _isKorean = false;
        break;
      case 'zh':
        _isEnglish = false;
        _isChinese = true;
        _isJapanese = false;
        _isKorean = false;
        break;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("language_setting".tr()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                if (mounted) {
                  context.pop();
                }
              },
              color: Colors.black,
              icon: const Icon(Icons.close_outlined)),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                context.setLocale(const Locale('en'));
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("restart_apply".tr())));
            },
            title: Text('english'.tr()),
            trailing: _isEnglish ? const Icon(Icons.check) : null,
          ),
          ListTile(
            title: Text('korean'.tr()),
            onTap: () {
              setState(() {
                context.setLocale(const Locale('ko'));
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("restart_apply".tr())));
            },
            trailing: _isKorean ? const Icon(Icons.check) : null,
          ),
          ListTile(
            title: Text('chinese'.tr()),
            onTap: () {
              setState(() {
                context.setLocale(const Locale('zh'));
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("restart_apply".tr())));
            },
            trailing: _isChinese ? const Icon(Icons.check) : null,
          ),
          ListTile(
            title: Text('japanese'.tr()),
            onTap: () {
              setState(() {
                context.setLocale(const Locale('ja'));
              });
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("restart_apply".tr())));
            },
            trailing: _isJapanese ? const Icon(Icons.check) : null,
          ),
        ],
      ),
    );
  }
}
