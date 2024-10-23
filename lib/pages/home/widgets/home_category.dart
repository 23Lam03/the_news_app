import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:news/models/sport_model.dart';
import 'package:news/pages/detail/detail_page.dart';
import 'package:news/pages/news/news_page.dart';
import 'package:news/provider/favourite_provider.dart';
import 'package:news/provider/setting_provider.dart';
import 'package:news/provider/sport_provider.dart';
import 'package:news/provider/viewed_provider.dart';
import 'package:provider/provider.dart';

class HomeCategory extends StatefulWidget {
  const HomeCategory({super.key, required this.idCategory});

  final int idCategory;

  @override
  State<HomeCategory> createState() => _HomeCategoryState();
}

class _HomeCategoryState extends State<HomeCategory> {
  @override
  void initState() {
    super.initState();
    context.read<ViewedProvider>().getViewedItem();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Consumer<SettingsProvider>(
                builder: (_, provider, ___) {
                  return Text(
                    provider.getName(widget.idCategory),
                    style: theme.textTheme.displayLarge,
                  );
                },
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          NewsPage(idCategory: widget.idCategory),
                    ),
                  );
                },
                child: Text(
                  'view all',
                  style: theme.textTheme.bodyMedium!.copyWith(
                    color: theme.colorScheme.secondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        FutureBuilder(
          future:
              context.read<SportProvider>().fetchSport(id: widget.idCategory),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 4,
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
              itemBuilder: (context, index) {
                SportModel sports = (snapshot.data as List<SportModel>)[index];
                final sport = snapshot.data![index];
                final favouriteProvider = context.read<FavouriteProvider>();
                final viewedProvider = context.read<ViewedProvider>();
                return Stack(
                  children: [
                    IntrinsicHeight(
                      child: InkWell(
                        onTap: () async {
                          viewedProvider.listViewed.contains(sport.id);
                          await viewedProvider.addViewed(sport.id);
                          context.read<ViewedProvider>().smbmitForm();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                sports: sports,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Image.network(
                                sports.thumb,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.network(
                                    'https://th.bing.com/th/id/OIP.8GWxDEp1bmhqwBL7Z1szTwHaHa?rs=1&pid=ImgDetMain',
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 3,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sports.title,
                                    style: theme.textTheme.displayMedium,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 10),
                                  Expanded(
                                    child: Text(
                                      sports.description,
                                      style: theme.textTheme.bodyMedium,
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 25),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Consumer<FavouriteProvider>(
                          builder: (_, provider, __) {
                            return LikeButton(
                              isLiked:
                                  provider.listFavourite.contains(sport.id),
                              onTap: (isLiked) async {
                                provider.addFavourite(sport.id);
                                // viewedProvider.addViewed(sport.id);
                                provider.sumbmitForm();
                                return isLiked;
                              },
                            );
                          },
                        ))
                  ],
                );
              },
            );
          },
        ),
      ],
    );
  }
}
