import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CatFactShimmerSkeleton extends StatelessWidget {
  final Color baseColor = Colors.grey[300]!;
  final Color highlightColor = Colors.grey[100]!;

  CatFactShimmerSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              color: baseColor,
            ),
            const SizedBox(height: 24.0),
            Container(
              height: 16.0,
              width: 100,
              color: baseColor,
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 16.0,
              width: double.infinity,
              color: baseColor,
            ),
            const SizedBox(height: 8.0),
            Container(
              height: 16.0,
              width: double.infinity,
              color: baseColor,
            ),
          ],
        ),
      ),
    );
  }
}
