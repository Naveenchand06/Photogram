import 'package:flutter/material.dart';

import '../../../../utils/app_colors.dart';

class SimpleButton extends StatelessWidget {
  const SimpleButton({
    super.key,
    required this.text,
    this.bgColor = AppColor.primaryColor,
    this.textColor = AppColor.whiteColor,
    required this.onPress,
  });

  final String text;
  final Color bgColor;
  final Color textColor;
  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    double sh = MediaQuery.of(context).size.height;
    double sw = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: bgColor,
        minimumSize: Size(sw * 26 / 100, sh * 5 / 100),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(
        'Next',
        style: TextStyle(
          fontSize: 16.0,
          color: textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
