// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SearchBody {
  final String q;
  final String searchIn;
  final int page;
  final int pageSize;

  const SearchBody({
    required this.q,
    this.searchIn = "title",
    this.page = 1,
    this.pageSize = 10,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'q': q,
      'searchIn': searchIn,
      'page': page,
      'pageSize': pageSize,
    };
  }

  factory SearchBody.fromMap(Map<String, dynamic> map) {
    return SearchBody(
      q: map['q'] as String,
      searchIn: map['searchIn'] as String,
      page: map['page'] as int,
      pageSize: map['pageSize'] as int,
    );
  }
}
