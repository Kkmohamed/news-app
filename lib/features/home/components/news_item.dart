import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.post});
  final NewsArticleModel post;
  @override
  Widget build(BuildContext context) {
    return Padding(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    bottom: 6,
                    top: 6,
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: CustomCachedNetworkImage(
                          imagePath: post.urlToImage ?? "",
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              post.title ?? 'No Title',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff141414),
                              ),
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 10,
                                  backgroundImage: NetworkImage(
                                    post.urlToImage ?? "",
                                  ),
                                ),
                                SizedBox(width: 4),
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  (post.author ?? 'Unknown Author').substring(
                                    0,
                                    min(post.author?.length ?? 0, 10),
                                  ),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  post.publishedAt.timeAgo(),
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Spacer(),

                                Icon(
                                  Icons.bookmark_border,
                                  color: Color(0xFF363636),
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