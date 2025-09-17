import 'package:flutter/material.dart';

import '../../../../../data/models/dto_post.dart';

// 게시물 하나를 표시하는 카드 위젯
class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({required this.post, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. 게시물 썸네일 이미지
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.network(
              post.postImageUrl,
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              // 이미지 로딩 중 플레이스홀더
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[200],
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 2. 게시물 제목
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                // 3. 게시물 내용 (일부)
                Text(
                  post.content,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                // 4. 작성자 정보
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: NetworkImage(post.authorImageUrl),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      post.author,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const Spacer(),
                    // 5. 좋아요 및 댓글 수
                    Icon(
                      Icons.thumb_up_alt_outlined,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${post.likes}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    const SizedBox(width: 12),
                    Icon(
                      Icons.comment_outlined,
                      size: 14,
                      color: Colors.grey[600],
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '${post.comments}',
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
