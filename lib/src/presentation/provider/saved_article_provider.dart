import 'package:flutter/material.dart';
import 'package:news_app/src/data/news_api/article_model.dart';
import 'package:news_app/src/data/persistence/save_articles_preferences.dart';

class SavedArticleProvider with ChangeNotifier {
  SaveArticlePreference saveArticlePreference = SaveArticlePreference();
  List<Article> _savedArticles = [];
  void getArticles() async {
    _savedArticles = await saveArticlePreference.getSavedArticles();
    notifyListeners();
  }

  List<Article> get savedArticles {
    getArticles();
    return _savedArticles;
  }

  void saveArticles(Article value) {
    _savedArticles.add(value);
    saveArticlePreference.saveArticle(_savedArticles);
    notifyListeners();
  }
}
