import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.radius = 10.0,
  });

  final Widget child;
  final double radius;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final sw = MediaQuery.of(context).size.width;
    return SizedBox(
      width: width ?? sw,
      height: height ?? 100.0,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: child,
      ),
    );
  }
}
