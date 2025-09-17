import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../data/repositories/pet_repository.dart';

class PetListScreen extends ConsumerWidget {
  const PetListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // petListProvider의 상태가 변경되면 자동으로 리빌드됩니다.
    final petListState = ref.watch(petListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('내 반려동물')),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // 등록 페이지로 이동했다가 돌아오면, 목록을 새로고침합니다.
          await context.push('/pet-registration');
          ref.invalidate(petListProvider);
        },
        child: const Icon(Icons.add),
      ),
      body: petListState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('오류가 발생했습니다: $err')),
        data: (pets) {
          if (pets.isEmpty) {
            // 등록된 펫이 없을 때의 UI
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('아직 등록된 반려동물이 없어요.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      await context.push('/pet-registration');
                      ref.invalidate(petListProvider);
                    },
                    child: const Text('내 첫 반려동물 등록하기'),
                  ),
                ],
              ),
            );
          }
          // 등록된 펫이 있을 때의 UI
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: pets.length,
            itemBuilder: (context, index) {
              final pet = pets[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(pet.imageUrl),
                  ),
                  title: Text(
                    pet.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(pet.breed),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    // TODO: 펫 상세 정보 수정 페이지로 이동
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
