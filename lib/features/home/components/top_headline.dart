
import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';

import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/home/components/top_headline_shimmer.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (BuildContext context, controller, Widget? child) {
        switch (controller.topHeadlinesStaus) {
          case RequestStatusEnum.loading:
            return TopHeadlineShimmer();
          case RequestStatusEnum.error:
            return SliverToBoxAdapter(
              child: Center(
                child: Text(
                  controller.errorMessage ?? 'Something went wrong',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            );
          case RequestStatusEnum.loaded:
            return SliverList.builder(
              itemCount: controller.newsTopHeadLineList.take(15).length,
              itemBuilder: (BuildContext context, int index) {
                final post = controller.newsTopHeadLineList[index];
                return NewsItem(post: post);
              },
            );
        }
      },
    );
  }
}
