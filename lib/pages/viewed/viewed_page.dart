import 'package:flutter/material.dart';
import 'package:news/models/sport_model.dart';
import 'package:news/provider/viewed_provider.dart';
import 'package:news/widgets/loading/viewed_loading.dart';
import 'package:provider/provider.dart';

class ViewedPage extends StatefulWidget {
  const ViewedPage({super.key});

  @override
  State<ViewedPage> createState() => _ViewedPageState();
}

class _ViewedPageState extends State<ViewedPage> {
  @override
  void initState() {
    super.initState();
    context.read<ViewedProvider>().getViewedItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Viewed Page'),
        ),
        body: Consumer<ViewedProvider>(
          builder: (_, provider, __) {
            List<SportModel> viewedList = provider.listData;
            if (viewedList.isEmpty) {
              return const ViewedLoading();
            }
            return ListView.builder(
              itemCount: viewedList.length,
              itemBuilder: (context, index) {
                SportModel sport = viewedList[index];
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
                                    .read<ViewedProvider>()
                                    .removeViewed(sport.id);
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
