import 'package:flutter/material.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class FollowersLikes extends StatelessWidget {
  const FollowersLikes({
    super.key,
    required this.following,
    required this.followers,
    required this.likes,
  });

  final String following;
  final String followers;
  final String likes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.size48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Text(
                following,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Sizes.size18,
                ),
              ),
              Gaps.v2,
              Text(
                "Following",
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          VerticalDivider(
            width: Sizes.size32,
            thickness: Sizes.size1,
            color: Colors.grey.shade400,
            indent: Sizes.size14,
            endIndent: Sizes.size14,
          ),
          Column(
            children: [
              Text(
                followers,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Sizes.size18,
                ),
              ),
              Gaps.v2,
              Text(
                "Followers",
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          VerticalDivider(
            width: Sizes.size32,
            thickness: Sizes.size1,
            color: Colors.grey.shade400,
            indent: Sizes.size14,
            endIndent: Sizes.size14,
          ),
          Column(
            children: [
              Text(
                likes,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Sizes.size18,
                ),
              ),
              Gaps.v2,
              Text(
                "Likes",
                style: TextStyle(
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
