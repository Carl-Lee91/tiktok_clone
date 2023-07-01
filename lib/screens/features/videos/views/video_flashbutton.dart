import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashModeRow extends StatelessWidget {
  final FlashMode flashMode;
  final FlashMode currentFlashMode;
  final VoidCallback onPressed;

  const FlashModeRow({
    super.key,
    required this.flashMode,
    required this.currentFlashMode,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = currentFlashMode == flashMode;
    final iconColor = isSelected ? Colors.amber.shade200 : Colors.white;

    return IconButton(
      color: iconColor,
      onPressed: onPressed,
      icon: _getFlashIcon(flashMode),
    );
  }

  Icon _getFlashIcon(FlashMode mode) {
    switch (mode) {
      case FlashMode.off:
        return const Icon(Icons.flash_off_rounded);
      case FlashMode.always:
        return const Icon(Icons.flash_on_rounded);
      case FlashMode.auto:
        return const Icon(Icons.flash_auto_rounded);
      case FlashMode.torch:
        return const Icon(Icons.flashlight_on);
      default:
        return const Icon(Icons.flash_off_rounded);
    }
  }
}
