import 'package:flutter/material.dart';
import 'package:news_app/src/presentation/provider/dark_theme_provider.dart';
import 'package:news_app/src/presentation/provider/saved_article_provider.dart';
import 'package:news_app/src/presentation/views/screens/homepage.dart';
import 'package:news_app/src/presentation/widgets/styles.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your appl ication.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<DarkThemeProvider>(
            create: (context) => DarkThemeProvider(),
          ),
          ChangeNotifierProvider<SavedArticleProvider>(
            create: (context) => SavedArticleProvider(),
          ),
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: Styles.themeData(
                Provider.of<DarkThemeProvider>(context, listen: true).darkTheme,
                context),
            home: const HomePage(),
          );
        });
  }
}
