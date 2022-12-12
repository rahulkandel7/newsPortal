import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sanchar_dainek/features/bookmark/data/data_sources/bookmark_database.dart';
import 'package:sanchar_dainek/features/bookmark/data/models/bookmark.dart';

import '../widgets/bookmark_list.dart';

class BookmarkScreen extends StatelessWidget {
  static const routeName = '/bookmark';

  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bookmark'),
          elevation: 0,
        ),
        body: ValueListenableBuilder<Box<Bookmark>>(
            valueListenable: BookmarkDataSource.getBookmark().listenable(),
            builder: ((context, box, _) {
              final bookmarks = box.values.toList().cast<Bookmark>();
              return bookmarks.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (ctx, i) {
                        return BookmarkList(
                          id: bookmarks[i].id,
                          title: bookmarks[i].title,
                          description: bookmarks[i].description,
                          image: bookmarks[i].image,
                        );
                      },
                      itemCount: bookmarks.length,
                    )
                  : const Center(
                      child: Text('No News in Bookmark'),
                    );
            })));
  }
}
