import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProfileShimmerLoading extends StatelessWidget {
  const ProfileShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      highlightColor: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 16.h,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 16.h,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 16.h,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 16.h,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
            SizedBox(height: 8.h),
            Container(
              width: double.infinity,
              height: 16.h,
              color: Theme.of(context).colorScheme.surfaceContainer,
            ),
          ],
        ),
      ),
    );
  }
}
