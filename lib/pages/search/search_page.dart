import 'package:flutter/material.dart';
import 'package:news/models/sport_model.dart';
import 'package:news/pages/detail/detail_page.dart';
import 'package:news/provider/search_provider.dart';
import 'package:news/widgets/loading/search_loading.dart';
import 'package:provider/provider.dart';

class SearchPage extends SearchDelegate {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          // When pressed here the query will be cleared from the search bar.
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();

    return FutureBuilder(
      future:
          Provider.of<SearchProvider>(context, listen: false).getSearch(query),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const SearchLoading();
        List<SportModel> data = snapshot.data as List<SportModel>;

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(data[index].thumb),
              ),
              title: Text(data[index].title),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailPage(
                      sports: data[index],
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future:
          Provider.of<SearchProvider>(context, listen: false).getSearch(query),
      initialData: const [],
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return const CircularProgressIndicator();
        List<SportModel> data = snapshot.data as List<SportModel>;

        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(data[index].title),
              onTap: () {},
            );
          },
        );
      },
    );
  }
}
