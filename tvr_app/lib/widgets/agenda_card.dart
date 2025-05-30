import 'package:flutter/material.dart';

class AgendaCard extends StatelessWidget {
  final String zaal;
  final String tijd;
  final String afbeelding;
  final String titel;
  final bool isFavoriet;
  final VoidCallback onToggleFavoriet;

  const AgendaCard({
    super.key,
    required this.zaal,
    required this.tijd,
    required this.afbeelding,
    required this.titel,
    required this.isFavoriet,
    required this.onToggleFavoriet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              afbeelding,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Zaal $zaal',
                    style: const TextStyle(color: Colors.black),
                  ),
                  Row(
                    children: [
                      Text(
                        tijd,
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 6),
                      GestureDetector(
                        onTap: onToggleFavoriet,
                        child: Icon(
                          isFavoriet ? Icons.favorite : Icons.favorite_border,
                          size: 23,
                          color: isFavoriet ? Colors.pink : Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 40,
            right: 12,
            child: Text(
              titel.toUpperCase(),
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 5,
                    color: Colors.black,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
