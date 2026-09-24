import 'package:hive/hive.dart';
import 'package:news_app/core/models/news_api_response.dart';
part 'article_model.g.dart';

@HiveType(typeId: 0)
class Article extends HiveObject {
  @HiveField(0)
  final Source? source;
  @HiveField(1)
  final String? author;
  @HiveField(2)
  final String? title;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final String? url;
  @HiveField(5)
  final String? urlToImage;
  @HiveField(6)
  final DateTime? publishedAt;
  @HiveField(7)
  final String? content;
  @HiveField(8)
  final bool isFavorite;
  Article({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
    this.isFavorite = false,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'source': source?.toMap(),
      'author': author,
      'title': title,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'publishedAt': publishedAt?.toIso8601String(),
      'content': content,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      source: map['source'] != null
          ? Source.fromMap(map['source'] as Map<String, dynamic>)
          : null,

      author: map['author'] as String?,

      title: map['title'] as String?,

      description: map['description'] as String?,

      url: map['url'] as String?,

      urlToImage: map['urlToImage'] as String?,

      publishedAt: map['publishedAt'] != null
          ? DateTime.parse(map['publishedAt'] as String)
          : null,

      content: map['content'] as String?,
    );
  }

  Article copyWith({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    DateTime? publishedAt,
    String? content,
    bool? isFavorite = false,
  }) {
    return Article(
      source: source ?? this.source,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishedAt ?? this.publishedAt,
      content: content ?? this.content,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}

@HiveType(typeId: 1)
class Source extends HiveObject {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? name;

  Source({this.id, this.name});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'name': name};
  }

  factory Source.fromMap(Map<String, dynamic> map) {
    return Source(id: map['id'] as String?, name: map['name'] as String?);
  }
}
