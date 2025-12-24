import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/theme/light_color.dart';
import 'package:news_app/core/widgets/custom_cached_network_image.dart';
import 'package:news_app/features/home/components/trending_news_shimmer.dart';
import 'package:news_app/features/home/components/view_all_component.dart';
import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSizes.h320,
        child: Stack(
          children: [
            SizedBox(
              height: AppSizes.h240,
              width: double.infinity,
              child: Image.asset(
                'assets/images/background.png',
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              top: AppSizes.ph65,
              child: Column(
                children: [
                  Text(
                    "NEWST",
                    style: TextStyle(
                      fontSize: AppSizes.sp32,
                      fontWeight: FontWeight.w600,
                      color: LightColor.primary,
                    ),
                  ),
                  SizedBox(height: AppSizes.ph6),
                  ViewAllComponent(title: 'Trending News', onTap: () {}),
                  SizedBox(height: AppSizes.ph12),
                  SizedBox(
                    height: AppSizes.h140,
                    child: Consumer<HomeController>(
                      builder: (context, HomeController controller, child) {
                        switch (controller.everythingStaus) {
                          case RequestStatusEnum.loading:
                            return Center(
                              child: Shimmer.fromColors(
                                highlightColor: Colors.grey.shade100,
                                baseColor: Colors.grey.shade300,
                                child: TrendingNewsShimmer(),
                              ),
                            );

                          case RequestStatusEnum.error:
                            return Center(
                              child: Text(controller.errorMessage!),
                            );

                          case RequestStatusEnum.loaded:
                            return ListView.builder(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  controller.newsEverythingList.take(6).length,
                              itemBuilder: (context, index) {
                                final model =
                                    controller.newsEverythingList[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: AppSizes.pw12,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.r8,
                                    ),
                                    child: Stack(
                                      children: [
                                        CustomCachedNetworkImage(
                                          imagePath: model.urlToImage ?? "",
                                          width: AppSizes.w240,
                                          height: AppSizes.h140,
                                        ),

                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Colors.black.withValues(
                                                    alpha: .1,
                                                  ),
                                                  Colors.black.withValues(
                                                    alpha: .2,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          bottom: AppSizes.ph8,
                                          left: AppSizes.pw10,
                                          right: 0,
                                          child: Column(
                                            children: [
                                              Text(
                                                model.title ?? '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: AppSizes.sp16,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              SizedBox(height: AppSizes.ph4),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        CircleAvatar(
                                                          backgroundImage:
                                                              NetworkImage(
                                                                model.urlToImage ??
                                                                    '',
                                                              ),
                                                          radius: AppSizes.r10,
                                                        ),
                                                        SizedBox(
                                                          width: AppSizes.pw4,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            model.author ?? '',
                                                            style: TextStyle(
                                                              fontSize:
                                                                  AppSizes.sp14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              color: Color(
                                                                0xFFFFFCFC,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      right: AppSizes.pw8,
                                                    ),
                                                    child: Text(
                                                      model.publishedAt
                                                          .timeAgo(),
                                                      style: TextStyle(
                                                        fontSize: AppSizes.sp14,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        color: Color(
                                                          0xFFFFFCFC,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
