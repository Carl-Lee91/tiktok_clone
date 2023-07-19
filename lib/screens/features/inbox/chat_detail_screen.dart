import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/authentication/repos/authentication_repo.dart';
import 'package:tiktok_clone/screens/features/inbox/view_models/messages_view_model.dart';

class ChatDetailScreen extends ConsumerStatefulWidget {
  static const String routeName = "chatDetail";
  static const String routeURL = ":chatId";

  final String chatId;

  const ChatDetailScreen({
    super.key,
    required this.chatId,
  });

  @override
  ConsumerState<ChatDetailScreen> createState() => ChatDetailScreenState();
}

class ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isWriting = false;

  void _onSubmitWriting() {
    final text = _textEditingController.text;
    if (text == "") {
      return;
    }
    ref.read(messagesProvider.notifier).sendMessage(text);
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
    _textEditingController.clear();
  }

  void _onStopWriting() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(messagesProvider).isLoading;
    return GestureDetector(
      onTap: _onStopWriting,
      child: Scaffold(
        appBar: AppBar(
          title: ListTile(
            contentPadding: EdgeInsets.zero,
            horizontalTitleGap: Sizes.size8,
            leading: Stack(
              alignment: AlignmentDirectional.bottomEnd,
              children: [
                const CircleAvatar(
                  radius: Sizes.size24,
                  foregroundImage: NetworkImage(
                      "https://lh3.googleusercontent.com/a/AGNmyxamUvm-3XN71fNXENMkFOcuBM1YTGv4RKiqqEd09g=s288-c-no"),
                  child: Text("Carl"),
                ),
                SizedBox(
                  height: Sizes.size16,
                  child: Container(
                    width: Sizes.size16,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Container(
                        width: Sizes.size12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: Text(
              "Carl(${widget.chatId})",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text("Active now"),
            trailing: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(
                  FontAwesomeIcons.flag,
                  color: Colors.black,
                  size: Sizes.size20,
                ),
                Gaps.h32,
                FaIcon(
                  FontAwesomeIcons.ellipsis,
                  color: Colors.black,
                  size: Sizes.size20,
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            ref.watch(chatProvider).when(
                  data: (data) {
                    return ListView.separated(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.size96,
                        horizontal: Sizes.size14,
                      ),
                      itemBuilder: (context, index) {
                        final message = data[index];
                        final inMine =
                            message.userId == ref.watch(authRepo).user!.uid;
                        return Row(
                          mainAxisAlignment: inMine
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(
                                Sizes.size14,
                              ),
                              decoration: BoxDecoration(
                                color: inMine
                                    ? Colors.blue
                                    : Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.only(
                                  topLeft: const Radius.circular(
                                    Sizes.size20,
                                  ),
                                  topRight: const Radius.circular(
                                    Sizes.size20,
                                  ),
                                  bottomLeft: Radius.circular(
                                      inMine ? Sizes.size20 : Sizes.size5),
                                  bottomRight: Radius.circular(
                                      !inMine ? Sizes.size20 : Sizes.size5),
                                ),
                              ),
                              child: Text(
                                message.text,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: Sizes.size16),
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (context, index) => Gaps.v10,
                      itemCount: data.length,
                    );
                  },
                  error: (error, stackTrace) => Center(
                    child: Text(
                      error.toString(),
                    ),
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: BottomAppBar(
                color: Colors.grey.shade50,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: Sizes.size12,
                    horizontal: Sizes.size18,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(
                                Sizes.size20,
                              ),
                              topRight: Radius.circular(
                                Sizes.size20,
                              ),
                              bottomLeft: Radius.circular(Sizes.size20),
                            ),
                          ),
                          height: Sizes.size44,
                          child: TextField(
                            controller: _textEditingController,
                            onTap: _onStartWriting,
                            textInputAction: TextInputAction.newline,
                            decoration: InputDecoration(
                              hintText: "Send a message...",
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: Sizes.size16,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(
                                  Sizes.size12,
                                ),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon: const Padding(
                                padding: EdgeInsets.only(
                                  right: Sizes.size10,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FaIcon(
                                      FontAwesomeIcons.faceSmile,
                                    ),
                                  ],
                                ),
                              ),
                              suffixIconColor: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Gaps.h8,
                      GestureDetector(
                        onTap: isLoading ? null : _onSubmitWriting,
                        child: Container(
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.shade400,
                          ),
                          child: Center(
                            child: FaIcon(
                              isLoading
                                  ? FontAwesomeIcons.hourglass
                                  : FontAwesomeIcons.paperPlane,
                              color: Colors.white,
                              size: Sizes.size18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
