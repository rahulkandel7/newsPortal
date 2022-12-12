import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sanchar_dainek/features/home/presentation/screens/homepage.dart';

import '../../data/data_sources/bookmark_database.dart';
import '../../data/models/bookmark.dart';

class BookmarkShow extends StatefulWidget {
  final int id;
  const BookmarkShow({required this.id});

  @override
  State<BookmarkShow> createState() => _BookmarkShowState();
}

class _BookmarkShowState extends State<BookmarkShow> {
  late Bookmark bookmark;

  @override
  void initState() {
    super.initState();
    getBookmark();
  }

  Future getBookmark() async {
    bookmark = await BookmarkDatabase.instance.readBookmark(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return FutureBuilder(
      future: getBookmark(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              title: Text(bookmark.title),
              elevation: 0,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 300,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://sanchardainik.com/images/news/${bookmark.image}',
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Center(
                          child: Image.asset('assets/images/thumbnail.jpg'),
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
                      bookmark.title,
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
                        Row(
                          children: [
                            const Icon(
                              Icons.date_range,
                              size: 18,
                              color: Colors.red,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                bookmark.date,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.red),
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () async {
                                await BookmarkDatabase.instance
                                    .delete(bookmark.id)
                                    .then(
                                  (value) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Sucessfully Removed From Bookmark',
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
                                    Navigator.of(context).pushReplacementNamed(
                                        HomePage.routeName);
                                  },
                                ).onError((error, stackTrace) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text(
                                        'Error while unbookmrking',
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
                                      width: double.infinity,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  );
                                });
                              },
                              icon: const Icon(
                                Icons.bookmark,
                                color: Colors.red,
                              ),
                            ),
                          ],
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
                      bookmark.description,
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
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
