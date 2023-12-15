import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:malf/features/community/community_page.dart';
import 'package:malf/features/detail/attend_list_screen.dart';
import 'package:malf/features/detail/detail_edit_screen.dart';
import 'package:malf/features/detail/detail_model.dart';
import 'package:malf/features/home/home_page.dart';
import 'package:malf/features/login/email_login_screen.dart';
import 'package:malf/features/login/login_screen.dart';
import 'package:malf/features/home/home_screen.dart';
import 'package:malf/features/detail/detail_screen.dart';
import 'package:malf/features/profile/profile_edit_screen.dart';
import 'package:malf/features/profile/profile_other_screen.dart';
import 'package:malf/features/profile/profile_page.dart';
import 'package:malf/features/report/report_screen.dart';
import 'package:malf/features/review/review_list_screen.dart';
import 'package:malf/features/review/review_screen.dart';
import 'package:malf/features/schoolauth/school_auth_screen.dart';
import 'package:malf/features/settings/block_list_screen.dart';
import 'package:malf/features/settings/settings_screen.dart';
import 'package:malf/features/write/write_screen.dart';
import 'package:malf/features/notification/notification_page.dart';
import 'package:malf/features/category/category_screen.dart';
import 'package:malf/features/chat/chat_list/chat_page.dart';
import 'package:malf/features/chat/chat_room/chat_room_screen.dart';
import 'package:malf/shared/widgets/image_view_widget.dart';

import 'package:malf/shared/widgets/meeting_list_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'sectionANav');

GoRouter appRouter = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/login',
  routes: [
    StatefulShellRoute.indexedStack(
        //parentNavigatorKey: sectionANavigatorKey,
        builder: (context, state, navigationShell) {
          return HomeScreen(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          StatefulShellBranch(
            // navigatorKey: sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: '/home',
                builder: (BuildContext context, GoRouterState state) =>
                    const CommunityPage(),
                routes: <RouteBase>[],
              ),
            ],
          ),
          StatefulShellBranch(routes: <RouteBase>[
            GoRoute(
              // The screen to display as the root in the first tab of the
              // bottom navigation bar.
              path: '/community',
              builder: (BuildContext context, GoRouterState state) =>
                  const HomePage(),
              routes: <RouteBase>[],
            ),
          ]),
          StatefulShellBranch(
            //navigatorKey: sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: '/chat',
                builder: (BuildContext context, GoRouterState state) =>
                    ChatPage(),
                routes: <RouteBase>[],
              ),
            ],
          ),
          StatefulShellBranch(
            // navigatorKey: sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: '/notification',
                builder: (BuildContext context, GoRouterState state) =>
                    NotificationPage(),
                routes: <RouteBase>[],
              ),
            ],
          ),
          StatefulShellBranch(
            // navigatorKey: sectionANavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                // The screen to display as the root in the first tab of the
                // bottom navigation bar.
                path: '/profile',
                builder: (BuildContext context, GoRouterState state) =>
                    ProfilePage(),
                routes: <RouteBase>[],
              ),
            ],
          ),
        ]),
    //카테고리
    GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: "/category/:categoryNum",
        builder: (context, state) => CategoryScreen(
              categoryId: int.parse(state.pathParameters['categoryNum']!),
            )),
    //세부 글
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/detail/:id',
      builder: (context, state) => DetailScreen(
        postId: int.parse(state.pathParameters['id']!),
        //id: state.params['id']!
      ),
    ),
    //글쓰기
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/write',
      builder: (context, state) => WriteScreen(),
    ),
    //글수정
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/edit',
      builder: (context, state) => DetailEditScreen(
        detailData: state.extra as DetailData,
      ),
    ),
    //참여자 목록
    GoRoute(
        path: '/attendList/:id/:isHost',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => AttendListScreen(
              postId: int.parse(state.pathParameters['id']!),
              isHost: state.pathParameters['isHost']! == '1',
            )),
    //로그인
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    //학생증 인증
    GoRoute(
        path: "/schoolAuth",
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => SchoolAuthScreen()),
    //로그인 인증 웹뷰
    GoRoute(
      parentNavigatorKey: rootNavigatorKey,
      path: '/loginAuth/:kind',
      builder: (context, state) => AuthScreen(
        kind: state.pathParameters['kind']!,
      ),
    ),
    // 다른 프로필
    GoRoute(
        path: '/profileOther/:id',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ProfileOtherScreen(
              userUniqId: state.pathParameters['id']!,
            )),

    //TODO: 후기 리스트
    GoRoute(
        path: '/reviewList/:postId',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          return ReviewListScreen(
            postId: state.pathParameters['postId']??"0",
          );
        }),

    //TODO: 후기
    GoRoute(
        path: '/reviewDetail/:userId',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          return ReviewDetailScreen(
            userUniqId: state.pathParameters['userId']!,
          );
        }),

    // 채팅방
    GoRoute(
        parentNavigatorKey: rootNavigatorKey,
        path: '/chatRoom/:id',
        builder: (context, state) => ChatRoomScreen(
              roomId: int.parse(state.pathParameters['id']!),
            )),

    //TODO: 배너/알림글

    // 프로필 수정
    GoRoute(
        path: '/profileEdit',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => ProfileEditScreen(
              profileData: state.extra,
            )),

    //신고하기
    GoRoute(
        path: '/report',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          final datas = state.extra as Map<String, String?>;
          return ReportScreen(
            reportType: datas['reportType']!,
            id: datas['id']!,
            title: datas['title']!,
          );
        }),

    // 설정창
    GoRoute(
        path: '/settings',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => SettingsScreen(),
        routes: <GoRoute>[
          //TODO: 언어설정
          //GoRoute(path: '/language', parentNavigatorKey: rootNavigatorKey),

          //TODO: 약관
          //GoRoute(path: '/terms', parentNavigatorKey: rootNavigatorKey),

          //TODO: 개인정보처리방침
          //        GoRoute(path: '/privacy', parentNavigatorKey: rootNavigatorKey),
        ]),
    //차단목록
    GoRoute(
      path: '/blockList',
      parentNavigatorKey: rootNavigatorKey,
      builder: (context, state) => BlockListScreen(),
    ),

    //이미지 뷰어
    GoRoute(path: '/imageViewer', parentNavigatorKey: rootNavigatorKey,
    builder: (context, state) =>
      ImageViewerScreen(imageUrlList: state.extra as List<String>),
    ),

    //TODO: 문의하기

    //이메일 로그인
    GoRoute(
        path: '/emailLogin',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => EmailLoginScreen()),
    //TODO: 모임 글 목록
    GoRoute(
        path: '/meetingList/:kind/:id',
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) {
          return MeetingListScreen(
            kind: state.pathParameters['kind']!,
            kindId: int.parse(state.pathParameters['id'] ?? "1"),
            extraData: state.extra,
          );
        }),
  ],
);
