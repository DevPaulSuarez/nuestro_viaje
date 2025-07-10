import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(NuestroViajeApp());
}

int calcularPuzzlesDelDia() {
  final aniversario = DateTime(2025, 7, 13);
  final hoy = DateTime.now();
  int diasRestantes = aniversario.difference(hoy).inDays;
  if (diasRestantes < 0) diasRestantes = 0; // Evitar negativos
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
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
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
                child: Text(
                  'Comenzar 💫',
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

class PantallaPuzzles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int diasRestantes = calcularPuzzlesDelDia();

    if (diasRestantes == 0) {
      return PantallaSorpresaFinal();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Faltan $diasRestantes días 💌'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Reto Resolver El puzzle Para Ver El Mensaje:',
              textAlign: TextAlign.center, // Centra el texto horizontalmente
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold, // Negrita
              ),
            ),
            SizedBox(height: 20),
            Puzzle3x3(imagePath: 'assets/viajeLima.jpg'), // Usa aquí tu imagen
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
    piezas.shuffle(); // Repetir hasta que la pieza vacía (8) no esté en la esquina
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
    barrierDismissible: false, // Evita cerrar accidentalmente
    builder: (context) {
      return Stack(
        children: [
          // Fondo con la imagen completa
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
          // Capa oscura semi-transparente
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          // Mensaje centrado
          Center(
            child: Container(
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
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
  'Puzzle del Día 2 completado 💖\n\n'
  '¿Recuerdas este momento? No fue una simple foto,\n'
  'fue un instante donde mi corazón se sintió completo.\n\n'
  'Tu abrazo a él no es solo ternura,\n'
  'es amor puro, sin condiciones, sin palabras, solo cariño.\n\n'
  'A veces lo veo mirarte con esos ojitos brillantes,\n'
  'como si supiera que está seguro mientras tú estés cerca.\n\n'
  'Gracias por quererlo como yo lo quiero, por hacer que nuestra familia —aunque peluda—\n'
  'sea más cálida, más feliz, más nuestra.\n\n'
  'Faltan solo 3 días para celebrar este amor… el que nos une a todos 💌',
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
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text('Seguir 💫'),
                  ),
                ],
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
      //color: Colors.grey.shade300,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        border: Border.all(color: Colors.black, width: 2), // Borde negro 1px
      ),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemCount: piezas.length,
        itemBuilder: (context, index) {
            int piezaIndex = piezas[index];
            int fila = piezaIndex ~/ 3;
            int columna = piezaIndex % 3;

          return GestureDetector(
              onTap: () {
                int vacia = piezas.indexOf(8);
                int pos = index;

                // Vecinos posibles
                List<int> vecinos = [];
                if (pos % 3 > 0) vecinos.add(pos - 1);
                if (pos % 3 < 2) vecinos.add(pos + 1);
                if (pos - 3 >= 0) vecinos.add(pos - 3);
                if (pos + 3 < 9) vecinos.add(pos + 3);

                // Si la pieza vacía está en vecinos, intercambiar
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
                  Container(color: const Color.fromARGB(255, 236, 155, 155)), // pieza vacía
              ],
            ),
          );
        },
      ),
    );
  }
}
