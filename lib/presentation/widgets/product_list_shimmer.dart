import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductListShimmer extends StatelessWidget {
  const ProductListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        itemCount: 6,
        itemBuilder: (context, index) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.all(12),
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  width: 80,
                  height: 80,
                  color: Colors.white,
                ),
              ),
              title: Container(
                height: 20,
                color: Colors.white,
              ),
              subtitle: Container(
                height: 15,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
