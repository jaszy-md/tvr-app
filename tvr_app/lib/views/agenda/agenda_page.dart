import 'package:flutter/material.dart';
import 'package:tvr_app/widgets/agenda_card.dart';

class AgendaItem {
  final String zaal;
  final String tijd;
  final String afbeelding;
  final String titel;
  bool isFavoriet;

  AgendaItem({
    required this.zaal,
    required this.tijd,
    required this.afbeelding,
    required this.titel,
    this.isFavoriet = false,
  });
}

class AgendaPage extends StatefulWidget {
  const AgendaPage({super.key});

  @override
  State<AgendaPage> createState() => _AgendaPageState();
}

class _AgendaPageState extends State<AgendaPage> {
  bool showOnlyFavorieten = false;

  final List<AgendaItem> _vrijdagItems = [
    AgendaItem(
      zaal: '5',
      tijd: '10:15–11:00',
      afbeelding: 'assets/images/verraders.png',
      titel: 'De Verraders',
    ),
    AgendaItem(
      zaal: '6',
      tijd: '11:15–12:00',
      afbeelding: 'assets/images/slimstemens.png',
      titel: 'De Slimste Mens',
      isFavoriet: true,
    ),
    AgendaItem(
      zaal: '3',
      tijd: '13:00–13:45',
      afbeelding: 'assets/images/lingo.png',
      titel: 'Lingo',
    ),
  ];

  final List<AgendaItem> _zaterdagItems = [
    AgendaItem(
      zaal: '2',
      tijd: '10:00–10:45',
      afbeelding: 'assets/images/verraders.png',
      titel: 'De Verraders',
    ),
    AgendaItem(
      zaal: '1',
      tijd: '11:00–11:45',
      afbeelding: 'assets/images/slimstemens.png',
      titel: 'De Slimste Mens',
    ),
    AgendaItem(
      zaal: '4',
      tijd: '12:30–13:15',
      afbeelding: 'assets/images/lingo.png',
      titel: 'Lingo',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final vrijdagFiltered =
        showOnlyFavorieten
            ? _vrijdagItems.where((item) => item.isFavoriet).toList()
            : _vrijdagItems;

    final zaterdagFiltered =
        showOnlyFavorieten
            ? _zaterdagItems.where((item) => item.isFavoriet).toList()
            : _zaterdagItems;

    return Container(
      color: const Color(0xFF0A0A0A),
      child: ListView(
        children: [
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Kies jouw favoriete VR-demo’s en\nsla ze op bij je favorieten.\nAanmelden kan via de\nwebsite! 🌐',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          const Divider(color: Colors.white30, thickness: 1),
          const SizedBox(height: 10),

          GestureDetector(
            onTap: () {
              setState(() {
                showOnlyFavorieten = !showOnlyFavorieten;
              });
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFF121212),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    blurRadius: 6,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 16),
                      Icon(
                        showOnlyFavorieten
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.white,
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.arrow_drop_down, color: Colors.white),
                    ],
                  ),
                  const Text(
                    'Vrijdag 24 oktober',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),
          for (var item in vrijdagFiltered)
            AgendaCard(
              zaal: item.zaal,
              tijd: item.tijd,
              afbeelding: item.afbeelding,
              titel: item.titel,
              isFavoriet: item.isFavoriet,
              onToggleFavoriet: () {
                setState(() {
                  item.isFavoriet = !item.isFavoriet;
                });
              },
            ),

          const SizedBox(height: 30),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF121212),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  blurRadius: 6,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Text(
                  'Zaterdag 25 oktober',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 15),
          for (var item in zaterdagFiltered)
            AgendaCard(
              zaal: item.zaal,
              tijd: item.tijd,
              afbeelding: item.afbeelding,
              titel: item.titel,
              isFavoriet: item.isFavoriet,
              onToggleFavoriet: () {
                setState(() {
                  item.isFavoriet = !item.isFavoriet;
                });
              },
            ),
          const SizedBox(height: 60),
        ],
      ),
    );
  }
}
