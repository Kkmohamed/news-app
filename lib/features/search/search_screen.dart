import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:news_app/core/constants/app_sizes.dart';
import 'package:news_app/core/datasource/remotedata/api_service.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/components/news_item.dart';
import 'package:news_app/features/search/controller/search_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return SearchScreenController(NewsRepository(ApiService()));
      },
      child: Scaffold(
        appBar: AppBar(title: Text('Search'), backgroundColor: Colors.white),
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.pw16,
            vertical: AppSizes.ph20,
          ),
          child: Consumer<SearchScreenController>(
            builder: (
              BuildContext context,
              SearchScreenController controller,
              Widget? child,
            ) {
              return Column(
                children: [
                  TextField(
                    controller: controller.searchController,
                    onSubmitted: (value) {
                      controller.getEverything();
                    },
                    decoration: InputDecoration(
                      suffix: SvgPicture.asset(
                        'assets/images/search_field.svg',
                        colorFilter: ColorFilter.mode(
                          Color(0xffA0A0A0),
                          BlendMode.srcIn,
                        ),
                        width: AppSizes.w20,
                        height: AppSizes.h20,
                      ),
                      hintText: 'Search',
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemCount: controller.newsEverythingList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(color: Color(0xffA0A0A0));
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final model = controller.newsEverythingList[index];
                        return ListTile(
                          leading: SvgPicture.asset(
                            'assets/images/search_field.svg',
                            colorFilter: ColorFilter.mode(
                              Color(0xffA0A0A0),
                              BlendMode.srcIn,
                            ),
                            width: AppSizes.w20,
                            height: AppSizes.h20,
                          ),
                          title: Text(model.title!, maxLines: 1),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
