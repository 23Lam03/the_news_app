import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:like_button/like_button.dart';
import 'package:news/models/category_model.dart';
import 'package:news/models/sport_model.dart';
import 'package:news/pages/detail/detail_page.dart';
import 'package:news/provider/favourite_provider.dart';
import 'package:news/provider/setting_provider.dart';
import 'package:news/provider/sport_provider.dart';
import 'package:news/provider/viewed_provider.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  final int idCategory;

  const NewsPage({super.key, required this.idCategory});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<CategoryModel>> categoriesFuture;

  @override
  void initState() {
    super.initState();
    categoriesFuture = context.read<SettingsProvider>().getCategories();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: Consumer<SettingsProvider>(
          builder: (context, provider, child) {
            String categoryName = provider.getName(widget.idCategory);
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 17),
              child: Text(
                categoryName,
                style: theme.appBarTheme.titleTextStyle,
              ),
            );
          },
        ),
      ),
      body: Stack(
        children: [
          FutureBuilder<List<SportModel>>(
            future:
                context.read<SportProvider>().fetchSport(id: widget.idCategory),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }

              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final sport = snapshot.data![index];
                  final favouriteProvider = context.read<FavouriteProvider>();
                  final viewedProvider = context.read<ViewedProvider>();
                  return Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: InkWell(
                        onTap: () async {
                          viewedProvider.listViewed.contains(sport.id);
                          await viewedProvider.addViewed(sport.id);
                          context.read<ViewedProvider>().smbmitForm();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailPage(
                                sports: sport,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              sport.thumb,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const SizedBox(
                                  height: 150,
                                  child: Center(
                                    child: Icon(Icons.broken_image, size: 40),
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            Text(
                              sport.title,
                              style: theme.textTheme.displayMedium,
                            ),
                            const SizedBox(height: 5),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    sport.description,
                                    style: theme.textTheme.bodyLarge,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                LikeButton(
                                  isLiked: favouriteProvider.listFavourite
                                      .contains(sport.id),
                                  onTap: (isLiked) async {
                                    favouriteProvider.addFavourite(sport.id);
                                    context
                                        .read<FavouriteProvider>()
                                        .sumbmitForm();
                                    return !isLiked;
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: InkWell(
              onTap: () {
                context.read<FavouriteProvider>().sumbmitForm();
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                child: Text(
                  'Back To Home',
                  style: GoogleFonts.actor(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: const Color(0xffFFFFFF),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
