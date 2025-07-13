import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PantallaVideos extends StatefulWidget {
  const PantallaVideos({super.key});

  @override
  State<PantallaVideos> createState() => _PantallaVideosState();
}

class _PantallaVideosState extends State<PantallaVideos> {
  late VideoPlayerController _controllerQuisiera;
  late VideoPlayerController _controllerSabes;

  bool _mostrarQuisiera = false;
  bool _mostrarSabes = false;

  @override
  void initState() {
    super.initState();
    _controllerQuisiera = VideoPlayerController.asset("assets/quisiera.mp4")
      ..initialize().then((_) => setState(() {}));

    _controllerSabes = VideoPlayerController.asset("assets/sabes.mp4")
      ..initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controllerQuisiera.dispose();
    _controllerSabes.dispose();
    super.dispose();
  }

  void _reproducirQuisiera() {
    setState(() {
      _mostrarQuisiera = true;
      _mostrarSabes = false;
    });
    _controllerSabes.pause();
    _controllerSabes.seekTo(Duration.zero);
    _controllerQuisiera.play();
  }

  void _reproducirSabes() {
    setState(() {
      _mostrarSabes = true;
      _mostrarQuisiera = false;
    });
    _controllerQuisiera.pause();
    _controllerQuisiera.seekTo(Duration.zero);
    _controllerSabes.play();
  }

Widget _buildVideoSection(VideoPlayerController controller, String descripcion) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: VideoPlayer(controller),
        ),
      ),
      const SizedBox(height: 10),
      VideoProgressIndicator(
        controller,
        allowScrubbing: true,
        colors: VideoProgressColors(
          playedColor: Colors.pinkAccent,
          backgroundColor: Colors.pink.shade100,
          bufferedColor: Colors.pink.shade200,
        ),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.replay_10),
            onPressed: () {
              final newPosition = controller.value.position - const Duration(seconds: 10);
              controller.seekTo(newPosition >= Duration.zero ? newPosition : Duration.zero);
            },
          ),
          IconButton(
            icon: Icon(controller.value.isPlaying ? Icons.pause : Icons.play_arrow),
            onPressed: () {
              setState(() {
                controller.value.isPlaying ? controller.pause() : controller.play();
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.forward_10),
            onPressed: () {
              final maxDuration = controller.value.duration;
              final newPosition = controller.value.position + const Duration(seconds: 10);
              controller.seekTo(newPosition < maxDuration ? newPosition : maxDuration);
            },
          ),
        ],
      ),
      const SizedBox(height: 10),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          descripcion,
          style: TextStyle(
            fontSize: 16,
            color: Colors.deepPurple.shade700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ],
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: const Text("Recuerdas Estos Videos 🎥"),
        backgroundColor: Colors.pinkAccent,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text("Primer Video Dedicado"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                foregroundColor: Colors.white,
              ),
              onPressed: _reproducirQuisiera,
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(Icons.play_arrow),
              label: const Text("Primer rap Que Dedique y Cante"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              onPressed: _reproducirSabes,
            ),
            const SizedBox(height: 32),
            if (_mostrarQuisiera && _controllerQuisiera.value.isInitialized)
  _buildVideoSection(_controllerQuisiera, "🎶 Te Recuerdas cuando estabamos camninado Donde nos sentabamos a esperar tu Carro para que te vayas te dije que me gustaba esta cancion y te la empeze a cantar Sin Darme Cuenta Me Moria De Miedo en mi interior"),
if (_mostrarSabes && _controllerSabes.value.isInitialized)
  _buildVideoSection(_controllerSabes, "🎵 Esta es el Primer Video que realize Para ti Con nuestras fotos y Lo publique Ahora solo Solo puedo tomar los que tiene sonido Espero que te ayude a Recorsar Solo la Musica"),
          ],
        ),
      ),
    );
  }
}
