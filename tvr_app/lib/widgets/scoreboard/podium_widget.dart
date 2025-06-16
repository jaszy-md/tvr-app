import 'package:flutter/material.dart';

class PodiumWidget extends StatelessWidget {
  final String? first;
  final String? second;
  final String? third;
  final bool showNames;

  const PodiumWidget({
    super.key,
    required this.first,
    required this.second,
    required this.third,
    required this.showNames,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      clipBehavior: Clip.none,
      children: [
        Image.asset('assets/images/win-blocks.png', width: 270),
        Positioned(top: -20, left: 95, child: _nameBox(first, true)),
        Positioned(top: 0, left: 10, child: _nameBox(second, false)),
        Positioned(top: 10, right: 10, child: _nameBox(third, false)),
      ],
    );
  }

  Widget _nameBox(String? name, bool bold) {
    return AnimatedOpacity(
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
  }
}
