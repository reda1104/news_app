// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive/hive.dart';
import 'package:news_app/core/models/article_model.dart';

class NewsApiResponse {
  final String status;
  final int totalResults;
  final List<Article>? articles;

  const NewsApiResponse({
    required this.status,
    required this.totalResults,
    this.articles,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'status': status,
      'totalResults': totalResults,
      if (articles != null)
        'articles': articles?.map((x) => x.toMap()).toList(),
    };
  }

  factory NewsApiResponse.fromMap(Map<String, dynamic> map) {
    return NewsApiResponse(
      status: map['status'] as String,
      totalResults: map['totalResults'] as int,
      articles: map['articles'] != null
          ? (map['articles'] as List<dynamic>)
                .map((x) => Article.fromMap(x as Map<String, dynamic>))
                .toList()
          : null,
    );
  }
}
