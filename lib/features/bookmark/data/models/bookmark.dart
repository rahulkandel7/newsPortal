import 'package:hive/hive.dart';

part 'bookmark.g.dart';

@HiveType(typeId: 0)
class Bookmark extends HiveObject {
  @HiveField(0)
  late int id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String description;

  @HiveField(3)
  late String image;

  @HiveField(4)
  late String date;

  @HiveField(5)
  late String categoryName;

  @HiveField(6)
  late int views;
}
