import 'package:flutter/material.dart';

class VideoConfig extends ChangeNotifier {
  bool isMuted = false;
  bool isAutoplay = false;
  bool isDarkmode = false;

  void toggleIsMuted() {
    isMuted = !isMuted;
    notifyListeners();
  }

  void toggleIsAutoplay() {
    isAutoplay = !isAutoplay;
    notifyListeners();
  }

  void toggleIsDarkmode() {
    isDarkmode = !isDarkmode;
    notifyListeners();
  }
}
