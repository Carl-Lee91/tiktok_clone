import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widget/main_navigation/main_navigation_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/login_screen.dart';
import 'package:tiktok_clone/screens/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/screens/features/authentication/sign_up_screen.dart';
import 'package:tiktok_clone/screens/features/onboarding/interests_screen.dart';
import 'package:tiktok_clone/screens/features/inbox/activity_screen.dart';
import 'package:tiktok_clone/screens/features/inbox/chat_detail_screen.dart';
import 'package:tiktok_clone/screens/features/inbox/chats_screens.dart';
import 'package:tiktok_clone/screens/features/videos/views/widgets/video_recording_screen.dart';

final routerProvider = Provider((ref) {
  return GoRouter(
    initialLocation: "/home",
    redirect: (context, state) {
      final isLoggedIn = ref.read(authRepo).isLoggedIn;
      if (!isLoggedIn) {
        if (state.subloc != SignUpScreen.routeURL &&
            state.subloc != LoginScreen.routeURL) {
          return SignUpScreen.routeURL;
        }
      }
      return null;
    },
    routes: [
      GoRoute(
        path: SignUpScreen.routeURL,
        name: SignUpScreen.routeName,
        builder: (context, state) => const SignUpScreen(),
      ),
      GoRoute(
        path: LoginScreen.routeURL,
        name: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: InterestScreen.routeURL,
        name: InterestScreen.routeName,
        builder: (context, state) => const InterestScreen(),
      ),
      GoRoute(
        path: "/:tab(home|discover|inbox|profile)",
        name: MainNavigationScreen.routeName,
        builder: (context, state) {
          final tab = state.params["tab"]!;
          return MainNavigationScreen(tab: tab);
        },
      ),
      GoRoute(
        path: ActivityScreen.routeURL,
        name: ActivityScreen.routeName,
        builder: (context, state) => const ActivityScreen(),
      ),
      GoRoute(
        path: ChatsScreen.routeURL,
        name: ChatsScreen.routeName,
        builder: (context, state) => const ChatsScreen(),
        routes: [
          GoRoute(
            path: ChatDetailScreen.routeURL,
            name: ChatDetailScreen.routeName,
            builder: (context, state) {
              final chatId = state.params["chatId"]!;
              return ChatDetailScreen(
                chatId: chatId,
              );
            },
          ),
        ],
      ),
      GoRoute(
        path: VideoRecordingScreen.routeURL,
        name: VideoRecordingScreen.routeName,
        pageBuilder: (context, state) => CustomTransitionPage(
          transitionDuration: const Duration(milliseconds: 200),
          child: const VideoRecordingScreen(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final position = Tween(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(animation);
            return SlideTransition(
              position: position,
              child: child,
            );
          },
        ),
      ),
    ],
  );
});
