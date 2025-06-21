import 'package:flutter/material.dart';
import 'package:tvr_app/services/qr_service.dart';
import 'package:tvr_app/widgets/dialogs/to_score_board.dart';

class QRPage extends StatefulWidget {
  const QRPage({super.key});

  @override
  State<QRPage> createState() => _QRPageState();
}

class _QRPageState extends State<QRPage> {
  final _formKey = GlobalKey<FormState>();
  final QRService _qrService = QRService();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool isSubmitting = false;
  String? _emailError;

  Future<void> _submitForm() async {
    if (_formKey.currentState?.validate() == true) {
      setState(() {
        isSubmitting = true;
        _emailError = null;
      });

      try {
        await _qrService.addParticipant(
          _nameController.text,
          _emailController.text,
        );

        _nameController.clear();
        _emailController.clear();

        if (context.mounted) {
          showDialog(
            context: context,
            builder: (context) => const EntrySuccessDialog(),
          );
        }
      } catch (e) {
        if (e.toString().contains('E-mailadres is al geregistreerd')) {
          setState(() => _emailError = 'E-mailadres is al geregistreerd');
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Fout bij verzenden: $e')));
        }
      } finally {
        setState(() => isSubmitting = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      resizeToAvoidBottomInset: false,

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 40),
              const Text(
                'Vul hieronder je gegevens in om kans te maken op een prijs!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Jura',
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                controller: _nameController,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: 'Naam',
                  labelStyle: TextStyle(color: Colors.white70),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vul je naam in';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'E-mailadres',
                  labelStyle: const TextStyle(color: Colors.white70),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white38),
                  ),
                  errorText: _emailError,
                ),
                validator: (value) {
                  if (value == null || !value.contains('@')) {
                    return 'Vul een geldig e-mailadres in';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: isSubmitting ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF007AFF),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                ),
                child:
                    isSubmitting
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                          'Verstuur',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
