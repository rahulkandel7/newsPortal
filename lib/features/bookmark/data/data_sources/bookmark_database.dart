import 'package:hive/hive.dart';
import 'package:sanchar_dainek/features/bookmark/data/models/bookmark.dart';

class BookmarkDataSource {
  static Box<Bookmark> getBookmark() => Hive.box<Bookmark>('bookmarks');
}
