import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/utils/theme/app_colors.dart';
import 'package:news_app/core/views/widgets/article_item_widget.dart';
import 'package:news_app/features/search/cubit/search_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final searchCubit = BlocProvider.of<SearchCubit>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Search')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 12.0),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: BlocBuilder<SearchCubit, SearchState>(
                  bloc: searchCubit,
                  buildWhen: (previous, current) =>
                      current is SearchResultsLoading ||
                      current is SearchResultsLoaded ||
                      current is SearchResultsError,
                  builder: (context, state) {
                    if (state is SearchResultsLoading) {
                      return TextButton(
                        onPressed: null,
                        child: Text(
                          'Search',
                          style: TextStyle(color: AppColors.grey),
                        ),
                      );
                    }
                    return TextButton(
                      onPressed: () async {
                        if (_searchController.text.isNotEmpty) {
                          await searchCubit.search(_searchController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter a search title'),
                            ),
                          );
                        }
                      },
                      child: Text(
                        'Search',
                        style: TextStyle(color: AppColors.primaryColor),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 16.0),
            BlocBuilder<SearchCubit, SearchState>(
              bloc: searchCubit,
              buildWhen: (previous, current) =>
                  current is SearchResultsLoading ||
                  current is SearchResultsLoaded ||
                  current is SearchResultsError,
              builder: (context, state) {
                if (state is SearchResultsLoading) {
                  return Center(child: CircularProgressIndicator.adaptive());
                } else if (state is SearchResultsLoaded) {
                  final articles = state.articles;
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 16),
                      itemCount: articles.length,
                      itemBuilder: (context, index) {
                        final article = articles[index];
                        return ArticleItemWidget(article: article);
                      },
                    ),
                  );
                } else if (state is SearchResultsError) {
                  return Center(child: Text('Error: ${state.message}'));
                }
                return Expanded(
                  child: Center(
                    child: const Text(
                      'Search for news articles...',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                ); // Return an empty widget for the initial state
              },
            ),
          ],
        ),
      ),
    );
  }
}
