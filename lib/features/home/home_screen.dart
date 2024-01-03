import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:malf/features/chat/chat_list/chat_page_controller.dart';
import 'package:malf/shared/theme/app_colors.dart';

final logger = Logger();

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
    Icons.public;
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
                  const Icon(Icons.public_rounded, color: AppColors.primary, size: 24),
              icon: const Icon(Icons.public_rounded, color: Colors.grey, size: 24),
              label: 'meeting'.tr(),
            ),
            NavigationDestination(
                selectedIcon:
                    const Icon(Icons.chat, color: AppColors.primary, size: 24),
                icon: const Icon(Icons.chat, color: Colors.grey, size: 24),
                label: 'chat'.tr()),
            //TODO : 알림
            // NavigationDestination(
            //     selectedIcon: const Icon(Icons.notifications,
            //         color: AppColors.primary, size: 24),
            //     icon: const Icon(Icons.notifications,
            //         color: Colors.grey, size: 24),
            //     label: 'notification'.tr()),
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
