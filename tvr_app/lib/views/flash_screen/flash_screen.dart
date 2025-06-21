import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late VideoPlayerController _videoController;
  double _progress = 0;
  late Timer _progressTimer;
  final int _totalSteps = 40;

  @override
  void initState() {
    super.initState();

    _videoController = VideoPlayerController.asset(
      'assets/videos/mascott_flash.mp4',
    );

    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    await _videoController.initialize();
    _videoController.setLooping(true);
    _videoController.setVolume(0);
    _videoController.play();

    setState(() {});

    _progressTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _progress += 1 / _totalSteps;
        if (_progress >= 1.0) {
          _progressTimer.cancel();
          _videoController.pause();
          context.go('/home');
        }
      });
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _progressTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Transform.translate(
            offset: const Offset(0, -40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Transform.translate(
                  offset: const Offset(0, 20),
                  child:
                      _videoController.value.isInitialized
                          ? SizedBox(
                            width: 120,
                            height: 160,
                            child: VideoPlayer(_videoController),
                          )
                          : const SizedBox(
                            height: 160,
                            child: Center(child: CircularProgressIndicator()),
                          ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: const Text(
                    'REBOOT\nREALITY',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 44),
                      child: Image.asset('assets/images/logo.png', width: 50),
                    ),

                    const SizedBox(width: 12),

                    Padding(
                      padding: const EdgeInsets.only(right: 55),
                      child: SizedBox(
                        width: 180,
                        height: 12,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 1.5),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: TweenAnimationBuilder<double>(
                              tween: Tween<double>(begin: 0, end: _progress),
                              duration: const Duration(milliseconds: 300),
                              builder:
                                  (context, value, _) =>
                                      LinearProgressIndicator(
                                        value: value,
                                        color: Colors.white,
                                        backgroundColor: Colors.transparent,
                                      ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
