import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class ProductDetailShimmerLoading extends StatelessWidget {
  const ProductDetailShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Theme.of(context).colorScheme.surfaceContainerHigh,
      highlightColor: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image placeholder
          Container(
            height: 300.h,
            color: Theme.of(context).colorScheme.surfaceContainer,
          ),
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name placeholder
                Container(
                  width: double.infinity,
                  height: 24.h,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(height: 8.h),
                // Brand placeholder
                Container(
                  width: 150.w,
                  height: 16.h,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(height: 8.h),
                // Price placeholder
                Container(
                  width: 100.w,
                  height: 24.h,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(height: 16.h),
                // Stock & Ratings placeholder
                Row(
                  children: [
                    Container(
                      width: 80.w,
                      height: 16.h,
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      width: 80.w,
                      height: 16.h,
                      color: Theme.of(context).colorScheme.surfaceContainer,
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                // Quantity Selector placeholder
                Container(
                  width: double.infinity,
                  height: 40.h,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(height: 20.h),
                // Description title placeholder
                Container(
                  width: 120.w,
                  height: 18.h,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(height: 8.h),
                // Description lines placeholder
                Container(
                  width: double.infinity,
                  height: 16.h,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(height: 4.h),
                Container(
                  width: double.infinity,
                  height: 16.h,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
                SizedBox(height: 4.h),
                Container(
                  width: 200.w,
                  height: 16.h,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
              ],
            ),
          ),
          // Bottom buttons placeholder
          Container(
            padding: EdgeInsets.all(16.w),
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 50.h,
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Container(
                    height: 50.h,
                    color: Theme.of(context).colorScheme.surfaceContainer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
