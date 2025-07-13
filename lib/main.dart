import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:nuestro_viaje/Pantallas/carta_animada.dart';
import 'package:nuestro_viaje/Pantallas/renovacion_emocional.dart';
import 'package:nuestro_viaje/Pantallas/rasca.dart';
import 'package:nuestro_viaje/Pantallas/videos.dart';


void main() {
  runApp(NuestroViajeApp());
}

int calcularPuzzlesDelDia() {
  final aniversario = DateTime(2025, 7, 13);
  final hoy = DateTime.now();
  final hoySinHora = DateTime(hoy.year, hoy.month, hoy.day); // 🔹 Se elimina la hora
  int diasRestantes = aniversario.difference(hoySinHora).inDays;
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
                'Feliz Aniversario Mi Amor 💖',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.pinkAccent,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              // Texto clickeable
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => PantallaSorpresa()),
                  );
                },
                child: Text(
                  """Hoy celebramos una década juntos…
10 años de risas, aprendizajes, aventuras y amor real.
Gracias por cada día, por tu paciencia, tu compañía y por hacerme sentir en casa.
Después de todo este tiempo, no solo sigo eligiéndote…
sueño contigo en el siguiente paso:
crear una familia, tener hijos, construir un hogar lleno de pequeñas voces y grandes abrazos.
Porque si el futuro es contigo, lo quiero todo.""",
                  style: TextStyle(fontSize: 18, color: Colors.black87),
                  textAlign: TextAlign.center,
                ),
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
                child: Text('Busca los Easter Egg 💫', style: TextStyle(fontSize: 18)),
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
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Puzzle3x3(imagePath: 'assets/viajeLima.jpg'),

            SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PantallaSorpresaFinal()),
                );
              },
              child: Text('Saltar a la sorpresa 🎁'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PantallaSorpresaFinal extends StatelessWidget {
  final String mensaje = 
    '🎉 ¡Feliz aniversario!\nGracias por estos años juntos,\npor cada instante compartido...\nTe amo con todo mi corazón.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  backgroundColor: Colors.pink.shade50,
  body: Column(
    children: [
      // GIF superior

      GestureDetector(
  onTap: () {
      Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PantallaVideos(),
      ),
    );
  },
  child: SizedBox(
  height: 250, // Aumenta la altura para que sea más grande y baje más
  width: double.infinity,
  child: Align(
    alignment: Alignment.bottomCenter, // Cambia a bottomCenter para que baje
    child: Image.asset(
      "assets/arriba.gif",
      fit: BoxFit.contain, 
      height: 250,  // Controla el tamaño real del GIF aquí
    ),
  ),
),
),



      // Carta animada centrada
      Expanded(
        child: Center(
          child: SobreAnimado(
            mensaje: "El futuro es un lienzo en blanco, y cada día a tu lado es una pincelada de sueños y promesas por cumplir.",
          ),
        ),
      ),

      // GIF inferior
      // Suponiendo que este es el widget que muestra el GIF inferior:
GestureDetector(
  onTap: () {
      Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RenovacionEmocional(),
      ),
    );
  },
  child: SizedBox(
    height: 120,
    width: double.infinity,
    child: Image.asset(
      "assets/abajo.gif",
      fit: BoxFit.contain,
      alignment: Alignment.bottomCenter,
    ),
  ),
),
    ],
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.pinkAccent, width: 2),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '💖 ¡Puedes Conseguir Lo Que Te Propongas!',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.pinkAccent,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                    Stack(
  alignment: Alignment.center,
  children: [
    // Fondo: GIF animado
    Positioned.fill(
      child: Image.asset(
        'assets/stitch.gif',
                              width: 250,
                      height: 250,
                      fit: BoxFit.contain,
        //fit: BoxFit.cover,
      ),
    ),

    // Capa semi-transparente opcional para mejorar la legibilidad del texto
    Positioned.fill(
      child: Container(
        color: Colors.white.withOpacity(0.6),
      ),
    ),

    // Texto encima
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
      child: SingleChildScrollView(
        child: Text(
          'Espero que te divierta estos puzzles, Felicidades por resolver el 4to\n\n'
          'El 14 de febrero de 2017, tú me sorprendiste de una forma única.\n\n'
          'Preparaste una decoración con globos y una cena especial para San Valentín,\n'
          'algo que nadie jamás había hecho por mí, y sabes que no suelo esperar mucho.\n\n'
          'Esa sorpresa tocó mi corazón y marcó un antes y un después en nuestra historia.\n\n'
          'Hoy, 10 años después, celebro ese detalle y todo lo que hemos construido juntos.\n\n'
          'Gracias por estos años de amor, por cada instante compartido y por ser mi compañera de vida.\n'
          'Te amo con todo mi corazón.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'Georgia',
            fontStyle: FontStyle.italic,
            color: Colors.deepPurple.shade800,
          ),
        ),
      ),
    ),
  ],
),
                      SizedBox(height: 24),
                      Image.asset(
                      'assets/corazones_bombenado.gif',
                      width: 250,
                      height: 250,
                      fit: BoxFit.contain,
                    ),
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
