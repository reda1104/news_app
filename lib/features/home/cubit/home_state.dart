part of 'home_cubit.dart';

sealed class HomeState {
  const HomeState();
}

final class HomeInitial extends HomeState {
  const HomeInitial();
}

final class TopHeadlinesLoading extends HomeState {
  const TopHeadlinesLoading();
}

final class TopHeadlinesLoaded extends HomeState {
  final List<Article>? articles;

  const TopHeadlinesLoaded(this.articles);
}

final class TopHeadlinesError extends HomeState {
  final String errorMessage;

  const TopHeadlinesError({required this.errorMessage});
}

final class RecommendedArticlesLoading extends HomeState {}

final class RecommendedArticlesLoaded extends HomeState {
  final List<Article>? articles;

  const RecommendedArticlesLoaded(this.articles);
}

final class RecommendedArticlesError extends HomeState {
  final String errorMessage;

  const RecommendedArticlesError({required this.errorMessage});
}
