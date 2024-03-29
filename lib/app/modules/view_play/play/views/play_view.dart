import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:g_music/app/components/g_avatar.dart';
import 'package:g_music/app/components/g_circular_bg_button.dart';
import 'package:g_music/app/config/g_color.dart';
import 'package:get/get.dart';

import '../../../../config/g_iconfont.dart';
import '../controllers/play_controller.dart';

class PlayView extends GetView<PlayController> {
  PlayView({Key? key}) : super(key: key);

  final c = Get.find<PlayController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: const Padding(
          padding: EdgeInsets.all(12),
          child: GCircularBgButton(),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(12),
            child: GCircularBgButton(
              icon: GIconFont.iconArchive1,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              'https://img1.baidu.com/it/u=2362149191,780203095&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 86,
            child: _buildMusicPlayCard(),
          ),
          Obx(() {
            return AnimatedPositioned(
              left: 12,
              right: 12,
              bottom: c.tHeight.value,
              duration: const Duration(milliseconds: 250),
              curve: Curves.ease,
              child: GestureDetector(
                // onVerticalDragUpdate: (d) => c.upTracks(d),
                onVerticalDragEnd: (d) => c.end(d),
                onVerticalDragStart: (d) => c.start(d),
                // onVerticalDragDown: (d) => c.downTracks(d),
                child: Container(
                  height: Get.height / 1.9,
                  decoration: BoxDecoration(
                    color: GColor.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Center(
                          child: Container(
                            width: 60,
                            height: 4,
                            decoration: const BoxDecoration(
                              color: Color(0xFFC6C6C6),
                              borderRadius: BorderRadius.all(
                                Radius.circular(9),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Suggested Tracks',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: MediaQuery.removePadding(
                          context: context,
                          removeTop: true,
                          child: ListView.builder(
                            itemBuilder: (_, idx) => Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 8,
                              ),
                              child: Row(
                                children: [
                                  GAvatar(size: 56, radius: 4),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: SizedBox(
                                      height: 56,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Text(
                                            '${idx}//Don’t Start Now',
                                            style: TextStyle(fontSize: 14),
                                          ),
                                          Text(
                                            'Dua Lipa',
                                            style: TextStyle(
                                              fontSize: 12,
                                              color: GColor.secondary0,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Icon(CupertinoIcons.ellipsis)
                                ],
                              ),
                            ),
                            itemCount: 20,
                            // shrinkWrap: true,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  Widget _buildMusicPlayCard() {
    return SizedBox(
      width: Get.width,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                'Lyrics',
                style: TextStyle(fontSize: 14, color: GColor.white),
              ),
              Obx(() {
                return Switch(
                  value: c.isOpenLyrics.value,
                  onChanged: (v) => c.openLyrics(v),
                  inactiveTrackColor: const Color(0xFFD8D8D8),
                  inactiveThumbColor: Colors.white54,
                  activeTrackColor: const Color(0xFF2270F6).withOpacity(0.8),
                  activeColor: const Color(0xFF2270F6),
                );
              })
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              color: Colors.white30,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 34, sigmaY: 34),
                child: DefaultTextStyle(
                  style: TextStyle(color: GColor.white),
                  child: Obx(
                    () {
                      return Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Blinding Lights',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'The Weeknd',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.white70,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: c.addPlayList,
                                child: const Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 16),
                              const Icon(
                                Icons.sort,
                                color: Colors.white,
                                size: 20,
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Slider(
                            value: c.currentDuration.value.inSeconds.toDouble(),
                            min: 0,
                            max: c.totalDuration.inSeconds.toDouble(),
                            onChanged: c.sliderProgress,
                            activeColor: GColor.primary,
                            inactiveColor: Colors.white70,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(c.currentTime.value),
                              Text(c.totalTime.value)
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Icon(Icons.refresh, color: Colors.white),
                              Icon(Icons.skip_previous, color: Colors.white),
                              GestureDetector(
                                onTap: c.onPlay,
                                child: Icon(
                                  c.isPlay.value
                                      ? Icons.pause_circle_filled_rounded
                                      : Icons.play_circle_fill_rounded,
                                  size: 48,
                                  color: GColor.primary,
                                ),
                              ),
                              Icon(Icons.skip_next, color: Colors.white),
                              Icon(Icons.shuffle_rounded, color: Colors.white),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.volume_mute_rounded,
                                size: 24,
                                color: GColor.white,
                              ),
                              SliderTheme(
                                data: SliderThemeData(
                                  trackHeight: 4,
                                  activeTrackColor: GColor.white,
                                  inactiveTrackColor: Colors.white70,
                                  overlayColor: Colors.transparent,
                                  thumbColor: GColor.white,
                                  thumbShape: const RoundSliderThumbShape(
                                    enabledThumbRadius: 8,
                                  ),
                                ),
                                child: Slider(
                                  value: c.volume.value,
                                  min: 0,
                                  max: 100,
                                  onChanged: (v) => c.sliderVolume(v),
                                ),
                              ),
                              Icon(
                                Icons.volume_down_rounded,
                                size: 24,
                                color: GColor.white,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
