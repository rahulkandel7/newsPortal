class News {
  final int id;
  final String news_heading;
  final String news_content;
  final String photopath;
  final String news_date;
  final int category_id;
  final int views;

  News({
    required this.id,
    required this.news_heading,
    required this.news_content,
    required this.photopath,
    required this.news_date,
    required this.category_id,
    required this.views,
  });
}
