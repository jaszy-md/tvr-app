import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Achtergrondafbeelding
            Image.asset(
              'assets/images/home-bg.png',
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
            ),

            // Onderste schaduw van afbeelding
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

            // Welkomsttekst
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
                        fontFamily: 'Jaro',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Coming Soon-balkje links uitgelijnd zonder border-radius links
        Container(
          margin: const EdgeInsets.only(left: 0),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.centerLeft,
              radius: 2,
              colors: [
                Color(0xFF007BFF), // helder blauw
                Color(0xFF004A99), // donkerder blauw
              ],
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

        const SizedBox(height: 20),

        // overige content hier...
      ],
    );
  }
}
