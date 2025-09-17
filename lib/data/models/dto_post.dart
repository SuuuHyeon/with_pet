// 게시물 하나를 나타내는 데이터 클래스입니다.
class Post {
  final String id;
  final String category;
  final String title;
  final String content;
  final String author;
  final String authorImageUrl;
  final String postImageUrl;
  final int likes;
  final int comments;
  final DateTime createdAt;

  Post({
    required this.id,
    required this.category,
    required this.title,
    required this.content,
    required this.author,
    required this.authorImageUrl,
    required this.postImageUrl,
    required this.likes,
    required this.comments,
    required this.createdAt,
  });
}
