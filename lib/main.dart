import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculateur Fitness',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

// Page d'accueil avec choix de calculateur
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bienvenue dans le Calculateur Fitness'),
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
          ],
        ),
      ),
    );
  }
}

// Page du calculateur de course
class RunningCalculatorPage extends StatefulWidget {
  const RunningCalculatorPage({super.key});

  @override
  _RunningCalculatorPageState createState() => _RunningCalculatorPageState();
}

class _RunningCalculatorPageState extends State<RunningCalculatorPage> {
  final TextEditingController _vitesseController = TextEditingController();
  final TextEditingController _allureController = TextEditingController();
  String _resultatConversion = "";
  double vitesseconvertie = 0;

  void _convertirVitesseEnAllure() {
    final double vitesse = double.tryParse(_vitesseController.text) ?? 0;
    if (vitesse > 0) {
      final double allureDecimale = 60 / vitesse;
      final int minutes = allureDecimale.floor();
      final int secondes = ((allureDecimale - minutes) * 60).round();

      setState(() {
        _resultatConversion = 'Allure: $minutes min $secondes s par km';
      });
    } else {
      setState(() {
        _resultatConversion = 'Veuillez entrer une vitesse valide.';
      });
    }
  }

  void _convertirAllureEnVitesse() {
    final double allure = double.tryParse(_allureController.text) ?? 0;
    if (allure > 0) {
      final double allureDecimale = allure;
      final int minutes = allureDecimale.floor();
      final int secondes = ((allureDecimale - minutes) * 100).round();
      final int allureensecondes = ((minutes * 60) + secondes);
      final double vitesse = (3600 / allureensecondes);
      setState(() {
        _resultatConversion = 'Vitesse: ${vitesse.toStringAsFixed(1)} km/h\n';
        vitesseconvertie = vitesse;
      });
    }
  }

  void _calculerPourcentagesvitesse() {
    double vitesse = vitesseconvertie;
    if (vitesse < 1) {
      vitesse = double.tryParse(_vitesseController.text) ?? 0;
    }

    if (vitesse > 0) {
      final List<double> percentages = [
        0.50,
        0.55,
        0.60,
        0.65,
        0.70,
        0.75,
        0.80,
        0.85,
        0.90,
        0.95,
        1.00,
        1.05,
        1.10
      ];
      String results = "";

      for (double percentage in percentages) {
        final double vitessePercentage = vitesse * percentage;
        final double allureDecimale = 60 / vitessePercentage;
        final int minutes = allureDecimale.floor();
        final int secondes = ((allureDecimale - minutes) * 60).round();

        results +=
            '${(percentage * 100).toStringAsFixed(0)}% Vitesse: ${vitessePercentage.toStringAsFixed(1)} km/h - ${(percentage * 100).toStringAsFixed(0)}% Allure: $minutes min $secondes s par km\n';
      }

      setState(() {
        _resultatConversion = results;
        vitesseconvertie = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculateur de Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _vitesseController,
              decoration: const InputDecoration(
                labelText: 'Entrez votre vitesse (km/h)',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertirVitesseEnAllure,
              child: const Text('Convertir Vitesse en Allure'),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _allureController,
              decoration: const InputDecoration(
                labelText: 'Entrez votre allure (min.km)',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _convertirAllureEnVitesse,
              child: const Text('Convertir Allure en Vitesse'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculerPourcentagesvitesse,
              child: const Text('Calculer les vitesses selon les pourcentages'),
            ),
            const SizedBox(height: 20),
            Text(
              _resultatConversion,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

// Page du calculateur CrossFit
class CrossFitCalculatorPage extends StatefulWidget {
  const CrossFitCalculatorPage({super.key});

  @override
  _CrossFitCalculatorPageState createState() => _CrossFitCalculatorPageState();
}

class _CrossFitCalculatorPageState extends State<CrossFitCalculatorPage> {
  final TextEditingController _oneRepMaxController = TextEditingController();
  String _suggestions = "";
  List<String> _weightTable = [];

  void _calculateSuggestions() {
    final double oneRepMax = double.tryParse(_oneRepMaxController.text) ?? 0;

    if (oneRepMax > 0) {
      final Map<String, Map<String, dynamic>> suggestions = {
        "Renforcement": {"reps": "12-15", "series": "2-3", "percentage": 0.65},
        "Hypertrophie": {"reps": "8-12", "series": "3-4", "percentage": 0.75},
        "Force": {"reps": "3-5", "series": "4-6", "percentage": 0.85},
        "Puissance": {"reps": "1-3", "series": "3-5", "percentage": 0.95},
      };

      String results = "";

      suggestions.forEach((type, values) {
        final double percentage = values["percentage"] as double;
        final double suggestedWeight = oneRepMax * percentage;
        final int percentInt =
            (percentage * 100).toInt(); // Convertir en entier
        results +=
            "$type:\n Poids: ${suggestedWeight.toStringAsFixed(1)} kg (${percentInt}% de 1RM), Répétitions: ${values["reps"]}, Séries: ${values["series"]}\n\n";
      });

      _generateWeightTable(oneRepMax);

      setState(() {
        _suggestions = results;
      });
    } else {
      setState(() {
        _suggestions = "Veuillez entrer un 1RM valide.";
        _weightTable = [];
      });
    }
  }

  void _generateWeightTable(double oneRepMax) {
    List<String> table = [];
    for (int i = 30; i <= 110; i += 5) {
      double weight = oneRepMax * (i / 100);
      table.add("$i% de 1RM: ${weight.toStringAsFixed(1)} kg");
    }
    setState(() {
      _weightTable = table;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculateur CrossFit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              controller: _oneRepMaxController,
              decoration: const InputDecoration(
                labelText: 'Entrez votre 1RM (kg)',
              ),
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateSuggestions,
              child: const Text('Calculer les suggestions'),
            ),
            const SizedBox(height: 20),
            Text(
              _suggestions,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tableau des pourcentages de poids :',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _weightTable.length,
                itemBuilder: (context, index) {
                  return Text(
                    _weightTable[index],
                    style: const TextStyle(fontSize: 16),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
