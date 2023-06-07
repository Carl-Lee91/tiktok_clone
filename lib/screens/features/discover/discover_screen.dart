import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/breakpoints.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

final tabs = [
  "Top",
  "Users",
  "Videos",
  "Sounds",
  "LIVE",
  "Shopping",
  "Brands",
];

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({super.key});

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  final TextEditingController _textEditingController =
      TextEditingController(text: "Initial Text");

  bool _isWriting = false;

  void _onSearchChanged(String value) {
    print("Searching for $value");
  }

  void _onSearchSubmitted(String value) {
    print("Submitted $value");
  }

  void _onStartWriting() {
    setState(() {
      _isWriting = true;
    });
  }

  void _deleteWriting() {
    _textEditingController.clear();
    FocusScope.of(context).unfocus();
    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return DefaultTabController(
      length: tabs.length,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            elevation: 1,
            title: Container(
              constraints: const BoxConstraints(
                maxWidth: Breakpoints.sm,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const FaIcon(FontAwesomeIcons.chevronLeft),
                  Gaps.h20,
                  Expanded(
                    child: SizedBox(
                      height: Sizes.size40,
                      child: TextField(
                        onTap: _onStartWriting,
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          prefixIcon: const Padding(
                            padding: EdgeInsets.all(
                              Sizes.size12,
                            ),
                            child: FaIcon(
                              FontAwesomeIcons.magnifyingGlass,
                              size: Sizes.size16,
                            ),
                          ),
                          prefixIconConstraints: const BoxConstraints(
                            minWidth: 0,
                            minHeight: 0,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              Sizes.size10,
                            ),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: Sizes.size10,
                          ),
                          suffixIcon: _isWriting
                              ? Padding(
                                  padding: const EdgeInsets.all(
                                    Sizes.size8,
                                  ),
                                  child: GestureDetector(
                                    onTap: _deleteWriting,
                                    child: const FaIcon(
                                      FontAwesomeIcons.circleXmark,
                                      size: Sizes.size16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                )
                              : null,
                          suffixIconConstraints: const BoxConstraints(
                            minWidth: 0,
                            minHeight: 0,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gaps.h20,
                  const FaIcon(FontAwesomeIcons.sliders),
                ],
              ),
            ),
            bottom: TabBar(
              onTap: (index) {
                FocusScope.of(context).unfocus();
              },
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.size16,
              ),
              isScrollable: true,
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: Sizes.size16,
              ),
              indicatorColor: Theme.of(context).tabBarTheme.indicatorColor,
              splashFactory: NoSplash.splashFactory,
              tabs: [
                for (var tab in tabs)
                  Tab(
                    text: tab,
                  ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              GridView.builder(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: const EdgeInsets.all(Sizes.size6),
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: width > Breakpoints.lg ? 5 : 2,
                  crossAxisSpacing: Sizes.size10,
                  mainAxisSpacing: Sizes.size10,
                  childAspectRatio: 9 / 20,
                ),
                itemBuilder: (context, index) => LayoutBuilder(
                  builder: (context, constraints) => Column(
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            Sizes.size4,
                          ),
                        ),
                        child: AspectRatio(
                          aspectRatio: 9 / 16,
                          child: FadeInImage.assetNetwork(
                            fit: BoxFit.cover,
                            placeholder: "assets/photos/9.jpg",
                            image: "https://picsum.photos/seed/picsum/900/1600",
                          ),
                        ),
                      ),
                      Gaps.v10,
                      const Text(
                        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
                        style: TextStyle(
                          fontSize: Sizes.size16 + Sizes.size2,
                          fontWeight: FontWeight.bold,
                          height: 1.1,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Gaps.v8,
                      if (constraints.maxWidth < 200 ||
                          constraints.maxWidth > 250)
                        DefaultTextStyle(
                          style: TextStyle(
                            color: isDarkMode(context)
                                ? Colors.grey.shade300
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                          ),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 12,
                                backgroundImage: NetworkImage(
                                  "https://lh3.googleusercontent.com/ogw/AOLn63FTpxIuMZYdo12Z1_Gnoxp1HVDglPB22d7bZCYA4A=s64-c-mo",
                                ),
                              ),
                              Gaps.h4,
                              const Expanded(
                                child: Text(
                                  "My avatar is going to be very long",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Gaps.h4,
                              FaIcon(
                                FontAwesomeIcons.heart,
                                size: Sizes.size16,
                                color: Colors.grey.shade600,
                              ),
                              Gaps.h2,
                              const Text(
                                "2.5M",
                              ),
                            ],
                          ),
                        )
                    ],
                  ),
                ),
              ),
              for (var tab in tabs.skip(1))
                Center(
                  child: Text(
                    tab,
                    style: const TextStyle(
                      fontSize: 28,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
