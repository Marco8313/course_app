import 'package:flutter/material.dart';
import 'dart:math';

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

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Bienvenue dans l\'application de l\'athlète du quotidien'),
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
    // Remplace les virgules par des points
    final double vitesse =
        double.tryParse(_vitesseController.text.replaceAll(',', '.')) ?? 0;
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
    // Remplace les virgules par des points
    final double allure =
        double.tryParse(_allureController.text.replaceAll(',', '.')) ?? 0;
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
      body: SingleChildScrollView(
        // Ajout d'un SingleChildScrollView
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

class CrossFitCalculatorPage extends StatefulWidget {
  const CrossFitCalculatorPage({super.key});

  @override
  _CrossFitCalculatorPageState createState() => _CrossFitCalculatorPageState();
}

class _CrossFitCalculatorPageState extends State<CrossFitCalculatorPage> {
  final TextEditingController _oneRepMaxController = TextEditingController();
  String _selectedTrainingType = 'Renforcement';
  String _selectedTime = '10 minutes';
  String _selectedLevel = 'Débutant';
  String _suggestions = "";
  double? _oneRepMax;
  Map<String, double> _percentageTable = {};

  final Random _random = Random();

  void _generateWorkout() {
    if (_oneRepMax == null) {
      setState(() {
        _suggestions = "Veuillez entrer votre 1RM.";
      });
      return;
    }

    String workout = "";

    if (_selectedTrainingType == 'Renforcement') {
      workout = _generateStrengthWorkout(_selectedTime, _selectedLevel);
    } else if (_selectedTrainingType == 'Hypertrophie') {
      workout = _generateHypertrophyWorkout(_selectedTime, _selectedLevel);
    } else if (_selectedTrainingType == 'Force') {
      workout = _generatePowerWorkout(_selectedTime, _selectedLevel);
    } else if (_selectedTrainingType == 'Puissance') {
      workout = _generateEnduranceWorkout(_selectedTime, _selectedLevel);
    }

    setState(() {
      _suggestions = workout;
    });
  }

  void _calculatePercentages() {
    if (_oneRepMax == null) return;

    _percentageTable = {
      '30%': _oneRepMax! * 0.30,
      '35%': _oneRepMax! * 0.35,
      '40%': _oneRepMax! * 0.40,
      '45%': _oneRepMax! * 0.45,
      '50%': _oneRepMax! * 0.50,
      '55%': _oneRepMax! * 0.55,
      '60%': _oneRepMax! * 0.60,
      '65%': _oneRepMax! * 0.65,
      '70%': _oneRepMax! * 0.70,
      '75%': _oneRepMax! * 0.75,
      '80%': _oneRepMax! * 0.80,
      '85%': _oneRepMax! * 0.85,
      '90%': _oneRepMax! * 0.90,
      '95%': _oneRepMax! * 0.95,
      '100%': _oneRepMax!,
      '105%': _oneRepMax! * 1.05,
      '110%': _oneRepMax! * 1.10,
    };
  }

  String _generateStrengthWorkout(String time, String level) {
    List<String> workouts = [
      "5 rounds: 5x Deadlifts à 60% 1RM, 10x Push-ups",
      "4 rounds: 8x Back Squats à 65% 1RM, 8x Pull-ups",
      "5 rounds: 10x Deadlifts à 70% 1RM, 10x Barbell Rows",
      "6 rounds: 12x Front Squats à 65% 1RM, 12x Bench Press"
    ];

    return workouts[_random.nextInt(workouts.length)];
  }

  String _generateHypertrophyWorkout(String time, String level) {
    List<String> workouts = [
      "4 rounds: 12x Bench Press à 60% 1RM, 15x Dumbbell Flyes",
      "5 rounds: 10x Squats à 65% 1RM, 12x Lunges",
      "4 rounds: 8x Deadlifts à 70% 1RM, 10x Leg Press",
      "5 rounds: 10x Barbell Rows à 65% 1RM, 12x Overhead Press"
    ];

    return workouts[_random.nextInt(workouts.length)];
  }

  String _generatePowerWorkout(String time, String level) {
    List<String> workouts = [
      "5 rounds: 8x Push Press à 60% 1RM, 10x Box Jumps",
      "4 rounds: 5x Power Cleans à 65% 1RM, 8x Broad Jumps",
      "5 rounds: 6x Push Jerk à 70% 1RM, 10x Med Ball Slams",
      "6 rounds: 4x Clean and Jerk à 75% 1RM, 10x Weighted Box Jumps"
    ];

    return workouts[_random.nextInt(workouts.length)];
  }

  String _generateEnduranceWorkout(String time, String level) {
    List<String> workouts = [
      "AMRAP 10: 10x Air Squats, 15x Sit-ups, 10x Burpees",
      "AMRAP 20: 20x Kettlebell Swings, 15x Box Jumps, 20x Wall Balls",
      "AMRAP 30: 30x Double-Unders, 20x Sit-ups, 15x Pull-ups",
      "AMRAP 45: 40x Push-ups, 30x Air Squats, 20x Deadlifts à 50% 1RM"
    ];

    return workouts[_random.nextInt(workouts.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Calculateur de CrossFit'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _oneRepMaxController,
                  decoration: const InputDecoration(
                    labelText: "Entrez votre 1RM (kg)",
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    setState(() {
                      _oneRepMax = double.tryParse(value);
                      _calculatePercentages();
                    });
                  },
                ),
                const SizedBox(height: 10),
                const Text("Tableau des pourcentages de 1RM :"),
                if (_oneRepMax != null)
                  GridView.count(
                    shrinkWrap:
                        true, // Permet au GridView d'être contenu dans le ScrollView
                    physics:
                        const NeverScrollableScrollPhysics(), // Empêche le GridView de défiler indépendamment
                    crossAxisCount: 3, // Définit 3 colonnes
                    childAspectRatio: 10, // Ajuste la hauteur des cellules
                    children: _percentageTable.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          '${entry.key}: ${entry.value.toStringAsFixed(1)} kg',
                          textAlign: TextAlign.center,
                        ),
                      );
                    }).toList(),
                  ),
                const SizedBox(height: 20),
                const Text("Sélectionnez le type d'entraînement :"),
                DropdownButton<String>(
                  value: _selectedTrainingType,
                  items: <String>[
                    'Renforcement',
                    'Hypertrophie',
                    'Force',
                    'Puissance'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedTrainingType = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                const Text("Sélectionnez la durée de l'entraînement :"),
                DropdownButton<String>(
                  value: _selectedTime,
                  items: <String>[
                    '10 minutes',
                    '20 minutes',
                    '30 minutes',
                    '45 minutes'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedTime = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 10),
                const Text("Sélectionnez le niveau :"),
                DropdownButton<String>(
                  value: _selectedLevel,
                  items: <String>['Débutant', 'Avancé', 'Expert']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _selectedLevel = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _generateWorkout,
                  child: const Text("Générer la séance"),
                ),
                const SizedBox(height: 20),
                Text(
                  _suggestions,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ));
  }
}
