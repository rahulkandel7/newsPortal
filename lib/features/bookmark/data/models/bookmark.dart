const String table = "tbl_bookmark";

class BookmarkFileds {
  static final List<String> values = [
    id,
    title,
    description,
    categoryName,
    image,
    date,
    views
  ];

  static const String id = 'id';
  static const String title = 'title';
  static const String description = 'description';
  static const String categoryName = 'categoryName';
  static const String image = 'image';
  static const String date = 'date';
  static const String views = 'views';
}

class Bookmark {
  final int id;
  final String title;
  final String description;

  final String image;
  final String date;
  final int views;

  Bookmark({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.date,
    required this.views,
  });

  static Bookmark fromJson(Map<String, Object?> json) => Bookmark(
        id: json[BookmarkFileds.id] as int,
        title: json[BookmarkFileds.title] as String,
        description: json[BookmarkFileds.description] as String,
        image: json[BookmarkFileds.image] as String,
        date: json[BookmarkFileds.date] as String,
        views: json[BookmarkFileds.views] as int,
      );

  Map<String, dynamic> toJson() => {
        BookmarkFileds.id: id,
        BookmarkFileds.title: title,
        BookmarkFileds.description: description,
        BookmarkFileds.image: image,
        BookmarkFileds.date: date,
        BookmarkFileds.views: views,
      };

  Bookmark copy({
    int? id,
    String? title,
    String? description,
    String? categoryName,
    String? image,
    String? date,
    int? views,
  }) =>
      Bookmark(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        date: date ?? this.date,
        views: views ?? this.views,
      );
}