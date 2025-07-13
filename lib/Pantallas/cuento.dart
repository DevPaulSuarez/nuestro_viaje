import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

class PantallaCuento extends StatefulWidget {
  const PantallaCuento({super.key});

  @override
  State<PantallaCuento> createState() => _PantallaCuentoState();
}

class _PantallaCuentoState extends State<PantallaCuento> {
  int _indexActual = 0;

  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;

  final List<String> _actosRomanos = [
    "I",
    "II",
    "III",
    "IV",
    "V",
    "VI",
    "VII",
  ];

  final List<String> _cuento = [
    "“Érase una vez…” una persona muy orgullosa de alcanzar siempre lo que se proponía… hasta que un día, por apenas una milésima —un 0.1— no logró ingresar a la universidad. Aquel instante cambió todo. Su mundo, antes firme, se derrumbó en silencio. Dejó de sentirse invencible… y empezó a conocerse de verdad.",
    "Pasó el tiempo. Los días se volvieron lecciones, y en medio del caos, apareció alguien. Una personita especial. Con una sonrisa suave y una forma de caminar que parecía sacada de una pasarela. Esa primera vez que la vio, ya tenía pareja… y eso le hizo sentir menos. Menos suficiente. Menos capaz.",
    "Pero la vida, que siempre guarda segundas oportunidades, los reunió tiempo después. Era una clase de programación… Java. Ella pidió ayuda. Él, sin pensarlo, dejó hasta su trabajo ese día. Hablaron. Se conocieron. Entre una gaseosa y una conversación de futuro, compartieron sueños y dudas.",
    "“Primero hay que tener casa, carro, perro… y después pareja” —le dijo él, repitiendo lo que siempre le enseñaron. Pero ella respondió distinto: “¿Y de qué sirve todo eso, si no se construye en equipo?” Y ahí todo cambió.",
    "Desde entonces, caminaron juntos. Construyeron un hogar, con detalles, con esfuerzo haciendo Crecer el Hogar.",
    "Adoptaron a un Perrito Despreciado por su Madre Lo Llamaron Raidon , y luego llegó un gato que lo recojieron del mercado y lo llevaron al veterinaro ese dia lo llamaron Raj Koothrappali en Honor a The Big Bang Theory y asi crece mas la Familia . Viajan cuando pueden, disfrutan cada comida sin importar el precio… porque el verdadero valor está en compartirla. Y aunque aún no tienen hijos, sueñan con algo más: Crear una empresa juntos. Dejar huella. Construir futuro.",
    "Y este, apenas es el comienzo de su historia...",
  ];

  void _avanzarTexto() {
    if (_indexActual < _cuento.length - 1) {
      setState(() {
        _indexActual++;
      });
    }
  }

  void _retrocederTexto() {
    if (_indexActual > 0) {
      setState(() {
        _indexActual--;
      });
    }
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    if (details.primaryVelocity == null) return;

    if (details.primaryVelocity! > 0) {
      _retrocederTexto();
    } else if (details.primaryVelocity! < 0) {
      _avanzarTexto();
    }
  }

  Widget _buildActoTitulo(String acto) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 10),
            height: 1.5,
            color: Colors.deepPurple.shade300,
          ),
        ),
        Text(
          acto,
          style: GoogleFonts.robotoCondensed(
            fontSize: 26,
            fontWeight: FontWeight.w900,
            color: Colors.deepPurple.shade700,
            letterSpacing: 2,
          ),
        ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(left: 10),
            height: 1.5,
            color: Colors.deepPurple.shade300,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset('assets/ositos.mp4');
    _initializeVideoPlayerFuture = _videoController.initialize().then((_) {
      setState(() {}); // para reconstruir cuando el video esté listo
      _videoController.setLooping(true);
      _videoController.play();
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: SafeArea(
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: _avanzarTexto,
          onHorizontalDragEnd: _onHorizontalDragEnd,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 700),
                child: Column(
                  key: ValueKey(_indexActual),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FutureBuilder(
                      future: _initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return SizedBox(
                            height: 140,
                            width: double.infinity,
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: SizedBox(
                                width: _videoController.value.size.width,
                                height: _videoController.value.size.height,
                                child: VideoPlayer(_videoController),
                              ),
                            ),
                          );
                        } else {
                          return SizedBox(
                            height: 140,
                            child: Center(child: CircularProgressIndicator()),
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 12),
                    _buildActoTitulo(_actosRomanos[_indexActual]),
                    const SizedBox(height: 12),
                    Text(
                      _cuento[_indexActual],
                      textAlign: TextAlign.center,
                      style: GoogleFonts.dancingScript(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: Colors.deepPurple.shade700,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
