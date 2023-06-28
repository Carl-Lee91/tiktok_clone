import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/screens/features/videos/widgets/video_flashbutton.dart';
import 'package:tiktok_clone/screens/features/videos/widgets/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({super.key});

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen>
    with TickerProviderStateMixin, WidgetsBindingObserver {
  bool _hasPermission = false;
  bool _deniedPermission = false;
  bool _isFlashModeVisible = false;
  bool _isSelfieMode = false;

  Icon _selectedFlashIcon = const Icon(Icons.flash_on);

  double _minZoomLevel = 1.0;
  double _maxZoomLevel = 1.0;
  final double _currentZoomLevel = 1.0;

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

    await _cameraController.prepareForVideoRecording();

    _flashMode = _cameraController.value.flashMode;

    _minZoomLevel = await _cameraController.getMinZoomLevel();
    _maxZoomLevel = await _cameraController.getMaxZoomLevel();

    setState(() {});
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
    WidgetsBinding.instance.addObserver(this);
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

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    await _cameraController.startVideoRecording();

    _buttonAnimationController.forward();
    _progressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _buttonAnimationController.reverse();
    _progressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: false,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _progressAnimationController.dispose();
    _buttonAnimationController.dispose();
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_hasPermission) return;
    if (!_cameraController.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  Future<void> _onPickVideoPressed() async {
    final video = await ImagePicker().pickVideo(
      source: ImageSource.gallery,
    );
    if (video == null) return;

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isPicked: true,
        ),
      ),
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    double delta = details.localPosition.dy;

    print(delta);

    if (delta >= 0) {
      if (_minZoomLevel > _currentZoomLevel + (-delta * 0.01)) return;
      _cameraController.setZoomLevel(_currentZoomLevel + (-delta * 0.01));
    } else {
      if (_maxZoomLevel < _currentZoomLevel + (-delta * 0.01)) return;
      _cameraController.setZoomLevel(_currentZoomLevel + (-delta * 0.01));
    }
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
                                  setState(
                                    () {
                                      _isFlashModeVisible = false;
                                      _selectedFlashIcon =
                                          const Icon(Icons.flash_off_rounded);
                                    },
                                  );
                                },
                              ),
                            ],
                            if (_isFlashModeVisible) ...[
                              FlashModeRow(
                                flashMode: FlashMode.always,
                                currentFlashMode: _flashMode,
                                onPressed: () {
                                  _setFlashMode(FlashMode.always);
                                  setState(
                                    () {
                                      _isFlashModeVisible = false;
                                      _selectedFlashIcon =
                                          const Icon(Icons.flash_on_rounded);
                                    },
                                  );
                                },
                              ),
                              FlashModeRow(
                                flashMode: FlashMode.auto,
                                currentFlashMode: _flashMode,
                                onPressed: () {
                                  _setFlashMode(FlashMode.auto);
                                  setState(
                                    () {
                                      _isFlashModeVisible = false;
                                      _selectedFlashIcon =
                                          const Icon(Icons.flash_auto_rounded);
                                    },
                                  );
                                },
                              ),
                              FlashModeRow(
                                flashMode: FlashMode.torch,
                                currentFlashMode: _flashMode,
                                onPressed: () {
                                  _setFlashMode(FlashMode.torch);
                                  setState(
                                    () {
                                      _isFlashModeVisible = false;
                                      _selectedFlashIcon =
                                          const Icon(Icons.flashlight_on);
                                    },
                                  );
                                },
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: Sizes.size40,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTapDown: _startRecording,
                            onTapUp: (details) => _stopRecording(),
                            onPanUpdate: _onPanUpdate,
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
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: _onPickVideoPressed,
                                icon: const FaIcon(
                                  FontAwesomeIcons.image,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
