import 'package:flutter/material.dart';
import 'package:news/models/sport_model.dart';
import 'package:news/provider/favourite_provider.dart';
import 'package:news/widgets/loading/favourite_loading.dart';
import 'package:provider/provider.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({super.key});

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  void initState() {
    super.initState();
    context.read<FavouriteProvider>().getFavouriteItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Favourite Page'),
        ),
        body: Consumer<FavouriteProvider>(
          builder: (_, provider, __) {
            List<SportModel> favoriteList = provider.listData;
            if (favoriteList.isEmpty) {
              return const FavouriteLoading();
            }
            return ListView.builder(
              itemCount: favoriteList.length,
              itemBuilder: (context, index) {
                SportModel sport = favoriteList[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.network(
                          sport.thumb,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.network(
                              'https://th.bing.com/th/id/OIP.8GWxDEp1bmhqwBL7Z1szTwHaHa?rs=1&pid=ImgDetMain',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        Text(
                          sport.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          sport.description,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                context
                                    .read<FavouriteProvider>()
                                    .removeFavoute(sport.id);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
