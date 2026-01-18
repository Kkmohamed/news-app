import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enum.dart';
import 'package:news_app/core/mixins/safe_notify_mixin.dart';
import 'package:news_app/core/repos/news_repository.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

class SearchScreenController extends ChangeNotifier with SafeNotifyMixin {
  SearchScreenController(this.newsRepository);
  BaseNewsRepository newsRepository;
  TextEditingController searchController = TextEditingController();

  List<NewsArticleModel> newsEverythingList = [];
  RequestStatusEnum everythingStaus = RequestStatusEnum.loading;
  String? errorMessage;

  void getEverything() async {
    try {
      everythingStaus = RequestStatusEnum.loading;
      safeNotify();
      newsEverythingList = await newsRepository.getEverything(
        query: searchController.text,
      );

      everythingStaus = RequestStatusEnum.loaded;
      errorMessage = null;
    } catch (e) {
      everythingStaus = RequestStatusEnum.error;
      errorMessage = e.toString();
    }
    safeNotify();
  }
}
