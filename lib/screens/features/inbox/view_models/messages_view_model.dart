import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/screens/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/screens/features/inbox/models/message_model.dart';
import 'package:tiktok_clone/screens/features/inbox/repos/messages_repo.dart';

class MessagesViewModel extends AsyncNotifier<void> {
  late final MessagesRepository _repository;

  @override
  FutureOr build() {
    _repository = ref.read(messagesRepository);
  }

  Future<void> sendMessage(String text) async {
    final user = ref.read(authRepo).user;
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final message = MessageModel(
        text: text,
        userId: user!.uid,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      _repository.sendMessage(message);
    });
  }
}

final messagesProvider = AsyncNotifierProvider<MessagesViewModel, void>(
  () => MessagesViewModel(),
);

final chatProvider = StreamProvider.autoDispose<List<MessageModel>>((ref) {
  final db = FirebaseFirestore.instance;

  return db
      .collection("chat_rooms")
      .doc("7blvZ0kefSHEPWHgUS3u")
      .collection("texts")
      .orderBy("createdAt")
      .snapshots()
      .map(
        (event) => event.docs
            .map(
              (doc) => MessageModel.fromJson(
                doc.data(),
              ),
            )
            .toList()
            .reversed
            .toList(),
      );
});
