import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sanchar_dainek/features/home/presentation/controllers/categoryController.dart';
import 'package:sanchar_dainek/features/home/presentation/controllers/newsController.dart';
import 'package:sanchar_dainek/widgets/menuscreen.dart';

import '../../data/models/category.dart';
import '../../data/models/news.dart';
import '../widgets/news_list.dart';

class HomePage extends ConsumerWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

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

        if (news[i].categoryId == cid) {
          return NewsList(
            id: news[i].id,
            title: news[i].newsHeading,
            description: news[i].newsContent,
            image: news[i].photopath,
            date: news[i].newsDate,
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
    var mediaQuery = MediaQuery.of(context).size;

    return ref.watch(categoryControllerProvider).when(
          data: (categoryData) {
            return DefaultTabController(
              length: categoryData.length,
              child: Scaffold(
                drawer: const MenuScreen(),
                appBar: AppBar(
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
                    indicator: BoxDecoration(
                      color: const Color.fromRGBO(34, 45, 102, 1),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelPadding: const EdgeInsets.symmetric(
                        horizontal: 7.0, vertical: 5.0),
                    labelStyle: TextStyle(
                      fontSize: Platform.isAndroid ? 18 : 15,
                    ),
                    tabs: categoryData
                        .map(
                          (category) => title(category.name, context),
                        )
                        .toList(),
                  ),
                ),
                body: ref.watch(newsControllerProvider).when(
                      data: (newsData) {
                        final news = newsData;
                        final categories = categoryData;
                        return TabBarView(
                          children: categoryData
                              .map((category) => newsLists(
                                  context, category.name, news, categories))
                              .toList(),
                        );
                      },
                      error: (error, stackTrace) => Text(error.toString()),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
              ),
            );
          },
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
  }
}
