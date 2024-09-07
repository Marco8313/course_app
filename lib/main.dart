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
        title: const Center(
          // Utilisation du Center pour centrer le texte
          child: Text(
            'Bienvenue dans l\'application\nde l\'athlète du quotidien',
            textAlign: TextAlign.center, // Centre le texte dans le widget Text
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RunningCalculatorPage()),
                );
              },
              child: const Text('Calculateur de Course'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CrossFitCalculatorPage()),
                );
              },
              child: const Text('Calculateur de CrossFit'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const HyroxCalculatorPage()),
                );
              },
              child: const Text('Calculateur Hyrox'),
            ),
          ],
        ),
      ),
    );
  }
}
