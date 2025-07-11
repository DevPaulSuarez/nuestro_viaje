import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(NuestroViajeApp());
}

int calcularPuzzlesDelDia() {
  final aniversario = DateTime(2025, 7, 13);
  final hoy = DateTime.now();
  int diasRestantes = aniversario.difference(hoy).inDays;
  if (diasRestantes < 0) diasRestantes = 0;
  return diasRestantes;
}

class NuestroViajeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nuestro Viaje',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Arial',
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: PantallaBienvenida(),
    );
  }
}

class PantallaBienvenida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Bienvenida, mi amor 💖',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                'Este viaje no es solo de recuerdos,\nsino una forma de revivir todo lo que hemos compartido...',
                style: TextStyle(fontSize: 18, color: Colors.black87),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PantallaPuzzles()),
                  );
                },
                child: Text('Comenzar 💫', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PantallaPuzzles extends StatefulWidget {
  @override
  _PantallaPuzzlesState createState() => _PantallaPuzzlesState();
}

class _PantallaPuzzlesState extends State<PantallaPuzzles> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/ositos.mp4')
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
        _controller.setLooping(true);
        //_controller.setVolume(0);
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int diasRestantes = calcularPuzzlesDelDia();

    if (diasRestantes == 0) {
      return PantallaSorpresaFinal();
    }

    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(title: Text('Faltan $diasRestantes días 💌')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),

            if (_controller.value.isInitialized)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 180,
                  child: VideoPlayer(_controller),
                ),
              ),

            SizedBox(height: 16),

            Text(
              'Reto: Resolver el puzzle para ver el mensaje:',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.pink.shade800,
              ),
            ),

            SizedBox(height: 20),

            Puzzle3x3(imagePath: 'assets/viajeLima.jpg'),

            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class PantallaSorpresaFinal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            '🎉 ¡Feliz aniversario!\nAquí está tu sorpresa 💖',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.pinkAccent,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class Puzzle3x3 extends StatefulWidget {
  final String imagePath;
  const Puzzle3x3({Key? key, required this.imagePath}) : super(key: key);

  @override
  _Puzzle3x3State createState() => _Puzzle3x3State();
}

class _Puzzle3x3State extends State<Puzzle3x3> {
  late List<int> piezas;

  @override
  void initState() {
    super.initState();
    piezas = List.generate(9, (index) => index);
    do {
      piezas.shuffle();
    } while (piezas.last == 8);
  }

  void intercambiarPiezas(int i, int j) {
    setState(() {
      int temp = piezas[i];
      piezas[i] = piezas[j];
      piezas[j] = temp;
    });

    if (completo()) {
      mostrarMensajeExito();
    }
  }

  bool completo() {
    for (int i = 0; i < piezas.length; i++) {
      if (piezas[i] != i) return false;
    }
    return true;
  }

  void mostrarMensajeExito() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(color: Colors.black.withOpacity(0.6)),
            Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Container(
                  padding: EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.75),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.pinkAccent, width: 2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '💖 ¡Lo lograste!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Hoy viajamos al pasado, a ese domingo de enero de 2017, en aquel rincón tranquilo de Miraflores.\n\n'
                        'Recuerdo ese día como si el tiempo se hubiera detenido solo para nosotros. Éramos dos almas, aún sin saber todo lo que compartiríamos.\n\n'
                        'Así como el volcán de “Lava” esperó con paciencia a alguien que lo comprendiera y amara tal como era, yo también aprendí a esperar.\n\n'
                        'Desde entonces, la melodía de mi vida tiene tu voz, tu risa, tu abrazo.\n\n'
                        'Gracias por estos años llenos de momentos mágicos, por caminar conmigo cada día, por seguir construyendo juntos este viaje que no deja de sorprenderme.\n\n'
                        'Faltan pocos días para nuestro aniversario, pero ya siento que celebrarte es parte de cada instante que respiro 💖',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'Georgia',
                          fontStyle: FontStyle.italic,
                          color: Colors.deepPurple.shade800,
                        ),
                      ),
                      SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 12,
                          ),
                        ),
                        child: Text('Seguir 💫'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double tamano = MediaQuery.of(context).size.width * 0.9;
    double piezatamano = tamano / 3;

    return Container(
      width: tamano,
      height: tamano,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(color: Colors.black, width: 1), // Borde negro 1px
      ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: piezas.length,
        itemBuilder: (context, index) {
          int piezaIndex = piezas[index];

          return GestureDetector(
            onTap: () {
              int vacia = piezas.indexOf(8);
              int pos = index;

              List<int> vecinos = [];
              if (pos % 3 > 0) vecinos.add(pos - 1);
              if (pos % 3 < 2) vecinos.add(pos + 1);
              if (pos - 3 >= 0) vecinos.add(pos - 3);
              if (pos + 3 < 9) vecinos.add(pos + 3);

              if (vecinos.contains(vacia)) {
                intercambiarPiezas(pos, vacia);
              }
            },
            child: Stack(
              children: [
                Positioned(
                  left: -(piezaIndex % 3) * piezatamano,
                  top: -(piezaIndex ~/ 3) * piezatamano,
                  child: Image.asset(
                    widget.imagePath,
                    width: tamano,
                    height: tamano,
                    fit: BoxFit.cover,
                  ),
                ),
                if (piezaIndex == 8)
                  Container(
                    color: Color.fromARGB(255, 236, 155, 155),
                  ), // pieza vacía rosada
              ],
            ),
          );
        },
      ),
    );
  }
}
