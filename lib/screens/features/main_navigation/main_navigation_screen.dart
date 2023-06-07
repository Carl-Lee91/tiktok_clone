import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/discover/discover_screen.dart';
import 'package:tiktok_clone/screens/features/main_navigation/widgets/nav_tab.dart';
import 'package:tiktok_clone/screens/features/main_navigation/widgets/post_video_btn.dart';
import 'package:tiktok_clone/screens/features/users/user_profile_screen.dart';
import 'package:tiktok_clone/screens/features/videos/inbox/inbox_screen.dart';
import 'package:tiktok_clone/screens/features/videos/video_timeline_screen.dart';
import 'package:tiktok_clone/utils.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 1;
  bool _opacity = false;
  double _scale = 1.0;

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onPostVideoBtnTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text(
              "Record video",
            ),
          ),
        ),
        fullscreenDialog: true,
      ),
    );
  }

  void _onPostVideoBtnTapDown(TapDownDetails details) {
    setState(() {
      _opacity = !_opacity;
      _scale = 1.1;
    });
  }

  void _onPostVideoBtnTapUp(TapUpDetails details) {
    setState(() {
      _opacity = !_opacity;
      _scale = 0.9;
    });
  }

  void _onPostVideoBtnTapCancel() {
    setState(() {
      _opacity = !_opacity;
      _scale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor:
          _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
      body: Stack(
        children: [
          Offstage(
            //안에 있는 child를 숨기는것
            offstage: _selectedIndex != 0,
            child: const VideoTimelineScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 1,
            child: const DiscoverScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 3,
            child: const InboxScreen(),
          ),
          Offstage(
            offstage: _selectedIndex != 4,
            child: const UserProfileScreen(),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: _selectedIndex == 0 || isDark ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.size12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NavTab(
                icon: FontAwesomeIcons.house,
                selectedIcon: FontAwesomeIcons.house,
                isSelected: _selectedIndex == 0,
                text: "Home",
                onTap: () => _onTap(0),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                icon: FontAwesomeIcons.compass,
                selectedIcon: FontAwesomeIcons.solidCompass,
                isSelected: _selectedIndex == 1,
                text: "Discover",
                onTap: () => _onTap(1),
                selectedIndex: _selectedIndex,
              ),
              Gaps.h24,
              GestureDetector(
                onTapDown: _onPostVideoBtnTapDown,
                onTapUp: _onPostVideoBtnTapUp,
                onTapCancel: _onPostVideoBtnTapCancel,
                onTap: _onPostVideoBtnTap,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  child: AnimatedOpacity(
                    opacity: _opacity ? 1 : 0.5,
                    duration: const Duration(milliseconds: 100),
                    child: PostVideoBtn(
                      inverted: _selectedIndex != 0,
                    ),
                  ),
                ),
              ),
              Gaps.h24,
              NavTab(
                icon: FontAwesomeIcons.message,
                selectedIcon: FontAwesomeIcons.solidMessage,
                isSelected: _selectedIndex == 3,
                text: "Inbox",
                onTap: () => _onTap(3),
                selectedIndex: _selectedIndex,
              ),
              NavTab(
                icon: FontAwesomeIcons.user,
                selectedIcon: FontAwesomeIcons.solidUser,
                isSelected: _selectedIndex == 4,
                text: "Profile",
                onTap: () => _onTap(4),
                selectedIndex: _selectedIndex,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
