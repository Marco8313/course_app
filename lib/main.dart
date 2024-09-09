import 'package:flutter/material.dart';
import 'hyrox_calculator_page.dart'; // Importez la nouvelle page
import 'running_calculator_page.dart'; // Importez la page Course
import 'crossfit_calculator_page.dart'; // Importez la page CrossFit

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyFitness Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'L\'application de l\'athlète\n' 'du quotidien',
          style: TextStyle(color: Color.fromARGB(172, 255, 255, 255)),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color.fromARGB(255, 47, 48, 45),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.directions_run, color: Colors.blue),
              title: const Text('Course à pied'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RunningCalculatorPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.fitness_center, color: Colors.red),
              title: const Text('CrossFit'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CrossFitCalculatorPage(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Image.asset(
                'assets/images/icon_hyrox.png',
                width: 24,
                height: 24,
              ),
              title: const Text('Hyrox'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HyroxCalculatorPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/image_accueil.png', // Chemin de l'image
              fit: BoxFit.cover, // L'image couvre toute la page
            ),
          ),
          // Vous pouvez ajouter d'autres éléments par-dessus l'image ici
        ],
      ),
    );
  }
}
