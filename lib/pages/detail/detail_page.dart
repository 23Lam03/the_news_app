import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:news/models/sport_model.dart';
import 'package:news/provider/favourite_provider.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key, required this.sports});

  final SportModel sports;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    if (widget.sports.link != '#') {
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(widget.sports.link));
    }
  }

  @override
  Widget build(BuildContext context) {
    final favouriteProvider = context.read<FavouriteProvider>();

    if (widget.sports.link == '#') {
      return Scaffold(
        appBar: AppBar(
          title: const Text('News Detail'),
        ),
        body: const Center(
          child: Text('No data available'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('News Detail'),
        actions: [
          LikeButton(
            isLiked: favouriteProvider.listFavourite.contains(widget.sports.id),
            onTap: (isLiked) async {
              favouriteProvider.addFavourite(widget.sports.id);

              return !isLiked;
            },
          ),
        ],
      ),
      body: WebViewWidget(controller: controller),
    );
  }
}
