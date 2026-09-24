import 'package:bloc/bloc.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/services/local_database_hive.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/home/models/top_headlines_body.dart';
import 'package:news_app/features/home/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final localDatabaseHive = LocalDatabaseHive();

  Future<void> getTopHeadlines() async {
    emit(const TopHeadlinesLoading());
    try {
      final homeServices = HomeServices();
      final body = TopHeadlinesBody(category: 'general', pageSize: 7, page: 1);
      final result = await homeServices.getTopHeadLines(body);
      emit(TopHeadlinesLoaded(result.articles));
    } catch (e) {
      emit(TopHeadlinesError(errorMessage: e.toString()));
    }
  }

  Future<void> getRecommendedArticles() async {
    emit(RecommendedArticlesLoading());
    try {
      final homeServices = HomeServices();
      final body = TopHeadlinesBody(pageSize: 15, page: 1);
      final result = await homeServices.getTopHeadLines(body);
      final articles = result.articles ?? [];
      final favArticles = await _getFavorite();

      for (int i = 0; i < articles.length; i++) {
        var article = articles[i];
        final isFound = favArticles.any(
          (element) => element.title == article.title,
        );
        if (isFound) {
          article = article.copyWith(isFavorite: true);
          articles[i] = article;
        }
      }

      emit(RecommendedArticlesLoaded(result.articles));
    } catch (e) {
      emit(RecommendedArticlesError(errorMessage: e.toString()));
    }
  }

  Future<List<Article>> _getFavorite() async {
    final favorites = await localDatabaseHive.getData(
      AppConstants.localDatabaseBox,
    );

    if (favorites == null) {
      return [];
    }

    return (favorites as List).cast<Article>();
  }
}
