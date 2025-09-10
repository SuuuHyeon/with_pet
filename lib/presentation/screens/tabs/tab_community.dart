import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:withpet/core/theme/colors.dart';

import '../../../data/models/dto_post.dart';
import '../../viewmodels/post_view_model.dart';

class CommunityTab extends ConsumerWidget {
  const CommunityTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ViewModel Provider를 watch하여 게시물 데이터의 상태를 가져옵니다.
    final postsAsyncValue = ref.watch(postFeedViewModelProvider);
    final categories = ['전체', '건강', '산책', '간식', '꿀팁', '병원후기'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appBackground,
        title: const Text('정보 공유'),
        // AppBar의 그림자를 제거하여 깔끔한 느낌을 줍니다.
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1. 카테고리 선택 UI
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 16.0,
            ),
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  // 현재 선택된 카테고리를 watch합니다.
                  final selectedCategory = ref.watch(selectedCategoryProvider);
                  final isSelected = category == selectedCategory;

                  return ChoiceChip(
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                    label: Text(category),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        // 칩을 선택하면 ViewModel의 메서드를 호출하여 카테고리를 변경합니다.
                        ref.read(selectedCategoryProvider.notifier).state =
                            category;
                        ref
                            .read(postFeedViewModelProvider.notifier)
                            .setCategory(category);
                      }
                    },
                    selectedColor: AppColors.primary,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    side: BorderSide(
                      color:
                          isSelected
                              ? Colors.transparent
                              : Colors.grey.shade300,
                    ),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(width: 8),
              ),
            ),
          ),

          // 2. 게시물 목록 UI
          Expanded(
            // AsyncValue를 사용하여 로딩, 데이터, 에러 상태에 따라 다른 UI를 보여줍니다.
            child: postsAsyncValue.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
              data: (posts) {
                if (posts.isEmpty) {
                  return const Center(child: Text('아직 게시물이 없어요.'));
                }
                // 게시물 목록을 ListView.builder로 효율적으로 렌더링합니다.
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    final post = posts[index];
                    return _PostCard(post: post);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// 게시물 하나를 표시하는 카드 위젯
class _PostCard extends StatelessWidget {
  final Post post; // 타입을 명확히 Post로 지정
  const _PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
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
