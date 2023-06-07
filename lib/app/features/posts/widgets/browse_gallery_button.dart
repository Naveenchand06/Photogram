import 'package:cinepebble_social/utils/app_colors.dart';
import 'package:flutter/material.dart';

class BrowseGalleryButton extends StatelessWidget {
  const BrowseGalleryButton({
    super.key,
    required this.onPress,
  });

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.image,
            color: Colors.grey.shade700,
          ),
          const SizedBox(width: 10.0),
          Text(
            'Browse Gallery',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColor.appColor),
          )
        ],
      ),
    );
  }
}
