import 'package:flutter/material.dart';

class PositionedImage extends StatelessWidget {
  const PositionedImage({
    super.key,
    required this.top,
    this.left,
    required this.imageName,
  });

  final double top;
  final double? left;
  final String imageName;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: left,
      child: Image.asset("images/$imageName.png"),
    );
  }
}