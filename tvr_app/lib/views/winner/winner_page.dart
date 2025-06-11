import 'package:flutter/material.dart';

class WinnerPage extends StatelessWidget {
  const WinnerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          _TopSection(),
          const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.white,
            tabs: [Tab(text: 'WIN via Demo'), Tab(text: 'WIN via QR website')],
          ),
          const Expanded(child: TabBarView(children: [_DemoTab(), _QRTab()])),
        ],
      ),
    );
  }
}

class _TopSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Text(
                'WIN\nEEN VR\nBRIL of\nM&G!',
                style: const TextStyle(
                  fontFamily: 'Jura',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  height: 1.3,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 160,
            child: Image.asset('assets/images/mascotte.png'),
          ),
        ],
      ),
    );
  }
}

class _DemoTab extends StatelessWidget {
  const _DemoTab();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _StepList(
          steps: const [
            '1. Scan de QR-code van de demo',
            '2. Behaal de hoogste score van de dag!',
            '3. WIN WIN WIN!',
          ],
        ),
        const _TabDecorations(showScoreImage: true),
      ],
    );
  }
}

class _QRTab extends StatelessWidget {
  const _QRTab();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _StepList(
          steps: const [
            '1. Scan de QR-code van website',
            '2. Vul je naam & email adres in',
            '3. WIN WIN WIN!',
          ],
        ),
        const _TabDecorations(showScoreImage: false),
      ],
    );
  }
}

class _StepList extends StatelessWidget {
  final List<String> steps;

  const _StepList({required this.steps});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: steps.length,
      itemBuilder: (context, index) {
        final text = steps[index];
        final hasQrIcon = index == 0;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 6),
          height: 56, // Lagere vaste hoogte
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.indigo[800],
            borderRadius: BorderRadius.circular(12),
          ),
          child:
              hasQrIcon
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          text,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Image.asset('assets/images/QR.png'),
                        ),
                      ),
                    ],
                  )
                  : Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      text,
                      style: const TextStyle(color: Colors.white, fontSize: 18),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
        );
      },
    );
  }
}

class _TabDecorations extends StatelessWidget {
  final bool showScoreImage;

  const _TabDecorations({required this.showScoreImage});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            bottom: 16,
            left: 16,
            child:
                showScoreImage
                    ? Image.asset('assets/images/scoreboard.png', height: 90)
                    : const SizedBox(width: 90),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset('assets/images/trophy.png', height: 130),
          ),
          Positioned(
            bottom: 150,
            right: 17,
            child: Image.asset(
              'assets/images/question.png',
              height: 50,
              width: 50,
            ),
          ),
        ],
      ),
    );
  }
}
