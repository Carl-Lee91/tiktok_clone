import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/videos/view_models/upload_video_view_model.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends ConsumerStatefulWidget {
  final XFile video;
  final bool isPicked;

  const VideoPreviewScreen({
    super.key,
    required this.video,
    required this.isPicked,
  });

  @override
  VideoPreviewScreenState createState() => VideoPreviewScreenState();
}

class VideoPreviewScreenState extends ConsumerState<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;

  bool _savedVideo = false;
  final TextEditingController _titleEditingController = TextEditingController();
  final TextEditingController _descriptionEditingController =
      TextEditingController();

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await _videoPlayerController.initialize();

    await _videoPlayerController.setLooping(true);

    //await _videoPlayerController.play();

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _titleEditingController.dispose();
    _descriptionEditingController.dispose();
    super.dispose();
  }

  Future<void> _saveToGallery() async {
    if (_savedVideo) return;

    await GallerySaver.saveVideo(widget.video.path, albumName: "Tictok Clone");

    _savedVideo = true;
    setState(() {});
  }

  void _onUploadPressed() {
    ref.read(uploadVideoProvider.notifier).uploadVideo(
          File(widget.video.path),
          context,
          _titleEditingController.text,
          _descriptionEditingController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Preview video"),
        actions: [
          if (!widget.isPicked)
            IconButton(
              onPressed: _saveToGallery,
              icon: FaIcon(
                _savedVideo
                    ? FontAwesomeIcons.check
                    : FontAwesomeIcons.download,
              ),
            ),
          IconButton(
            onPressed: ref.watch(uploadVideoProvider).isLoading
                ? () {}
                : _onUploadPressed,
            icon: ref.watch(uploadVideoProvider).isLoading
                ? const CircularProgressIndicator()
                : const FaIcon(
                    FontAwesomeIcons.cloudArrowUp,
                  ),
          ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized
          ? Stack(children: [
              VideoPlayer(_videoPlayerController),
              Positioned(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: Sizes.size60,
                      height: Sizes.size32,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Title',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        controller: _titleEditingController,
                      ),
                    ),
                    SizedBox(
                      width: 120,
                      height: Sizes.size32,
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Description',
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.5),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        controller: _descriptionEditingController,
                      ),
                    ),
                  ],
                ),
              )
            ])
          : null,
    );
  }
}
