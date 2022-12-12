// ignore_for_file: public_member_api_docs, sort_constructors_first

class News {
  final int id;
  final String newsHeading;
  final String newsContent;
  final String photopath;
  final String newsDate;
  final int categoryId;
  final int views;

  News({
    required this.id,
    required this.newsContent,
    required this.newsDate,
    required this.photopath,
    required this.newsHeading,
    required this.categoryId,
    required this.views,
  });

  factory News.fromMap(Map<String, dynamic> map) {
    return News(
      id: map['id'] as int,
      newsHeading: map['news_heading'] as String,
      newsContent: map['news_content'] as String,
      photopath: map['photopath'] as String,
      newsDate: map['news_date'] as String,
      categoryId: int.parse(map['category_id']),
      views: int.parse(map['views']),
    );
  }
}
