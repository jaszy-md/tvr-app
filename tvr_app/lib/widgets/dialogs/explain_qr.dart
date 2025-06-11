import 'package:flutter/material.dart';

class ExplainQRDialog extends StatelessWidget {
  const ExplainQRDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.only(
        top: 300,
        left: 20,
        right: 20,
        bottom: 40,
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 350,
          height: 420,
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    'Uitleg & Regels',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Jura',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '🎁 QR Winactie via Website\n\n'
                    'Scan de QR-code op de website, vul je e-mailadres in en maak kans op:\n'
                    '• 1 van de 2 VR-brillen\n'
                    '• Of een Meet & Greet met Chantal Janzen (2x beschikbaar)\n\n'
                    'Voorwaarden:\n'
                    '• Je moet aanwezig zijn op het evenement\n'
                    '• De prijs is persoonlijk en niet overdraagbaar\n'
                    '• Je moet je e-mailadres kunnen bevestigen.\n\n'
                    '🎮 Winactie Hoogste Score\n\n'
                    'Scan de QR-code bij een medewerker vóór je het spel speelt. Vul je e-mailadres in via de link. Per demo maak je kans op:\n'
                    '• 1 VR-bril\n'
                    '• 1 Meet & Greet met Chantal Janzen\n\n'
                    'Voorwaarden:\n'
                    '• Je moet aanwezig zijn op het evenement\n'
                    '• De prijs is persoonlijk en niet overdraagbaar\n'
                    '• Je moet je e-mailadres kunnen bevestigen\n'
                    '• Door mee te doen ga je akkoord met de algemene voorwaarden.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Jura',
                      color: Colors.white,
                      fontSize: 20,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
