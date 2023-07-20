import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/screens/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/screens/features/inbox/chats_screens.dart';
import 'package:tiktok_clone/screens/features/videos/views/widgets/video_recording_screen.dart';

class NotificationsProvider extends FamilyAsyncNotifier<void, BuildContext> {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> updateToken(String token) async {
    final user = ref.read(authRepo).user;
    await _db.collection("users").doc(user!.uid).update({"token": token});
  }

  Future<void> initListners(BuildContext context) async {
    final permission = await _messaging.requestPermission();
    if (permission.authorizationStatus == AuthorizationStatus.denied) {
      return;
    }
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("I just got a message and I'm in the foreground");
      print(event.notification?.title);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((notification) {
      context.pushNamed(ChatsScreen.routeName);
    });
    final notification = await _messaging.getInitialMessage();
    if (notification != null) {
      context.pushNamed(VideoRecordingScreen.routeName);
    }
  }

  @override
  FutureOr build(BuildContext context) async {
    final user = ref.read(authRepo).user;
    if (user == null) {
      await _messaging.deleteToken();
      await _messaging.unsubscribeFromTopic('topic_name');
      return;
    }

    final token = await _messaging.getToken();
    if (token == null) return;
    await updateToken(token);
    await initListners(context);
    _messaging.onTokenRefresh.listen((newToken) async {
      await updateToken(newToken);
    });
  }
}

final notificationProvider = AsyncNotifierProvider.family(
  () => NotificationsProvider(),
);
