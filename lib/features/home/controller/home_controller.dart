import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/remotedata/api_config.dart';
import 'package:news_app/core/datasource/remotedata/api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class HomeController with ChangeNotifier {
  HomeController() {
    getTopHeadLine();
    getEverything();
  }
  bool topHeadlinesLoading = true;
  bool everythingLoading = true;
  String? errorMessage;
  List<NewsArticleModel> newsTopHeadLineList = [];
  List<NewsArticleModel> newsEverythingList = [];
  ApiService apiService = ApiService();
  void getTopHeadLine() async {
    try {
      Map<String, dynamic> data = await apiService.get(
        ApiConfig.topHeadlines,
        params: {'country': 'us'},
      );

      newsTopHeadLineList =
          (data['articles'] as List)
              .map((article) => NewsArticleModel.fromJson(article))
              .toList();
      topHeadlinesLoading = false;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      topHeadlinesLoading = false;
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
      everythingLoading = false;
      errorMessage = null;
    } catch (e) {
      everythingLoading = false;
      errorMessage = e.toString();
    }
    notifyListeners();
  }
}
