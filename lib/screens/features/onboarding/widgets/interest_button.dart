import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class InterestBtn extends StatefulWidget {
  const InterestBtn({
    super.key,
    required this.interest,
  });

  final String interest;

  @override
  State<InterestBtn> createState() => _InterestBtnState();
}

class _InterestBtnState extends State<InterestBtn> {
  bool _isSelected = false;

  void _onTap() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.symmetric(
          vertical: Sizes.size16,
          horizontal: Sizes.size20,
        ),
        decoration: BoxDecoration(
          color: _isSelected
              ? Theme.of(context).primaryColor
              : isDarkMode(context)
                  ? Colors.grey.shade700
                  : Colors.white,
          borderRadius: BorderRadius.circular(
            Sizes.size32,
          ),
          border: Border.all(
            color: Colors.black.withOpacity(0.1),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              spreadRadius: 1,
            )
          ],
        ),
        child: Text(
          widget.interest,
          style: TextStyle(
            color: _isSelected ? Colors.white : Colors.black87,
            fontSize: Sizes.size16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
