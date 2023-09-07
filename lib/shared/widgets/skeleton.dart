import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:trackbucks/config/config.dart';

class Skeleton extends StatelessWidget {
  final double height;
  const Skeleton({super.key, required this.height});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      highlightColor: Palette.background,
      baseColor: const Color(0xff060E23),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
        height: height,
      ),
    );
  }
}
