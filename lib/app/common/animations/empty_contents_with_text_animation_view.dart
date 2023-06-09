import 'package:cinepebble_social/app/common/animations/empty_contents_animation_view.dart';
import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:flutter/material.dart';

class EmptyContentsWithTextAnimationView extends StatelessWidget {
  const EmptyContentsWithTextAnimationView({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Card(
            color: AppColor.appColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(
                text,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.white,
                    ),
              ),
            ),
          ),
          const SizedBox(
            height: 300.0,
            width: 300.0,
            child: EmptyContentsAnimationView(),
          ),
        ],
      ),
    );
  }
}
