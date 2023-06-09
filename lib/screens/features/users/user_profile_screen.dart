import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/settings/settings_screen.dart';
import 'package:tiktok_clone/screens/features/users/view_models/users_view_model.dart';
import 'package:tiktok_clone/screens/features/users/widgets/avatar.dart';
import 'package:tiktok_clone/screens/features/users/widgets/follower_likes.dart';
import 'package:tiktok_clone/screens/features/users/widgets/persistent_tab_bar.dart';

class UserProfileScreen extends ConsumerStatefulWidget {
  final String username;
  final String tab;

  const UserProfileScreen({
    super.key,
    required this.username,
    required this.tab,
  });

  @override
  ConsumerState<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends ConsumerState<UserProfileScreen> {
  void _onGearPressed() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SettingsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ref.watch(userProvider).when(
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
            ),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
          data: (data) => Scaffold(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            body: SafeArea(
              child: DefaultTabController(
                initialIndex: widget.tab == "likes" ? 1 : 0,
                length: 2,
                child: LayoutBuilder(
                  builder: (context, constraints) => NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        SliverAppBar(
                          title: Text(data.name),
                          actions: [
                            IconButton(
                              onPressed: _onGearPressed,
                              icon: const FaIcon(
                                FontAwesomeIcons.gear,
                                size: Sizes.size20,
                              ),
                            ),
                          ],
                        ),
                        SliverToBoxAdapter(
                          child: width < Breakpoints.lg
                              ? Column(
                                  children: [
                                    Gaps.v20,
                                    Avatar(
                                      name: data.name,
                                      hasAvatar: data.hasAvatar,
                                      uid: data.uid,
                                    ),
                                    Gaps.v20,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          "@${data.name}",
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: Sizes.size18,
                                          ),
                                        ),
                                        Gaps.h5,
                                        FaIcon(
                                          FontAwesomeIcons.solidCircleCheck,
                                          size: Sizes.size16,
                                          color: Colors.blue.shade500,
                                        ),
                                      ],
                                    ),
                                    Gaps.v24,
                                    const FollowersLikes(
                                      following: '97',
                                      followers: '10M',
                                      likes: '194.3M',
                                    ),
                                    Gaps.v14,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 160,
                                          height: 50,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: Sizes.size12,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                Sizes.size4,
                                              ),
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Follow",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                        Gaps.h3,
                                        Container(
                                          width: 50,
                                          height: 50,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: Sizes.size12,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                Sizes.size4,
                                              ),
                                            ),
                                          ),
                                          child: const Center(
                                            child: FaIcon(
                                              FontAwesomeIcons.youtube,
                                            ),
                                          ),
                                        ),
                                        Gaps.h3,
                                        Container(
                                          width: 50,
                                          height: 50,
                                          padding: const EdgeInsets.symmetric(
                                            vertical: Sizes.size12,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.grey.shade300,
                                            ),
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(
                                                Sizes.size4,
                                              ),
                                            ),
                                          ),
                                          child: const Center(
                                            child: FaIcon(
                                              FontAwesomeIcons
                                                  .circleChevronDown,
                                              size: Sizes.size16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gaps.v14,
                                    const Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Sizes.size32,
                                      ),
                                      child: Text(
                                        "All highlights and where to watch live matches on FIFA+",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Gaps.v14,
                                    const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        FaIcon(
                                          FontAwesomeIcons.link,
                                          size: Sizes.size12,
                                        ),
                                        Gaps.h4,
                                        Text(
                                          "https://chat.openai.com/",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Gaps.v20,
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        const CircleAvatar(
                                          radius: 50,
                                          foregroundImage: NetworkImage(
                                              "https://lh3.googleusercontent.com/a/AGNmyxamUvm-3XN71fNXENMkFOcuBM1YTGv4RKiqqEd09g=s432-c-no"),
                                          child: Text("Carl"),
                                        ),
                                        Gaps.v20,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const Text(
                                              "@Carl",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: Sizes.size18,
                                              ),
                                            ),
                                            Gaps.h5,
                                            FaIcon(
                                              FontAwesomeIcons.solidCircleCheck,
                                              size: Sizes.size16,
                                              color: Colors.blue.shade500,
                                            ),
                                          ],
                                        ),
                                        Gaps.v20,
                                        const FollowersLikes(
                                          following: '97',
                                          followers: '10M',
                                          likes: '194.3M',
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: Sizes.size32,
                                          ),
                                          child: Text(
                                            "All highlights and where to watch live matches on FIFA+",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        Gaps.v20,
                                        const Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            FaIcon(
                                              FontAwesomeIcons.link,
                                              size: Sizes.size12,
                                            ),
                                            Gaps.h4,
                                            Text(
                                              "https://chat.openai.com/",
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gaps.v20,
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              width: 160,
                                              height: 50,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: Sizes.size12,
                                              ),
                                              decoration: BoxDecoration(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(
                                                    Sizes.size4,
                                                  ),
                                                ),
                                              ),
                                              child: const Center(
                                                child: Text(
                                                  "Follow",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ),
                                            Gaps.h3,
                                            Container(
                                              width: 50,
                                              height: 50,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: Sizes.size12,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(
                                                    Sizes.size4,
                                                  ),
                                                ),
                                              ),
                                              child: const Center(
                                                child: FaIcon(
                                                  FontAwesomeIcons.youtube,
                                                ),
                                              ),
                                            ),
                                            Gaps.h3,
                                            Container(
                                              width: 50,
                                              height: 50,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: Sizes.size12,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.grey.shade300,
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(
                                                    Sizes.size4,
                                                  ),
                                                ),
                                              ),
                                              child: const Center(
                                                child: FaIcon(
                                                  FontAwesomeIcons
                                                      .circleChevronDown,
                                                  size: Sizes.size16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                        ),
                        SliverPersistentHeader(
                          delegate: PersistentTabBar(),
                          pinned: true,
                        ),
                      ];
                    },
                    body: TabBarView(
                      children: [
                        GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          itemCount: 20,
                          padding: EdgeInsets.zero,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: width < Breakpoints.md ? 3 : 5,
                            crossAxisSpacing: Sizes.size2,
                            mainAxisSpacing: Sizes.size2,
                            childAspectRatio: 9 / 14,
                          ),
                          itemBuilder: (context, index) => Column(
                            children: [
                              Stack(
                                children: [
                                  AspectRatio(
                                    aspectRatio: 9 / 14,
                                    child: FadeInImage.assetNetwork(
                                      fit: BoxFit.cover,
                                      placeholder: "assets/photos/9.jpg",
                                      image:
                                          "https://picsum.photos/seed/picsum/900/1600",
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.play_arrow_outlined,
                                          size: Sizes.size24,
                                          color: Colors.grey.shade300,
                                        ),
                                        Gaps.h6,
                                        Text(
                                          "4.1M",
                                          style: TextStyle(
                                            color: Colors.grey.shade300,
                                            fontSize: Sizes.size12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Center(
                          child: Text("data"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
  }
}
