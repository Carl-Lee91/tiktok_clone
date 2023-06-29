import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/utils.dart';

class PostVideoBtn extends StatelessWidget {
  const PostVideoBtn({
    super.key,
    required this.inverted,
  });

  final bool inverted;

  @override
  Widget build(BuildContext context) {
    final isDark = isDarkMode(context);
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          right: 4,
          child: Container(
            height: 35,
            width: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: const Color(0xff61D4F0),
              borderRadius: BorderRadius.circular(
                Sizes.size8,
              ),
            ),
          ),
        ),
        Positioned(
          left: 4,
          child: Container(
            height: 35,
            width: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size8,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(
                Sizes.size8,
              ),
            ),
          ),
        ),
        Container(
          height: 35,
          width: 50,
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
              Sizes.size8,
            ),
            color: !inverted || isDark ? Colors.white : Colors.black,
          ),
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.plus,
              color: !inverted || isDark ? Colors.black : Colors.white,
              size: Sizes.size20 + Sizes.size2,
            ),
          ),
        )
      ],
    );
  }
}
