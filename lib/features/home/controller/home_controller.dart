import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remotedata/api_config.dart';
import 'package:news_app/core/datasource/remotedata/api_service.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class HomeController with ChangeNotifier {
  HomeController() {
    getTopHeadLine();
    getEverything();
  }
  RequestStatusEnum everythingStaus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadlinesStaus = RequestStatusEnum.loading;

  String? errorMessage;
  List<NewsArticleModel> newsTopHeadLineList = [];
  List<NewsArticleModel> newsEverythingList = [];

  String selectedCategory = categories[0];

  ApiService apiService = ApiService();

  void getTopHeadLine({String? category}) async {
    try {
      Map<String, dynamic> data = await apiService.get(
        ApiConfig.topHeadlines,
        params: {'country': 'us', "category": selectedCategory},
      );

      newsTopHeadLineList =
          (data['articles'] as List)
              .map((article) => NewsArticleModel.fromJson(article))
              .toList();
      topHeadlinesStaus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      topHeadlinesStaus = RequestStatusEnum.error;
    }
    notifyListeners();
  }

  void getEverything() async {
    try {
      Map<String, dynamic> data = await apiService.get(
        ApiConfig.everything,
        params: {'q': 'news'},
      );
      newsEverythingList =
          (data['articles'] as List)
              .map((article) => NewsArticleModel.fromJson(article))
              .toList();
      everythingStaus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everythingStaus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    notifyListeners();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLine(category: category);
    notifyListeners();
  }
}
  