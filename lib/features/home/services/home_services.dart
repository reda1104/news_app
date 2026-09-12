import 'package:dio/dio.dart';
import 'package:news_app/core/utils/app_constants.dart';
import 'package:news_app/features/home/models/top_headlines_api_response.dart';
import 'package:news_app/features/home/models/top_headlines_body.dart';

class HomeServices {
  final aDio = Dio();
  Future<TopHeadlinesApiResponse> getTopHeadLines(TopHeadlinesBody body) async {
    try {
      aDio.options.baseUrl = AppConstants.baseUrl;
      final headers = {"Authorization": "Bearer ${AppConstants.apiKey}"};
      final TopHeadLinesResponse = await aDio.get(
        AppConstants.topHeadlines,
        queryParameters: body.toMap(),
        options: Options(headers: headers),
      );
      if (TopHeadLinesResponse.statusCode == 200) {
        return TopHeadlinesApiResponse.fromMap(TopHeadLinesResponse.data);
      } else {
        throw Exception(TopHeadLinesResponse.statusMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}
