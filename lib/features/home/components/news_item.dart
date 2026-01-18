import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.post});
  final NewsArticleModel post;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppSizes.pw16,
        right: AppSizes.pw16,
        bottom: AppSizes.ph6,
        top: AppSizes.ph6,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.r4),
            child: CustomCachedNetworkImage(imagePath: post.urlToImage ?? ""),
          ),
          SizedBox(width: AppSizes.pw8),
          Expanded(
            child: Column(
              children: [
                Text(
                  post.title ?? 'No Title',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: AppSizes.sp16,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff141414),
                  ),
                ),
                SizedBox(height: AppSizes.ph4),
                Row(
                  children: [
                    CircleAvatar(
                      radius: AppSizes.r10,
                      backgroundImage: NetworkImage(post.urlToImage ?? ""),
                    ),
                    SizedBox(width: AppSizes.pw4),
                    Flexible(
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        (post.author ?? 'Unknown Author').substring(
                          0,
                          min(post.author?.length ?? 0, 10),
                        ),
                      ),
                    ),
                    SizedBox(width: AppSizes.pw8),
                    Text(
                      post.publishedAt.timeAgo(),
                      style: TextStyle(color: Colors.grey),
                    ),
                    Spacer(),
                    Icon(
                      Icons.bookmark_border,
                      color: Color(0xFF363636),
                      size: AppSizes.r20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
