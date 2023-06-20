import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/videos/widgets/video_flashbutton.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin {
  bool _hasPermission = false;
  bool _deniedPermission = false;
  bool _isFlashModeVisible = false;
  bool _isSelfieMode = false;

  Icon _selectedFlashIcon = const Icon(Icons.flash_on);

  late final AnimationController _buttonAnimationController =
      AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 200,
    ),
  );

  late final Animation<double> _buttonAnimation =
      Tween(begin: 1.0, end: 1.3).animate(_buttonAnimationController);

  late final AnimationController _progressAnimationController =
      AnimationController(
          vsync: this,
          duration: const Duration(seconds: 10),
          lowerBound: 0.0,
          upperBound: 1.0);

  late FlashMode _flashMode;

  late CameraController _cameraController;

  Future<void> initCamera() async {
    final cameras = await availableCameras();

    if (cameras.isEmpty) {
      return;
    }

    _cameraController = CameraController(
      cameras[_isSelfieMode ? 1 : 0],
      ResolutionPreset.ultraHigh,
    );

    await _cameraController.initialize();

    _flashMode = _cameraController.value.flashMode;
  }

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();

    final cameraDenied =
        cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;

    final micDenied =
        micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      _hasPermission = true;
      await initCamera();
      setState(() {});
    } else {
      _deniedPermission = true;
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
    _progressAnimationController.addListener(() {
      setState(() {});
    });
    _progressAnimationController.addStatusListener(
      (status) {
        if (status == AnimationStatus.completed) {
          _stopRecording();
        }
      },
    );
  }

  Future<void> _toggleSelphieMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
    setState(() {});
  }

  Future<void> _setFlashMode(FlashMode newFlashMode) async {
    await _cameraController.setFlashMode(newFlashMode);
    _flashMode = newFlashMode;
    setState(() {});
  }

  void _toggleFlashModeVisibility() {
    _isFlashModeVisible = !_isFlashModeVisible;
    setState(
      () {},
    );
  }

  void _startRecording(TapDownDetails _) {
    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  void _stopRecording() {
    _buttonAnimationController.reverse();
    _progressAnimationController.reset();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: !_hasPermission || !_cameraController.value.isInitialized
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _deniedPermission
                          ? "Please allow camera and mic..."
                          : "Initializing....",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: Sizes.size20,
                      ),
                    ),
                    Gaps.v20,
                    const CircularProgressIndicator.adaptive(),
                  ],
                )
              : Stack(
                  alignment: Alignment.center,
                  children: [
                    CameraPreview(
                      _cameraController,
                    ),
                    Positioned(
                      top: Sizes.size10,
                      right: Sizes.size20,
                      child: IconButton(
                        color: Colors.white,
                        onPressed: _toggleSelphieMode,
                        icon: const Icon(
                          Icons.cameraswitch,
                        ),
                      ),
                    ),
                    Positioned(
                      top: Sizes.size80,
                      right: Sizes.size32,
                      child: GestureDetector(
                        onTap: _toggleFlashModeVisibility,
                        child: Row(
                          children: [
                            _selectedFlashIcon,
                            if (_isFlashModeVisible) ...[
                              const Text('  |'), // "|" 텍스트
                              FlashModeRow(
                                flashMode: FlashMode.off,
                                currentFlashMode: _flashMode,
                                onPressed: () {
                                  _setFlashMode(FlashMode.off);
                                  setState(() {
                                    _isFlashModeVisible = false;
                                    _selectedFlashIcon =
                                        const Icon(Icons.flash_off_rounded);
                                  });
                                },
                              ),
                            ],
                            if (_isFlashModeVisible) ...[
                              FlashModeRow(
                                flashMode: FlashMode.always,
                                currentFlashMode: _flashMode,
                                onPressed: () {
                                  _setFlashMode(FlashMode.always);
                                  setState(() {
                                    _isFlashModeVisible = false;
                                    _selectedFlashIcon =
                                        const Icon(Icons.flash_on_rounded);
                                  });
                                },
                              ),
                              FlashModeRow(
                                flashMode: FlashMode.auto,
                                currentFlashMode: _flashMode,
                                onPressed: () {
                                  _setFlashMode(FlashMode.auto);
                                  setState(() {
                                    _isFlashModeVisible = false;
                                    _selectedFlashIcon =
                                        const Icon(Icons.flash_auto_rounded);
                                  });
                                },
                              ),
                              FlashModeRow(
                                flashMode: FlashMode.torch,
                                currentFlashMode: _flashMode,
                                onPressed: () {
                                  _setFlashMode(FlashMode.torch);
                                  setState(() {
                                    _isFlashModeVisible = false;
                                    _selectedFlashIcon =
                                        const Icon(Icons.flashlight_on);
                                  });
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: Sizes.size40,
                      child: GestureDetector(
                        onTapDown: _startRecording,
                        onTapUp: (details) => _stopRecording(),
                        child: ScaleTransition(
                          scale: _buttonAnimation,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: Sizes.size80 + Sizes.size14,
                                height: Sizes.size80 + Sizes.size14,
                                child: CircularProgressIndicator(
                                  color: Colors.red.shade400,
                                  strokeWidth: Sizes.size6,
                                  value: _progressAnimationController.value,
                                ),
                              ),
                              Container(
                                width: Sizes.size80,
                                height: Sizes.size80,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.red.shade400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
