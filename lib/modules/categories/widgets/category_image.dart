import 'package:flutter/material.dart';

class CategoryImage extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  const CategoryImage(this.image,{super.key, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.cover),
      ),
    );
  }
}
