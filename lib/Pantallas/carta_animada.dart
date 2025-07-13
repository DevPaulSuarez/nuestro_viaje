import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

class SobreAnimado extends StatefulWidget {
  final String mensaje;

  const SobreAnimado({super.key, required this.mensaje});

  @override
  State<SobreAnimado> createState() => _SobreAnimadoState();
}

class _SobreAnimadoState extends State<SobreAnimado> with TickerProviderStateMixin {
  late AnimationController _solapaController;
  late AnimationController _cartaController;

  late Animation<double> _solapaAnim;
  late Animation<Offset> _slideCartaAnim;
  late Animation<double> _fadeCartaAnim;

  bool abierta = false;

  @override
  void initState() {
    super.initState();

    _solapaController = AnimationController(
      duration: Duration(milliseconds: 700),
      vsync: this,
    );

    _cartaController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _solapaAnim = Tween<double>(begin: -pi / 1.5, end: 0).animate(
      CurvedAnimation(parent: _solapaController, curve: Curves.easeInOut),
    );

    _slideCartaAnim = Tween<Offset>(
      begin: Offset(0, 0.6),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _cartaController, curve: Curves.easeOut),
    );

    _fadeCartaAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(parent: _cartaController, curve: Curves.easeInOut),
    );
  }

  void _toggleSobre() {
    if (!abierta) {
      _solapaController.forward();
      Future.delayed(Duration(milliseconds: 400), () {
        _cartaController.forward();
      });
    } else {
      _cartaController.reverse();
      Future.delayed(Duration(milliseconds: 400), () {
        _solapaController.reverse();
      });
    }
    abierta = !abierta;
    setState(() {});
  }

  @override
  void dispose() {
    _solapaController.dispose();
    _cartaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleSobre,
      child: Center(
        child: Stack(
          alignment: Alignment.topCenter,
          clipBehavior: Clip.none,
          children: [
            // 1. Cuerpo rojo
            Container(
              margin: EdgeInsets.only(top: 100),
              width: 300,
              height: 160,
              decoration: BoxDecoration(
                color: Color(0xFFD14D44),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(12),
                ),
                boxShadow: [
                  BoxShadow(color: Colors.black26, blurRadius: 8),
                ],
              ),
            ),

            // 2. Solapa azul animada (por encima de la carta)
            AnimatedBuilder(
              animation: _solapaAnim,
              builder: (_, child) {
                return Transform(
                  alignment: Alignment.bottomCenter,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateX(_solapaAnim.value),
                  child: child,
                );
              },
              child: ClipPath(
                clipper: TrianguloClipper(),
                child: Container(
                  width: 300,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 88, 73, 225),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 6),
                    ],
                  ),
                ),
              ),
            ),

            // 3. Carta blanca con texto (animada con fade y slide)
            FadeTransition(
              opacity: _fadeCartaAnim,
              child: SlideTransition(
                position: _slideCartaAnim,
                child: Container(
                  width: 260,
                  height: 165,
                  margin: EdgeInsets.only(top: 0),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white, // Parte superior
                        Color(0xFFD14D44), // Parte inferior (rojo)
                      ],
                      stops: [0.6, 0.601],
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                    child: Align( // 👈 Cambiado de Center a Align
                    alignment: Alignment.topCenter,
                    child: Text(
  widget.mensaje,
  style: GoogleFonts.dancingScript(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.red.shade700,
  ),
  textAlign: TextAlign.center,
),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TrianguloClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(0, size.height); // izquierda abajo
    path.lineTo(size.width / 2, 0); // centro arriba
    path.lineTo(size.width, size.height); // derecha abajo
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TrianguloClipper oldClipper) => false;
}
