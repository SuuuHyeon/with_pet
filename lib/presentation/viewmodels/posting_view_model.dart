import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/dto_post.dart';

// 화면의 상태를 관리하는 Notifier입니다. (비동기 데이터 처리)
class PostFeedViewModel extends AsyncNotifier<List<Post>> {
  // 모든 더미 데이터를 저장하는 리스트
  List<Post> _allPosts = [];
  // 현재 선택된 카테고리
  String _selectedCategory = '전체';

  // Notifier가 처음 생성될 때 호출되는 초기화 메서드입니다.
  @override
  FutureOr<List<Post>> build() async {
    // 실제 앱에서는 여기서 서버로부터 데이터를 가져옵니다. (예: Firebase)
    // 지금은 더미 데이터를 생성하여 초기화합니다.
    _loadDummyData();
    return _getFilteredPosts();
  }

  // 카테고리를 변경하는 메서드
  void setCategory(String category) {
    // 상태를 로딩 중으로 변경하고, 선택된 카테고리를 업데이트합니다.
    state = const AsyncValue.loading();
    _selectedCategory = category;

    // 잠시 후 필터링된 게시물 목록으로 상태를 업데이트합니다.
    Timer(const Duration(milliseconds: 300), () {
      state = AsyncValue.data(_getFilteredPosts());
    });
  }

  // 현재 선택된 카테고리에 맞는 게시물 목록을 반환합니다.
  List<Post> _getFilteredPosts() {
    if (_selectedCategory == '전체') {
      return _allPosts;
    }
    return _allPosts.where((post) => post.category == _selectedCategory).toList();
  }

  // 더미 데이터 생성 로직
  void _loadDummyData() {
    _allPosts = List.generate(20, (index) {
      final category = ['건강', '산책', '간식', '꿀팁'][index % 4];
      return Post(
        id: 'post_$index',
        category: category,
        title: '$category 정보 공유 #${index + 1}',
        content: '여기는 $category 관련 게시물의 내용이 들어가는 자리입니다. 유용한 정보를 공유해보세요!',
        author: '유저${index % 5 + 1}',
        authorImageUrl: 'https://i.pravatar.cc/150?u=user$index',
        postImageUrl: 'https://picsum.photos/seed/post$index/400/300',
        likes: (index * 5) % 30 + 3,
        comments: (index * 2) % 15 + 1,
        createdAt: DateTime.now().subtract(Duration(days: index)),
      );
    });
  }
}

// 위 ViewModel을 앱 전역에서 사용할 수 있도록 Provider를 생성합니다.
final postFeedViewModelProvider =
AsyncNotifierProvider<PostFeedViewModel, List<Post>>(
      () => PostFeedViewModel(),
);

// 선택된 카테고리를 관리하는 간단한 Provider
final selectedCategoryProvider = StateProvider<String>((ref) => '전체');
