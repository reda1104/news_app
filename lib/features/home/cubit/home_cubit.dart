import 'package:bloc/bloc.dart';
import 'package:news_app/features/home/models/top_headlines_api_response.dart';
import 'package:news_app/features/home/models/top_headlines_body.dart';
import 'package:news_app/features/home/services/home_services.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

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
      emit(RecommendedArticlesLoaded(result.articles));
    } catch (e) {
      emit(RecommendedArticlesError(errorMessage: e.toString()));
    }
  }
}
