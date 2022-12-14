import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanchar_dainek/constants/app_constants.dart';
import 'package:sanchar_dainek/features/bookmark/data/data_sources/bookmark_database.dart';
import 'package:sanchar_dainek/features/home/presentation/controllers/categoryController.dart';
import 'package:sanchar_dainek/features/home/presentation/controllers/newsController.dart';

import 'package:share_plus/share_plus.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../../bookmark/data/models/bookmark.dart';

class NewsShow extends ConsumerStatefulWidget {
  static const routeName = '/news-show';

  const NewsShow({Key? key}) : super(key: key);

  @override
  _NewsShowState createState() => _NewsShowState();
}

class _NewsShowState extends ConsumerState<NewsShow> {
  final _flutterTts = FlutterTts();
  bool isPlaying = false;

  void initializeTts() {
    _flutterTts.setStartHandler(() {
      setState(() {
        isPlaying = true;
      });
    });
    _flutterTts.setCompletionHandler(() {
      setState(() {
        isPlaying = false;
      });
    });
    _flutterTts.setErrorHandler((message) {
      isPlaying = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initializeTts();
  }

  void speak(String msg) async {
    await _flutterTts.setLanguage("ne-NP");
    await _flutterTts.speak(msg);
  }

  void stop() async {
    await _flutterTts.stop();
    setState(() {
      isPlaying = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    final id = ModalRoute.of(context)?.settings.arguments as int;
    final news = ref.read(newsControllerProvider.notifier).findNews(id);
    final category = ref
        .read(categoryControllerProvider.notifier)
        .findCategory(news.categoryId);

    final bookmark = BookmarkDataSource.getBookmark().get(news.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          news.newsHeading,
        ),
        elevation: 0,
        actions: [
          Platform.isAndroid
              ? IconButton(
                  onPressed: () {
                    isPlaying ? stop() : speak(news.newsContent);
                  },
                  icon: Icon(
                    isPlaying ? Icons.stop : Icons.play_circle_fill,
                  ),
                )
              : const SizedBox(),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(3),
                  bottomRight: Radius.circular(3),
                ),
                child: CachedNetworkImage(
                  imageUrl: '${AppConstant.imageUrl}${news.photopath}',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: Image.asset('assets/images/logo.jpeg'),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * 0.04,
                vertical: mediaQuery.height * 0.02,
              ),
              child: Text(
                news.newsHeading,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * 0.04,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    child: Row(
                      children: [
                        Icon(
                          Platform.isAndroid
                              ? Icons.date_range
                              : CupertinoIcons.time,
                          size: 18,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            news.newsDate,
                            style: Theme.of(context).textTheme.headline5,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Consumer(
                    builder: (context, ref, child) {
                      return Row(
                        children: [
                          IconButton(
                            onPressed: () async {
                              final bookmark = Bookmark()
                                ..id = news.id
                                ..categoryName = category.name
                                ..date = news.newsDate
                                ..description = news.newsContent
                                ..image = news.photopath
                                ..title = news.newsHeading
                                ..views = news.views;
                              final box = BookmarkDataSource.getBookmark();
                              box.put(news.id, bookmark).then(
                                (value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Added To Bookmark',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                        ),
                                      ),
                                      backgroundColor: Color.fromRGBO(
                                        34,
                                        45,
                                        102,
                                        1,
                                      ),
                                      width: double.infinity,
                                      duration: Duration(
                                        seconds: 5,
                                      ),
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  setState(() {});
                                },
                              ).onError((error, stackTrace) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text(
                                      'Already Added To Bookmark',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                    ),
                                    backgroundColor: const Color.fromRGBO(
                                      34,
                                      45,
                                      102,
                                      1,
                                    ),
                                    duration: const Duration(
                                      seconds: 5,
                                    ),
                                    behavior: SnackBarBehavior.floating,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                );
                              });
                            },
                            icon: Icon(
                              Platform.isAndroid
                                  ? bookmark != null
                                      ? Icons.bookmark
                                      : Icons.bookmark_add_outlined
                                  : bookmark != null
                                      ? CupertinoIcons.bookmark_fill
                                      : CupertinoIcons.bookmark,
                              color:
                                  bookmark != null ? Colors.red : Colors.black,
                            ),
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                30,
                              ),
                              color: Colors.red,
                            ),
                            child: IconButton(
                              onPressed: () {
                                Share.share(
                                  "https://www.sanchardainik.com/news/${news.id}/${news.categoryId}#readnews",
                                );
                              },
                              icon: const Icon(
                                Icons.share,
                                color: Colors.white,
                                size: 22,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: mediaQuery.width * 0.04,
                vertical: mediaQuery.height * 0.02,
              ),
              child: Text(
                news.newsContent,
                textAlign: TextAlign.justify,
                style: Theme.of(context).textTheme.headline2,
              ),
            ),
            Container(
              width: double.infinity,
              height: 40,
              color: Colors.red.shade100,
              child: Center(
                child: Text(
                  'Here Will Be ADS',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
