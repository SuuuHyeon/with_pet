import 'package:flutter/material.dart';

class MyPageTab extends StatelessWidget {
  const MyPageTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('내 정보'),
      ),
      body: const Center(
        child: Text('프로필 화면'),
      ),
    );
  }
}
