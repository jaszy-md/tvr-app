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
      )
      ..initialize().then((_) {
        setState(() {});
        _videoController.setLooping(true);
        _videoController.setVolume(0);
        _videoController.play();
      });

    _progressTimer = Timer.periodic(const Duration(milliseconds: 200), (timer) {
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 🖼️ Logo bovenaan
              Image.asset('assets/images/logo.png', width: 130, height: 130),

              const SizedBox(height: 20),

              // 🎥 Video gecentreerd (250x300)
              if (_videoController.value.isInitialized)
                SizedBox(
                  width: 250,
                  height: 320,
                  child: VideoPlayer(_videoController),
                )
              else
                const CircularProgressIndicator(),

              // 📶 Loading bar onderaan
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    value: _progress,
                    color: const Color(0xFF0049A4),
                    backgroundColor: Colors.white24,
                    minHeight: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
