import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/screens/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok_clone/screens/features/videos/views/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({super.key});

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
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
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  } // 메모리 누수를 방지하기 위해 항상 dispose를 잊지말자

  Future<void> _onRefresh() {
    return Future.delayed(
      const Duration(seconds: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(timelineProvider).when(
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              "Could not load videos: $error",
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          data: (videos) => RefreshIndicator(
            displacement: 50,
            edgeOffset: 20,
            onRefresh: _onRefresh,
            color: Theme.of(context).primaryColor,
            child: PageView.builder(
              controller: _pageController,
              // 페이지 넘기게 해주는 위젯 방향 조절 가능 페이지 생성 가능
              itemBuilder: (context, index) => VideoPost(
                onVideoFinished: _onVideoFinished,
                index: index,
              ), // VideoPost stful에게 넘겨주는 거임 함수를 ㅇㅇ
              itemCount: videos.length,
              onPageChanged: _onPageChanged,
              scrollDirection: Axis.vertical,
            ),
          ),
        );
  }
}
