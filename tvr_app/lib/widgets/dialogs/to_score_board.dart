import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EntrySuccessDialog extends StatefulWidget {
  const EntrySuccessDialog({super.key});

  @override
  State<EntrySuccessDialog> createState() => _EntrySuccessDialogState();
}

class _EntrySuccessDialogState extends State<EntrySuccessDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _offsetAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.1, 0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.only(
        top: 280,
        left: 20,
        right: 20,
        bottom: 45,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 350,
          height: 280,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF0C1732),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF0D5AC2), width: 2),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xFF0D5AC2),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Je doet mee!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Jura',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Je maakt nu kans op een prijs.\nHoud het scorebord in de gaten!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Jura',
                    fontSize: 18,
                    color: Colors.white,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                    context.go('/score_board');
                  },

                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/scoreboard.png',
                          width: 100,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                        const SizedBox(width: 10),
                        SlideTransition(
                          position: _offsetAnimation,
                          child: Image.asset(
                            'assets/images/arrow.png',
                            width: 80,
                            height: 80,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
