import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:news_app/src/data/news_api/article_model.dart';
import 'package:news_app/src/presentation/provider/saved_article_provider.dart';
import 'package:news_app/src/presentation/views/widgets/article_view.dart';
import 'package:provider/provider.dart';

import '../../../data/persistence/save_articles_preferences.dart';

class NewsTile extends StatefulWidget {
  final String imgUrl, title, desc, content, posturl, author;
  final String publishedAt;
  final bool savedScrn;
  const NewsTile(
      {Key? key,
      required this.savedScrn,
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
    final savedArticleProvider =
        Provider.of<SavedArticleProvider>(context, listen: true);

    Article article = Article(
        title: widget.title,
        description: widget.desc,
        content: widget.content,
        urlToImage: widget.imgUrl,
        articleUrl: widget.posturl,
        author: widget.author,
        publishedAt: widget.publishedAt);
    return (!widget.savedScrn)
        ? Slidable(
            // Specify a key if the Slidable is dismissible.
            key: const ValueKey(0),

            // The start action pane is the one at the left or the top side.
            startActionPane: ActionPane(
              // A motion is a widget used to control how the pane animates.
              motion: const ScrollMotion(),

              // A pane can dismiss the Slidable.
              dismissible: DismissiblePane(onDismissed: () {
                savedArticleProvider.unsavedArticles(article);
              }),

              // All actions are defined in the children parameter.
              children: [
                // A SlidableAction can have an icon and/or a label.
                SlidableAction(
                  onPressed: (_) {
                    savedArticleProvider.unsavedArticles(article);
                  },
                  backgroundColor: const Color(0xFFFE4A49),
                  foregroundColor: Colors.white,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),

            // The end action pane is the one at the right or the bottom side.
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (_) {},
                  backgroundColor: const Color(0xFF21B7CA),
                  foregroundColor: Colors.white,
                  icon: Icons.share,
                  label: 'Share',
                ),
              ],
            ),

            child: GestureDetector(
              onTap: () {
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
                        Stack(children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(6),
                              child: Image.network(
                                widget.imgUrl,
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              )),
                          (widget.savedScrn)
                              ? Positioned(
                                  right: 10,
                                  top: 10,
                                  child: GestureDetector(
                                      onTap: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text("Saved"),
                                        ));
                                        savedArticleProvider
                                            .saveArticles(article);
                                      },
                                      child: const Icon(
                                        Icons.save,
                                      )))
                              : const SizedBox()
                        ]),
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
            ),
          )
        : GestureDetector(
            onTap: () {
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
                      Stack(children: [
                        ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: Image.network(
                              widget.imgUrl,
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            )),
                        (widget.savedScrn)
                            ? Positioned(
                                right: 10,
                                top: 10,
                                child: GestureDetector(
                                    onTap: () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Saved"),
                                      ));
                                      savedArticleProvider
                                          .saveArticles(article);
                                    },
                                    child: const Icon(
                                      Icons.save,
                                    )))
                            : const SizedBox()
                      ]),
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
