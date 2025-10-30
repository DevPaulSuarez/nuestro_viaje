import 'dart:math';
import 'package:flutter/material.dart';
import 'package:scratcher/scratcher.dart';
import 'package:google_fonts/google_fonts.dart';

class PantallaSorpresa extends StatefulWidget {
  const PantallaSorpresa({super.key});

  @override
  State<PantallaSorpresa> createState() => _PantallaSorpresaState();
}

class _PantallaSorpresaState extends State<PantallaSorpresa> {
  final GlobalKey<ScratcherState> _scratcherKey = GlobalKey<ScratcherState>();

  double _valorRaspado = 0;
  final List<String> premios = [
    "🎁 ¡Ganaste un Beso",
    "🍽️ Ganaste Una Mordida",
    "🎬 Noche de películas Con Canchita",
    "🧘 Una Dulce Llamado Delicioso",
    "📷 Ganaste un Revolcon muy sexy",
    "🎉 Una Palmadita",
    "🎬 Ganaste Cositas Ricas",
    "🧘 Ganaste Una Pizza de Cena",
    "📷 Ganaste Una Apapachada",
    "🎉 Una Yuquitas Fritas Con Huevo "
  ];

  late String premioMostrado;

  @override
  void initState() {
    super.initState();
    _resetPremio();
  }

  void _resetPremio() {
    premioMostrado = premios[Random().nextInt(premios.length)];
    _valorRaspado = 0;
    _scratcherKey.currentState?.reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fondo blanco
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min, // Ajusta la columna al contenido
            children: [
              Scratcher(
                key: _scratcherKey,
  brushSize: 25,       // Pincel más pequeño para un raspado más suave que mas hacer 
  threshold: 50,       // Mayor porcentaje para revelar (más difícil)
  color: Colors.grey.shade600,
                onChange: (value) {
                  setState(() {
                    _valorRaspado = value;
                  });
                },
                onThreshold: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("¡Sorpresa desbloqueada!")),
                  );
                },
                child: Container(
                  height: 350, // Más grande
                  width: 350,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30), // Borde circular
                    gradient: LinearGradient(
                      colors: [Colors.white, Colors.pink.shade50],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    image: DecorationImage(
                      image: const AssetImage("assets/momo.jpg"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.pink.withOpacity(0.3), // Tinte rosa suave
                        BlendMode.srcATop,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        premioMostrado,
                        textAlign: TextAlign.center,
                         style: GoogleFonts.chewy( // También puedes probar Pacifico, Chewy, Fredoka
        fontSize: 40,
        fontWeight: FontWeight.w700,
        color: const Color.fromARGB(255, 2, 0, 0), // O usa Color(0xFFE91E63) para más intensidad
        height: 1.4,
      ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _resetPremio();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(176, 250, 250, 250),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // borde circular
                  ),
                ),
                child: const Text(
                  "Probar otra vez",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
