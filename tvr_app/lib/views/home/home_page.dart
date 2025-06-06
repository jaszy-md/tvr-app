import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool ticketBroken = false;

  late AnimationController demo1Controller;
  late AnimationController demo2Controller;

  Future<void> _refreshPage() async {
    demo1Controller.reset();
    demo2Controller.reset();
    ticketBroken = false;

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
  }

  @override
  void dispose() {
    demo1Controller.dispose();
    demo2Controller.dispose();
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
            // HEADER
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
                          color: const Color(0xFF122846).withOpacity(0.4),
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
                      children: const [
                        Text(
                          'WELKOM',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'REBOOT REALITY\nEvents',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: 'Jura',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // COMING SOON
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.centerLeft,
                  radius: 2,
                  colors: [Color(0xFF007BFF), Color(0xFF004A99)],
                ),
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
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
            const SizedBox(height: 30),

            // DEMO 1
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

            // DEMO 2
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

            // WINNERS
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

            // SHOPSECTIE
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
                                      : 'assets/images/ticket-whole.png',
                                  width: 100,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Image.asset('assets/images/arrow.png', width: 60),
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
