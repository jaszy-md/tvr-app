import 'package:flutter/material.dart';

class ShuffleButton extends StatelessWidget {
  final bool isShuffling;
  final bool hasShuffled;
  final VoidCallback onPressed;

  const ShuffleButton({
    super.key,
    required this.isShuffling,
    required this.hasShuffled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    if (hasShuffled) return const SizedBox.shrink(); // knop verdwijnt permanent
    return ElevatedButton(
      onPressed: isShuffling ? null : onPressed,
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
}
