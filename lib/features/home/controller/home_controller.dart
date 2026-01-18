import 'package:flutter/material.dart';

import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/features/home/components/categories_list.dart';
import 'package:news_app/features/home/models/news_article_model.dart';
import 'package:news_app/core/repos/news_repository.dart';

class HomeController extends ChangeNotifier with SafeNotifyMixin {
  HomeController(this.newsRepository) {
    getTopHeadLine();
    getEverything();
  }
  bool isDispose = false;
  RequestStatusEnum everythingStaus = RequestStatusEnum.loading;
  RequestStatusEnum topHeadlinesStaus = RequestStatusEnum.loading;

  String? errorMessage;
  List<NewsArticleModel> newsTopHeadLineList = [];
  List<NewsArticleModel> newsEverythingList = [];

  String selectedCategory = categories[0];
  final BaseNewsRepository newsRepository;

  void getTopHeadLine({String? category}) async {
    try {
      topHeadlinesStaus = RequestStatusEnum.loading;
      safeNotify();
      newsTopHeadLineList = await newsRepository.getTopHeadLine(
        selectedCategory: selectedCategory,
      );
      topHeadlinesStaus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      topHeadlinesStaus = RequestStatusEnum.error;
    }
    safeNotify();
  }

  void getEverything() async {
    try {
      everythingStaus = RequestStatusEnum.loading;
      safeNotify();
      newsEverythingList = await newsRepository.getEverything();

      everythingStaus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everythingStaus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }

  void updateSelectedCategory(String category) {
    selectedCategory = category;
    getTopHeadLine(category: category);
    safeNotify();
  }


}
