import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:tvr_app/services/score_board_service.dart';
import 'package:tvr_app/widgets/scoreboard/participant_list.dart';
import 'package:tvr_app/widgets/scoreboard/podium_widget.dart';
import 'package:tvr_app/widgets/scoreboard/shuffle_button.dart';

class ScoreBoardPage extends StatefulWidget {
  const ScoreBoardPage({super.key});

  @override
  State<ScoreBoardPage> createState() => _ScoreBoardPageState();
}

class _ScoreBoardPageState extends State<ScoreBoardPage>
    with TickerProviderStateMixin {
  final ScoreboardService _scoreboardService = ScoreboardService();
  final ConfettiController _confettiController = ConfettiController(
    duration: const Duration(seconds: 3),
  );

  List<Map<String, dynamic>> participants = [];
  bool isShuffling = false;
  bool showNames = false;

  bool hasShuffled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _scoreboardService.resetAllPositions();
      await _loadParticipants();
    });
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  Future<void> _loadParticipants() async {
    final data = await _scoreboardService.fetchParticipants();
    setState(() => participants = data);
  }

  Future<void> _shuffleWinners() async {
    setState(() {
      isShuffling = true;
      showNames = false;
    });

    await _scoreboardService.shuffleWinners();

    await _waitUntilThreeWinners();

    setState(() {
      isShuffling = false;
      showNames = true;
      hasShuffled = true;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      _confettiController.play();
    });
  }

  Future<void> _waitUntilThreeWinners() async {
    const timeout = Duration(seconds: 5);
    final deadline = DateTime.now().add(timeout);

    while (DateTime.now().isBefore(deadline)) {
      final fetched = await _scoreboardService.fetchParticipants();
      final winners = fetched.where((p) => p['score_position'] > 0).toList();
      if (winners.length == 3) {
        setState(() => participants = fetched);
        return;
      }
      await Future.delayed(const Duration(milliseconds: 200));
    }

    final fallback = await _scoreboardService.fetchParticipants();
    setState(() => participants = fallback);
  }

  @override
  Widget build(BuildContext context) {
    final winners =
        participants
            .where(
              (p) => p['score_position'] != null && p['score_position'] > 0,
            )
            .toList();

    String first =
        winners
            .firstWhere(
              (p) => p['score_position'] == 1,
              orElse: () => {'name': ''},
            )['name']
            ?.toString() ??
        '';

    String second =
        winners
            .firstWhere(
              (p) => p['score_position'] == 2,
              orElse: () => {'name': ''},
            )['name']
            ?.toString() ??
        '';

    String third =
        winners
            .firstWhere(
              (p) => p['score_position'] == 3,
              orElse: () => {'name': ''},
            )['name']
            ?.toString() ??
        '';

    final others = participants.where((p) => p['score_position'] == 0).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const Text(
                  '🏆',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 36),
                PodiumWidget(
                  first: first,
                  second: second,
                  third: third,
                  showNames: showNames,
                ),
                const SizedBox(height: 20),
                ParticipantList(others: others),
                const SizedBox(height: 20),
                ShuffleButton(
                  isShuffling: isShuffling,
                  hasShuffled: hasShuffled,
                  onPressed: _shuffleWinners,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(
                confettiController: _confettiController,
                blastDirection: pi / 2,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                emissionFrequency: 0.2,
                numberOfParticles: 20,
                maxBlastForce: 20,
                minBlastForce: 5,
                gravity: 0.2,
                colors: const [
                  Colors.blue,
                  Colors.white,
                  Color(0xFF3BBAFF),
                  Color(0xFFC4ABFF),
                  Color(0xFFCB5EFF),
                  Color(0xFF00A2FF),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
