import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNewsShimmer extends StatelessWidget {
  const TrendingNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.pw12),
          child: Shimmer.fromColors(
            highlightColor: Colors.grey.shade100,
            baseColor: Colors.grey.shade300,
            child: Container(
              width: AppSizes.w240,
              height: AppSizes.h140,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
