import 'package:flutter/material.dart';
import 'package:tiktok_clone/screens/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final PageController _pageController = PageController();

  final _scrollDuration = const Duration(milliseconds: 200);

  final _scrollCurve = Curves.linear;

  int _itemCount = 4;

  void _onPageChanged(int page) {
    _pageController.animateToPage(page,
        duration: _scrollDuration,
        curve: _scrollCurve); // page를 controll하는 controller
    if (page == _itemCount - 1) {
      _itemCount = _itemCount + 4; // 무한 스크롤 가능
      setState(() {});
    }
  }

  void _onVideoFinished() {
    return;
    _pageController.nextPage(
      duration: _scrollDuration,
      curve: _scrollCurve,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  } // 메모리 누수를 방지하기 위해 항상 dispose를 잊지말자

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      // 페이지 넘기게 해주는 위젯 방향 조절 가능 페이지 생성 가능
      itemBuilder: (context, index) => VideoPost(
        onVideoFinished: _onVideoFinished,
        index: index,
      ), // VideoPost stful에게 넘겨주는 거임 함수를 ㅇㅇ
      itemCount: _itemCount,
      onPageChanged: _onPageChanged,
      scrollDirection: Axis.vertical,
    );
  }
}
