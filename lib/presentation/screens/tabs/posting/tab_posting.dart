import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:withpet/core/theme/colors.dart';
import 'package:withpet/presentation/screens/tabs/posting/widgets/w_post_item.dart';

import '../../../../data/models/dto_post.dart';
import '../../../viewmodels/posting_view_model.dart';

class PostingTab extends ConsumerWidget {
  const PostingTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postsAsyncValue = ref.watch(postFeedViewModelProvider);
    final categories = ['전체', '건강', '산책', '간식', '꿀팁', '병원후기'];

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.appBackground,
        title: const Text('정보 공유'),
        // AppBar의 그림자를 제거하여 깔끔한 느낌을 줍니다.
        elevation: 0,
      ),
      body: Column(
        children: [
          // 1. 카테고리 선택 UI
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SizedBox(
              height: 40,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.normal,
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
              loading:
                  () => const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.primary,
                      ),
                    ),
                  ),
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
                    return PostItem(post: post);
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
