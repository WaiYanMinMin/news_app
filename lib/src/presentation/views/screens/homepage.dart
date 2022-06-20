import 'package:flutter/material.dart';
import 'package:news_app/src/data/news_api/article_model.dart';

import 'package:news_app/src/presentation/views/screens/saved_news_screen.dart';
import 'package:news_app/src/presentation/views/widgets/news_tile.dart';
import 'package:provider/provider.dart';

import '../../../data/news_api/news_api_service.dart';
import '../../provider/dark_theme_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _loading = true;
  List<Article>? newslist;

  void getNews() async {
    News news = News();
    await news.getNews();
    newslist = news.news;

    setState(() {
      _loading = false;
    });
  }

  @override
  void initState() {
    _loading = true;

    super.initState();

    getNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.red,
          elevation: 0,
          centerTitle: true,
          title: const Text('News')),
      drawer: const DrawerBody(),
      body: _loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.only(top: 16),
              child: ListView.builder(
                  itemCount: newslist?.length ?? 0,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return NewsTile( 
                      imgUrl: newslist?[index].urlToImage ?? "",
                      title: newslist?[index].title ?? "",
                      desc: newslist?[index].description ?? "",
                      content: newslist?[index].content ?? "",
                      posturl: newslist?[index].articleUrl ?? "",
                     
                    );
                  }),
            ),
    );
  }
}

class DrawerBody extends StatefulWidget {
  const DrawerBody({Key? key}) : super(key: key);

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  @override
  Widget build(BuildContext context) {
    final themeChange = Provider.of<DarkThemeProvider>(context);
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 100,
            color: Colors.red,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(
                MaterialPageRoute(builder: ((context) =>const  SavedNewsScreen()))),
            child:const ListTile(
              title: Text("Saved"),
            ),
          ),
          GestureDetector(
            onTap: () => {},
            child: ListTile(
              trailing: Checkbox(
                  value: themeChange.darkTheme,
                  onChanged: (value) {
                    themeChange.darkTheme = value ?? false;
                  }),
              title: const Text("Dark Mode"),
            ),
          ),
        ],
      ),
    );
  }
}
