import 'package:flutter/material.dart';

import '../screens/bookmark_show.dart';

class BookmarkList extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final String description;

  const BookmarkList({
    Key? key,
    required this.id,
    required this.title,
    required this.image,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: mediaQuery.height * 0.03,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => BookmarkShow(id: id),
            ),
          );
        },
        child: ListTile(
          leading: Image.asset('assets/images/thumbnail.jpg'),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).textTheme.headline1!.color,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              description,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1!.color,
                fontSize: 16,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
