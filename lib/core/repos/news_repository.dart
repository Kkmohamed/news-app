import 'package:news_app/core/datasource/remotedata/api_config.dart';
import 'package:news_app/core/datasource/remotedata/api_service.dart';
import 'package:news_app/features/home/models/news_article_model.dart';

abstract class BaseNewsRepository {
  Future<List<NewsArticleModel>> getTopHeadLine({
    String? selectedCategory = 'general',
  });
  Future<List<NewsArticleModel>> getEverything({String? query = 'news'});
}

class NewsRepository extends BaseNewsRepository {
  final BaseApiService apiService;

  NewsRepository(this.apiService);
  @override
  Future<List<NewsArticleModel>> getTopHeadLine({
    String? selectedCategory = 'general',
  }) async {
    Map<String, dynamic> data = await apiService.get(
      ApiConfig.topHeadlines,
      params: {'country': 'us', "category": selectedCategory},
    );

    return (data['articles'] as List)
        .map((article) => NewsArticleModel.fromJson(article))
        .toList();
  }

  @override
  Future<List<NewsArticleModel>> getEverything({String? query = 'news'}) async {
    Map<String, dynamic> data = await apiService.get(
      ApiConfig.everything,
      params: {'q': query},
    );
    return (data['articles'] as List)
        .map((article) => NewsArticleModel.fromJson(article))
        .toList();
  }
}
