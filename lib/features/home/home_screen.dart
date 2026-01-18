import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/remotedata/api_service.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/components/top_headline.dart';
import 'package:news_app/features/home/components/trending_news.dart';

import 'package:news_app/features/home/controller/home_controller.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeController(NewsRepository(ApiService())),
      child: Consumer<HomeController>(
        builder: (context, HomeController controller, child) {
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                TrendingNews(),
                CategoriesList(),
                SliverToBoxAdapter(child: SizedBox(height: AppSizes.ph16)),
                TopHeadline(),
              ],
            ),
          );
        },
      ),
    );
  }
}
