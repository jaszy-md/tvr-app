import 'package:flutter/material.dart';

class ParticipantList extends StatelessWidget {
  final List<Map<String, dynamic>> others;

  const ParticipantList({super.key, required this.others});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(minHeight: 260),
      decoration: BoxDecoration(
        color: const Color(0xFF161616),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF0D5AC2), width: 1.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0xFF0D5AC2),
            blurRadius: 12,
            spreadRadius: 0.5,
          ),
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
            child:
                others.isEmpty
                    ? const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    )
                    : ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: others.length,
                      itemBuilder: (context, index) {
                        final p = others[index];
                        return ExpansionTile(
                          title: Text(
                            p['name'],
                            style: const TextStyle(color: Colors.white),
                          ),
                          tilePadding: const EdgeInsets.symmetric(
                            horizontal: 8,
                          ),
                          collapsedBackgroundColor: Colors.white.withOpacity(
                            0.02,
                          ),
                          backgroundColor: Colors.white.withOpacity(0.05),
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 10.0,
                                bottom: 6.0,
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  p['email'],
                                  style: const TextStyle(
                                    color: Color(0xFFCB5EFF),
                                    fontSize: 14,
                                    height: 1.4,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
