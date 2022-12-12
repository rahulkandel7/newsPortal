import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanchar_dainek/models/category.dart';
import 'package:sanchar_dainek/models/news.dart';

import '../controllers/NewsController.dart';
import '../widgets/news_list.dart';
import '../controllers/CategoryController.dart';

class HomePage extends ConsumerWidget {
  static const routeName = '/home';

  final zoomDrawerController;
  HomePage(this.zoomDrawerController);

  Widget title(String text, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      child: Text(
        text,
      ),
    );
  }

  Widget newsLists(BuildContext context, String catName, List<News> news,
      List<Category> category) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (ctx, i) {
        int cid = category.firstWhere((element) => element.name == catName).id;

        if (news[i].category_id == cid) {
          return NewsList(
            id: news[i].id,
            title: news[i].news_heading,
            description: news[i].news_content,
            image: news[i].photopath,
            date: news[i].news_date,
            views: news[i].views,
          );
        } else {
          return const SizedBox();
        }
      },
      itemCount: news.length,
    );
  }

  @override
  Widget build(BuildContext context, ref) {
    ref.watch(newsProvider.notifier).fetchNews();
    ref.watch(categoryProvider.notifier).fetchCategory();
    var mediaQuery = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 8,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              zoomDrawerController.toggle();
            },
            icon: Icon(
              Platform.isAndroid ? Icons.menu : CupertinoIcons.bars,
              size: 28,
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: SizedBox(
              width: mediaQuery.width * 0.2,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          centerTitle: true,
          elevation: 0,
          bottom: TabBar(
            isScrollable: true,
            enableFeedback: true,
            automaticIndicatorColorAdjustment: true,
            indicatorSize: TabBarIndicatorSize.label,
            physics: const BouncingScrollPhysics(),
            // overlayColor: MaterialStateProperty.all<Color>(Colors.red),
            indicator: BoxDecoration(
              color: const Color.fromRGBO(34, 45, 102, 1),
              borderRadius: BorderRadius.circular(5),
            ),

            labelPadding:
                const EdgeInsets.symmetric(horizontal: 7.0, vertical: 5.0),
            labelStyle: TextStyle(
              fontSize: Platform.isAndroid ? 18 : 15,
            ),
            tabs: [
              title('राष्ट्रिय', context),
              title('राजनिती', context),
              title('अर्थ-राेजगार', context),
              title('अन्तराष्ट्रिय', context),
              title('सुचना-प्रविधि', context),
              title('खेलकुद', context),
              title('मनाेरञ्जन', context),
              title('लेख', context),
            ],
          ),
        ),
        body: FutureBuilder(
          future: ref.watch(newsProvider.notifier).fetchNews(),
          builder: (context, snapshot) {
            final news = ref.read(newsProvider);
            final category = ref.read(categoryProvider);
            if (snapshot.connectionState == ConnectionState.done) {
              return TabBarView(
                children: [
                  newsLists(context, 'राष्ट्रिय', news, category),
                  newsLists(context, 'राजनिती', news, category),
                  newsLists(context, 'अर्थ-राेजगार', news, category),
                  newsLists(context, 'अन्तराष्ट्रिय', news, category),
                  newsLists(context, 'सुचना-प्रविधि', news, category),
                  newsLists(context, 'खेलकुद', news, category),
                  newsLists(context, 'मनाेरञ्जन', news, category),
                  newsLists(context, 'लेख', news, category),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
