import 'package:flutter/material.dart';
import 'package:news_app/src/data/news_api/article_model.dart';
import 'package:news_app/src/presentation/provider/saved_article_provider.dart';
import 'package:news_app/src/presentation/views/widgets/article_view.dart';
import 'package:provider/provider.dart';

class NewsTile extends StatefulWidget {
  final String imgUrl, title, desc, content, posturl, author;
  final String publishedAt;
  const NewsTile(
      {Key? key,
      required this.imgUrl,
      required this.desc,
      required this.title,
      required this.content,
      required this.posturl,
      required this.author,
      required this.publishedAt})
      : super(key: key);

  @override
  State<NewsTile> createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {
  @override
  Widget build(BuildContext context) {
    final savedArticleProvider = Provider.of<SavedArticleProvider>(context);
    Article article = Article(
        title: widget.title,
        description: widget.desc,
        content: widget.content,
        urlToImage: widget.imgUrl,
        articleUrl: widget.posturl,
        author: widget.author,
        publishedAt: widget.publishedAt);
    return GestureDetector(
      onTap: () {
        savedArticleProvider.saveArticles(article);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      postUrl: widget.posturl,
                    )));
      },
      child: Container(
          margin: const EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(6),
                    bottomLeft: Radius.circular(6))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: Image.network(
                      widget.imgUrl,
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    )),
                const SizedBox(
                  height: 12,
                ),
                Text(
                  widget.title,
                  maxLines: 2,
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  widget.desc,
                  maxLines: 2,
                )
              ],
            ),
          )),
    );
  }
}
