import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: Icon(
            Icons.shopping_cart_outlined, // ✅ updated icon
            color: Theme.of(context).colorScheme.primary,
            size: 40.sp,
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'Your Style Your Store',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8.h),
      ],
    );
  }
}
