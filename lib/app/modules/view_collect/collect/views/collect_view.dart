import 'package:flutter/material.dart';
import 'package:g_music/app/components/components.dart';
import 'package:g_music/app/components/g_avatar.dart';
import 'package:get/get.dart';

import '../../../../config/g_color.dart';
import '../controllers/collect_controller.dart';

class CollectView extends GetView<CollectController> {
  const CollectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final c = controller;
    return Scaffold(
      appBar: GAppBar(leadingText: '收藏'),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 24,
          childAspectRatio: 0.725,
        ),
        itemBuilder: (_, idx) {
          return GestureDetector(
            onTap: c.toPage,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: GColor.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: GColor.primary.withOpacity(0.06),
                    blurRadius: 60,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const GAvatar(radius: 4, size: 131),
                  const SizedBox(height: 16),
                  Text(
                    'Your playlist',
                    style: TextStyle(fontSize: 14, color: GColor.secondary900),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '20 Artist',
                    style: TextStyle(fontSize: 12, color: GColor.secondary0),
                  )
                ],
              ),
            ),
          );
        },
        itemCount: 12,
      ),
    );
  }
}
