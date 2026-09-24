import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/models/article_model.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/features/search/models/search_body.dart';
import 'package:news_app/features/search/services/search_services.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Future<void> search(String query) async {
    final searchServices = SearchServices();
    emit(SearchResultsLoading());
    try {
      final searchBody = SearchBody(q: query);
      final response = await searchServices.Search(searchBody);
      emit(SearchResultsLoaded(response.articles ?? []));
    } catch (e) {
      emit(SearchResultsError(e.toString()));
    }
  }
}
