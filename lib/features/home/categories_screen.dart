import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';

import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';

import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/components/news_item.dart';

import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('Categories')),
      body: Consumer<HomeController>(
        builder: (BuildContext context, controller, Widget? child) {
          return Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: SizedBox(
                      height: 32,
                      child: ListView.separated(
                        padding: EdgeInsets.zero,
                        separatorBuilder:
                            (context, index) => SizedBox(width: 12),

                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final isSelected =
                              categories[index] == controller.selectedCategory;
                          return GestureDetector(
                            onTap: () {
                              controller.updateSelectedCategory(
                                categories[index],
                              );
                            },
                            child: IntrinsicWidth(
                              child: Column(
                                children: [
                                  Text(
                                    categories[index][0].toUpperCase() +
                                        categories[index].substring(1),
                                    style: TextStyle(
                                      color:
                                          isSelected
                                              ? LightColor.primary
                                              : Color(0xFF363636),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (isSelected) ...[
                                    SizedBox(height: 4),
                                    Container(
                                      height: 2,
                                      color: LightColor.primary,
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.newsTopHeadLineList.take(15).length,
                  itemBuilder: (BuildContext context, int index) {
                    final post = controller.newsTopHeadLineList[index];
                    return NewsItem(post: post);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
