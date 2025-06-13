// Gewijzigde ScoreBoardPage zonder zichtbare loading states

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:tvr_app/services/score_board_service.dart';

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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadParticipants();
      _scoreboardService.resetAllPositions(); // asynchroon, geen await
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
    await _loadParticipants();

    setState(() {
      isShuffling = false;
      showNames = true;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      _confettiController.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    final winners =
        participants
            .where(
              (p) => p['score_position'] != null && p['score_position'] > 0,
            )
            .toList();

    String? first =
        winners.firstWhere(
          (p) => p['score_position'] == 1,
          orElse: () => {'name': ''},
        )['name'];
    String? second =
        winners.firstWhere(
          (p) => p['score_position'] == 2,
          orElse: () => {'name': ''},
        )['name'];
    String? third =
        winners.firstWhere(
          (p) => p['score_position'] == 3,
          orElse: () => {'name': ''},
        )['name'];

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
                _buildPodium(first, second, third),
                const SizedBox(height: 20),
                _buildParticipantList(others),
                const SizedBox(height: 20),
                _buildShuffleButton(),
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

  Widget _buildPodium(String? first, String? second, String? third) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Image.asset('assets/images/win-blocks.png', width: 270),
        Positioned(top: -20, left: 95, child: _nameBox(first, bold: true)),
        Positioned(top: 0, left: 10, child: _nameBox(second)),
        Positioned(top: 10, right: 10, child: _nameBox(third)),
      ],
    );
  }

  Widget _nameBox(String? name, {bool bold = false}) => AnimatedOpacity(
    opacity: showNames ? 1 : 0,
    duration: const Duration(milliseconds: 600),
    child: SizedBox(
      width: 80,
      child: Text(
        name ?? '',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: bold ? 16 : 14,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    ),
  );

  Widget _buildParticipantList(List<Map<String, dynamic>> others) => Container(
    width: double.infinity,
    constraints: const BoxConstraints(minHeight: 260),
    decoration: BoxDecoration(
      color: const Color(0xFF161616),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF0D5AC2), width: 1.5),
      boxShadow: const [
        BoxShadow(color: Color(0xFF0D5AC2), blurRadius: 12, spreadRadius: 0.5),
      ],
    ),
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '👥 Andere deelnemers:',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        const Divider(color: Colors.white, thickness: 1),

        SizedBox(
          height: 190,
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: others.length,
            itemBuilder: (context, index) {
              final p = others[index];
              return ExpansionTile(
                title: Text(
                  p['name'],
                  style: const TextStyle(color: Colors.white),
                ),
                children: [
                  Text(
                    p['email'],
                    style: const TextStyle(color: Colors.white70),
                  ),
                ],
                tilePadding: const EdgeInsets.symmetric(horizontal: 8),
                collapsedBackgroundColor: Colors.white.withOpacity(0.02),
                backgroundColor: Colors.white.withOpacity(0.05),
              );
            },
          ),
        ),
      ],
    ),
  );

  Widget _buildShuffleButton() => ElevatedButton(
    onPressed: isShuffling ? null : _shuffleWinners,
    style: ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF0D5AC2),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
    child:
        isShuffling
            ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
            : const Text(
              'Zie winnaars',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
  );
}
