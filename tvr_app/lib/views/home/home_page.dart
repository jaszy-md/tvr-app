import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool ticketBroken = false;

  late AnimationController demo1Controller;
  late AnimationController demo2Controller;
  late AnimationController arrowController;
  late Animation<Offset> arrowAnimation;
  int _textAnimationKey = 0;

  Future<void> _refreshPage() async {
    demo1Controller.reset();
    demo2Controller.reset();
    ticketBroken = false;
    setState(() {
      _textAnimationKey++; // 🔁 forceer rebuild van AnimatedTextKit
    });
    await Future.delayed(const Duration(milliseconds: 300));
    demo1Controller.forward();
    await Future.delayed(const Duration(milliseconds: 400));
    demo2Controller.forward();
  }

  @override
  void initState() {
    super.initState();

    demo1Controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    demo2Controller = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(milliseconds: 400));
      demo1Controller.forward();
      await Future.delayed(const Duration(milliseconds: 400));
      demo2Controller.forward();
    });

    arrowController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    arrowAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.1, 0),
    ).animate(
      CurvedAnimation(parent: arrowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    demo1Controller.dispose();
    demo2Controller.dispose();
    arrowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshPage,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Image.asset(
                  'assets/images/home-bg.png',
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: -10,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 10,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Color(
                            0xFF122846,
                          ).withOpacity(0.4), // ✅ zonder const
                          offset: const Offset(0, 1),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Transform.translate(
                    offset: const Offset(0, -50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'WELKOM',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        DefaultTextStyle(
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Jura',
                            height: 1.4,
                          ),
                          child: SizedBox(
                            width: double.infinity, // zodat center align werkt
                            child: AnimatedTextKit(
                              key: ValueKey(
                                _textAnimationKey,
                              ), // ✅ unieke key per refresh
                              isRepeatingAnimation: false,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  'REBOOT REALITY\nEvents',
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontFamily: 'Jura',
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                  speed: const Duration(milliseconds: 150),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Transform.translate(
              offset: const Offset(-10, 0),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xFF007BFF), Color(0xFF8000FF)],
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF0A0A0A),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(18),
                      bottomRight: Radius.circular(18),
                    ),
                  ),
                  child: const Text(
                    'Coming Soon!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Expanded(
                    child: Text(
                      'Doe mee aan\n1 van de geweldige demo’s',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontFamily: 'Jura',
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(3.5, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: demo1Controller,
                        curve: Curves.easeOutExpo,
                      ),
                    ),
                    child: FadeTransition(
                      opacity: demo1Controller,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/coming-soon-img-1.png',
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(-3.5, 0),
                      end: Offset.zero,
                    ).animate(
                      CurvedAnimation(
                        parent: demo2Controller,
                        curve: Curves.easeOutExpo,
                      ),
                    ),
                    child: FadeTransition(
                      opacity: demo2Controller,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'assets/images/coming-soon-img-2.png',
                          width: 190,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Geen tv kijken\nmaar spelen met TVR!',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontFamily: 'Jura',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Stack(
              children: [
                Image.asset(
                  'assets/images/winners-img.png',
                  width: double.infinity,
                  height: 450,
                  fit: BoxFit.cover,
                ),
                Positioned(
                  bottom: 60,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 65,
                    color: Colors.white.withOpacity(0.7),
                    alignment: Alignment.center,
                    child: const Text(
                      'Scan de QR-code en maak kans! 🏆',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/shop.png', width: 170),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Shop nu!',
                            style: TextStyle(color: Colors.white, fontSize: 48),
                          ),
                          const Text(
                            '10%',
                            style: TextStyle(
                              color: Color(0xFFDAFF00),
                              fontSize: 64,
                            ),
                          ),
                          const Text(
                            'bij deelname event',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    ticketBroken = !ticketBroken;
                                  });
                                },
                                child: Image.asset(
                                  ticketBroken
                                      ? 'assets/images/ticket-broken.png'
                                      : 'assets/images/Ticket.png',
                                  width: 100,
                                ),
                              ),

                              const SizedBox(width: 6),
                              Transform.translate(
                                offset: const Offset(
                                  -12,
                                  -12,
                                ), // Links en omhoog
                                child: SlideTransition(
                                  position: arrowAnimation,
                                  child: Image.asset(
                                    'assets/images/arrow.png',
                                    width: 90,
                                    height: 90,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}
