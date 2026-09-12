// ignore_for_file: public_member_api_docs, sort_constructors_first
class TopHeadlinesBody {
  final String country;
  final String? category;
  final String? q;
  final String? sources;
  final int? pageSize;
  final int? page;

  new({
    this.country = 'us',
    this.category,
    this.q,
    this.sources,
    this.pageSize,
    this.page,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'country': country,
      'category': category,
      'q': q,
      'sources': sources,
      'pageSize': pageSize,
      'page': page,
    };
  }

  factory TopHeadlinesBody.fromMap(Map<String, dynamic> map) {
    return TopHeadlinesBody(
      country: map['country'] != null ? map['country'] as String : 'us',
      category: map['category'] != null ? map['category'] as String : null,
      q: map['q'] != null ? map['q'] as String : null,
      sources: map['sources'] != null ? map['sources'] as String : null,
      pageSize: map['pageSize'] != null ? map['pageSize'] as int : null,
      page: map['page'] != null ? map['page'] as int : null,
    );
  }
}
