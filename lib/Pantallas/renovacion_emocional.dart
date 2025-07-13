import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math';
import 'package:nuestro_viaje/Pantallas/cuento.dart';

class RenovacionEmocional extends StatefulWidget {
  const RenovacionEmocional({super.key});

  @override
  State<RenovacionEmocional> createState() => _RenovacionEmocionalState();
}

class _RenovacionEmocionalState extends State<RenovacionEmocional>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _fadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Stack(
        children: [
          // Fondo radial decorativo
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.2,
                colors: [
                  Color.fromARGB(255, 251, 251, 251),
                  Color.fromARGB(252, 216, 127, 188),
                ],
                stops: [0.2, 1.0],
              ),
            ),
          ),

          // GIF superior izquierda
          Positioned(
            top: 0,
            left: 0,
            child: SizedBox(
              height: 140,
               child: Transform.rotate(
                angle: pi,
                child: Image.asset(
                  "assets/onerous.gif",
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

          // GIF superior derecha rotado 180° y reflejado (efecto espejo)
Positioned(
  top: 0,
  right: 0,
  child: SizedBox(
    height: 140,
    child: Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..rotateZ(pi)         // Rotación 180°
        ..scale(-1.0, 1.0),   // Reflejo horizontal
      child: Image.asset(
        "assets/onerous.gif",
        fit: BoxFit.contain,
      ),
    ),
  ),
),

// GIF inferior izquierdo decorativo (tworous.gif)
Positioned(
  bottom: 0,
  left: -70,
  child: SizedBox(
    width: 380,     // Puedes ajustar a 80, 100, 120 según se necesite
    height: 380,   // Altura controlada
    child: Image.asset(
      "assets/tworous.gif",
      fit: BoxFit.contain,
    ),
  ),
),
          // Contenido central (mensaje + botón + gif clickeable)
          SafeArea(
  child: Center(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 80),

          // 📸 Imagen encima del texto
          SizedBox(
            height: 180,
                  child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => PantallaCuento()), // Asegúrate que Cuento es tu widget en cuento.dart
          );
        },
        child: Image.asset(
          "assets/momo.jpg",
          fit: BoxFit.contain,
        ),
      ),
          ),

          const SizedBox(height: 20),

          // ✨ Mensaje animado
          FadeTransition(
            opacity: _fadeAnim,
            child: Text(
              """Hoy no tengo un anillo de oro,
pero sí la certeza más valiosa:
quiero caminar contigo todos los días de mi vida.
¿Te quedarías conmigo para siempre?""",
              textAlign: TextAlign.center,
              style: GoogleFonts.dancingScript(
                fontSize: 18,
                color: Colors.deepPurple.shade700,
                fontWeight: FontWeight.w100,
              ),
            ),
          ),

          const SizedBox(height: 80),

          const SizedBox(height: 40),

          Padding(
  padding: const EdgeInsets.only(right: 60), // ajusta valor a tu gusto
  child: Align(
    alignment: Alignment.bottomRight,
    child: SizedBox(
      height: 190,
      child: Image.asset(
        "assets/bear.gif",
        fit: BoxFit.contain,
      ),
    ),
  ),
),

        ],
      ),
    ),
  ),
),

        ],
      ),
    );
  }
}
