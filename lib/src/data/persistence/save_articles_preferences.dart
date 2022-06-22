import 'package:news_app/src/data/news_api/article_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveArticlePreference {
  List<Article> articles = [];
  saveArticle(List<Article> value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("savedArticle", Article.encode(value));
  }

  Future<List<Article>> getSavedArticles() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String data = prefs.getString("savedArticle") ?? "";

    if (data != "") {
      articles = Article.decode(data);
    }

    return articles;
  }
}
