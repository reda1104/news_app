import 'package:dio/dio.dart';
import 'package:news_app/core/models/news_api_response.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/search/models/search_body.dart';

class SearchServices {
  final aDio = Dio();

  Future<NewsApiResponse> Search(SearchBody body) async {
    try {
      aDio.options.baseUrl = AppConstants.baseUrl;
      final headers = {"Authorization": "Bearer ${AppConstants.apiKey}"};
      final searchResponse = await aDio.get(
        AppConstants.everything,
        queryParameters: body.toMap(),
        options: Options(headers: headers),
      );
      if (searchResponse.statusCode == 200) {
        return NewsApiResponse.fromMap(searchResponse.data);
      } else {
        throw Exception('Failed to load search results');
      }
    } catch (e) {
      rethrow;
    }
  }
}
