import 'package:flutter/material.dart';
import 'package:news_app/src/data/news_api/article_model.dart';
import 'package:news_app/src/presentation/views/widgets/news_tile.dart';
import 'package:provider/provider.dart';

import '../../../data/persistence/save_articles_preferences.dart';
import '../../provider/saved_article_provider.dart';

class SavedNewsScreen extends StatefulWidget {
  const SavedNewsScreen({Key? key}) : super(key: key);

  @override
  State<SavedNewsScreen> createState() => _SavedNewsScreenState();
}

class _SavedNewsScreenState extends State<SavedNewsScreen> {
  List<Article> newslist = [];
  SaveArticlePreference saveArticlePreference = SaveArticlePreference();
  bool flag = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final savedArticleProvider =
        Provider.of<SavedArticleProvider>(context, listen: true);

    newslist = savedArticleProvider.savedArticles;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
          centerTitle: true,
          title: const Text('Saved Articles')),
      body: Container(
        margin: const EdgeInsets.only(top: 16),
        child: ListView.builder(
            itemCount: newslist.length,
            shrinkWrap: true,
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return NewsTile(
                imgUrl: newslist[index].urlToImage ?? "",
                title: newslist[index].title ?? "",
                desc: newslist[index].description ?? "",
                content: newslist[index].content ?? "",
                posturl: newslist[index].articleUrl ?? "",
                author: newslist[index].author ?? "unknown",
                publishedAt: newslist[index].publishedAt ?? "",
              );
            }),
      ),
    );
  }
}
