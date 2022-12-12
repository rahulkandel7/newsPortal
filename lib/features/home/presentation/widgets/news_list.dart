import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../screens/news_show.dart';

class NewsList extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final String image;
  final String date;
  final int views;

  const NewsList({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
    required this.views,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 3.0,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(NewsShow.routeName, arguments: id);
        },
        child: Card(
          elevation: 10,
          // shadowColor: Colors.grey.shade200,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 180,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: 'https://samacharsadhai.com/images/news/$image',
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Center(
                      child: SizedBox(
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/thumbnail.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
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
                            color: Colors.red,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              date,
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: SizedBox(
                        child: Row(
                          children: [
                            Icon(
                              Platform.isAndroid
                                  ? Icons.remove_red_eye
                                  : CupertinoIcons.eye,
                              size: 18,
                              color: Colors.red,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                '$views',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4.0,
                ),
                child: Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
