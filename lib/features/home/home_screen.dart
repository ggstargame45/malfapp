import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:malf/features/chat/chat_list/chat_page_controller.dart';
import 'package:malf/shared/theme/app_colors.dart';

final logger = Logger();

const String notificationIc =
    "<svg xmlns=\"http://www.w3.org/2000/svg\" height=\"24\" viewBox=\"0 -960 960 960\" width=\"24\"><path d=\"M160-200v-80h80v-280q0-83 50-147.5T420-792v-28q0-25 17.5-42.5T480-880q25 0 42.5 17.5T540-820v28q80 20 130 84.5T720-560v280h80v80H160Zm320-300Zm0 420q-33 0-56.5-23.5T400-160h160q0 33-23.5 56.5T480-80ZM320-280h320v-280q0-66-47-113t-113-47q-66 0-113 47t-47 113v280Z\"/></svg>";

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  static const String routeName = '/home';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: widget.navigationShell,
        bottomNavigationBar: NavigationBar(
          backgroundColor: Colors.white,
          // selectedItemColor: AppColors.primary,
          // unselectedItemColor: Colors.grey
          destinations: [
            NavigationDestination(
              selectedIcon:
                  const Icon(Icons.home, color: AppColors.primary, size: 24),
              icon: const Icon(Icons.home, color: Colors.grey, size: 24),
              label: 'home'.tr(),
            ),
            NavigationDestination(
                selectedIcon:
                    const Icon(Icons.chat, color: AppColors.primary, size: 24),
                icon: const Icon(Icons.chat, color: Colors.grey, size: 24),
                label: 'chat'.tr()),
            //TODO : 알림
            NavigationDestination(
                selectedIcon: SvgPicture.string(
                  notificationIc,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primary, BlendMode.srcIn),
                  height: 24,
                  width: 24,
                ),
                // const Icon(Icons.notifications,
                //     color: AppColors.primary, size: 24),
                icon: SvgPicture.string(
                  notificationIc,
                  colorFilter:
                      const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                  height: 24,
                  width: 24,
                ),
                // const Icon(Icons.notifications, color: Colors.grey, size: 24),
                label: 'notification'.tr()),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.notifications), label: '알림'),
            NavigationDestination(
                selectedIcon: const Icon(Icons.person,
                    color: AppColors.primary, size: 24),
                icon: const Icon(Icons.person, color: Colors.grey, size: 24),
                label: 'profile'.tr()),
          ],
          selectedIndex: widget.navigationShell.currentIndex,
          onDestinationSelected: (int index) {
            _onTap(context, index);
          },
        ));
  }

  void _onTap(BuildContext context, int index) {
    logger.i('Navigating to tab $index');
    // When navigating to a new branch, it's recommended to use the goBranch
    // method, as doing so makes sure the last navigation state of the
    // Navigator for the branch is restored.
    if (index == 1) {
      pagingChatController.refresh();
    }
    widget.navigationShell.goBranch(index,
        // A common pattern when using bottom navigation bars is to support
        // navigating to the initial location when tapping the item that is
        // already active. This example demonstrates how to support this behavior,
        // using the initialLocation parameter of goBranch.
        initialLocation: widget.navigationShell.currentIndex == index);
  }
}
