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
            '${(percentage * 100).toStringAsFixed(0)}% V: ${vitessePercentage.toStringAsFixed(1)} km/h - A: $minutes min $secondes s par km\n';
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
  double? _oneRepMax;
  Map<String, double> _percentageTable = {};
  String _selectedTrainingType = 'Renforcement';
  String _selectedTime = '10 minutes';
  String _selectedLevel = 'Débutant';
  List<String> _selectedEquipment = [];
  String _suggestions = "";

  // List of available equipment options
  final List<String> _equipmentOptions = [
    'Rameur',
    'Wall Ball',
    'Kettlebell',
    'Dumbbell',
    'Barre de traction',
    'Corde à sauter',
    'Banc de musculation',
    'Plyo Box'
  ];

  // Example workout data
  final Map<String, Map<String, List<String>>> _workouts = {
    'Renforcement': {
      'Débutant': [
        '5 x 5 Kettlebell Squats @ 60% 1RM',
        '4 x 10 Dumbbell Press @ 50% 1RM',
        '3 x 8 Rameur 250m, 1 min de repos'
      ],
      'Intermédiaire': [
        '5 x 5 Overhead Press @ 60% 1RM',
        '4 x 8 Bench Press @ 70% 1RM',
        '4 x 8 Deadlifts @ 65% 1RM'
      ],
      'Avancé': [
        '6 x 4 Deadlifts @ 70% 1RM',
        '5 x 8 Wall Ball Shots @ 20kg',
        '4 x 10 Pull-Ups'
      ],
      'Expert': [
        '8 x 2 Snatch @ 80% 1RM',
        '5 x 5 Overhead Squats @ 70% 1RM',
        '6 x 10 Double-unders'
      ],
    },
    'Hypertrophie': {
      'Débutant': [
        '3 x 12 Dumbbell Curls @ 40% 1RM',
        '4 x 15 Push-Ups',
        '3 x 12 Kettlebell Swings @ 30% 1RM'
      ],
      'Intermédiaire': [
        '4 x 10 Dumbbell Bench Press @ 50% 1RM',
        '4 x 12 Lunges with Kettlebell @ 40% 1RM',
        '3 x 15 Box Jumps'
      ],
      'Avancé': [
        '4 x 10 Bench Press @ 65% 1RM',
        '5 x 12 Goblet Squats @ 50% 1RM',
        '4 x 15 Wall Ball Sit-Ups'
      ],
      'Expert': [
        '6 x 8 Clean and Jerks @ 75% 1RM',
        '5 x 10 Handstand Push-Ups',
        '4 x 20 Kettlebell Snatches @ 40% 1RM'
      ],
    },
    'Force': {
      'Débutant': [
        '4 x 6 Deadlifts @ 65% 1RM',
        '3 x 5 Dumbbell Bench Press @ 60% 1RM',
        '3 x 8 Box Jumps'
      ],
      'Intermédiaire': [
        '4 x 6 Overhead Squats @ 65% 1RM',
        '4 x 5 Weighted Pull-Ups',
        '3 x 10 Plyo Push-Ups'
      ],
      'Avancé': [
        '5 x 5 Squats @ 75% 1RM',
        '4 x 6 Pull-Ups Weighted',
        '4 x 8 Rameur Sprints 300m'
      ],
      'Expert': [
        '6 x 3 Front Squats @ 85% 1RM',
        '5 x 4 Weighted Pull-Ups @ 70% 1RM',
        '6 x 10 Burpee Box Jumps'
      ],
    },
    'Puissance': {
      'Débutant': [
        '3 x 10 Kettlebell Clean and Press @ 50% 1RM',
        '3 x 8 Dumbbell Push Press @ 50% 1RM',
        '4 x 20 Corde à sauter'
      ],
      'Intermédiaire': [
        '4 x 8 Power Snatch @ 60% 1RM',
        '4 x 10 Wall Ball Shots',
        '5 x 5 Broad Jumps'
      ],
      'Avancé': [
        '5 x 5 Power Cleans @ 70% 1RM',
        '4 x 10 Dumbbell Snatches @ 60% 1RM',
        '4 x 15 Plyo Box Jumps'
      ],
      'Expert': [
        '6 x 3 Push Jerks @ 80% 1RM',
        '5 x 6 Weighted Box Jumps @ 70% 1RM',
        '4 x 25 Double-unders'
      ],
    },
    'Hybride': {
      'Débutant': [
        '4 x 8 Rameur 250m, 1 min de repos',
        '4 x 8 Kettlebell Swings @ 40% 1RM',
        '4 x 15 Air Squats'
      ],
      'Intermédiaire': [
        '4 x 10 Front Squats @ 55% 1RM',
        '4 x 12 Wall Ball Shots',
        '4 x 10 Push-Ups'
      ],
      'Avancé': [
        '5 x 6 Thrusters @ 65% 1RM',
        '4 x 10 Kettlebell Clean and Press @ 50% 1RM',
        '4 x 20 Corde à sauter'
      ],
      'Expert': [
        '5 x 8 Deadlifts @ 75% 1RM',
        '6 x 3 Muscle-Ups',
        '4 x 12 Box Jumps'
      ],
    },
  };

  void _calculatePercentages() {
    if (_oneRepMax != null) {
      _percentageTable = {
        '30%': _oneRepMax! * 0.3,
        '35%': _oneRepMax! * 0.35,
        '40%': _oneRepMax! * 0.4,
        '45%': _oneRepMax! * 0.45,
        '50%': _oneRepMax! * 0.5,
        '55%': _oneRepMax! * 0.55,
        '60%': _oneRepMax! * 0.6,
        '65%': _oneRepMax! * 0.65,
        '70%': _oneRepMax! * 0.7,
        '75%': _oneRepMax! * 0.75,
        '80%': _oneRepMax! * 0.8,
        '85%': _oneRepMax! * 0.85,
        '90%': _oneRepMax! * 0.9,
        '95%': _oneRepMax! * 0.95,
        '100%': _oneRepMax!,
        '105%': _oneRepMax! * 1.05,
        '110%': _oneRepMax! * 1.1,
      };
    }
  }

  void _generateWorkout() {
    if (_selectedTrainingType.isNotEmpty &&
        _selectedLevel.isNotEmpty &&
        _selectedTime.isNotEmpty) {
      // Fetch the workout list based on the user's selection
      List<String> availableWorkouts =
          _workouts[_selectedTrainingType]![_selectedLevel]!;

      // Filter workouts based on equipment availability
      List<String> filteredWorkouts = availableWorkouts.where((workout) {
        for (String equipment in _selectedEquipment) {
          if (workout.toLowerCase().contains(equipment.toLowerCase())) {
            return true;
          }
        }
        return false;
      }).toList();

      // If no workouts match the selected equipment, use the default list
      if (filteredWorkouts.isEmpty) {
        filteredWorkouts = availableWorkouts;
      }

      // Shuffle and select workouts based on the duration
      filteredWorkouts.shuffle();
      int workoutCount;
      switch (_selectedTime) {
        case '10 minutes':
          workoutCount = 1;
          break;
        case '20 minutes':
          workoutCount = 2;
          break;
        case '30 minutes':
          workoutCount = 3;
          break;
        case '45 minutes':
          workoutCount = 4;
          break;
        default:
          workoutCount = 2;
      }

      setState(() {
        _suggestions = filteredWorkouts.take(workoutCount).join('\n\n');
      });
    }
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
              // Ajout de l'affichage des pourcentages
              if (_percentageTable.isNotEmpty) ...[
                const Text("Tableau des pourcentages de 1RM :"),
                if (_oneRepMax != null)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      // Determine the number of columns based on screen width
                      int columns = constraints.maxWidth > 600 ? 4 : 2;
                      double childAspectRatio =
                          constraints.maxWidth > 600 ? 4 : 3;

                      return GridView.builder(
                        shrinkWrap:
                            true, // Permet au GridView d'être contenu dans le ScrollView
                        physics:
                            const NeverScrollableScrollPhysics(), // Empêche le GridView de défiler indépendamment
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              columns, // Nombre de colonnes dynamiques
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio:
                              childAspectRatio, // Ajuste la hauteur des cellules dynamiquement
                        ),
                        itemCount: _percentageTable.length,
                        itemBuilder: (context, index) {
                          String key = _percentageTable.keys.elementAt(index);
                          return Container(
                            padding: const EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: Text(
                              '$key: ${_percentageTable[key]!.toStringAsFixed(1)} kg',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                          );
                        },
                      );
                    },
                  ),
                const SizedBox(height: 20),
              ],
              const Text("Sélectionnez votre matériel disponible :"),
              Wrap(
                spacing: 8.0,
                children: _equipmentOptions.map((String equipment) {
                  return FilterChip(
                    label: Text(equipment),
                    selected: _selectedEquipment.contains(equipment),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedEquipment.add(equipment);
                        } else {
                          _selectedEquipment.removeWhere((String name) {
                            return name == equipment;
                          });
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              const Text("Sélectionnez la durée de l'entraînement :"),
              DropdownButton<String>(
                value: _selectedTime,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTime = newValue!;
                  });
                },
                items: <String>[
                  '10 minutes',
                  '20 minutes',
                  '30 minutes',
                  '45 minutes'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              const Text("Sélectionnez le niveau :"),
              DropdownButton<String>(
                value: _selectedLevel,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLevel = newValue!;
                  });
                },
                items: <String>['Débutant', 'Intermédiaire', 'Avancé', 'Expert']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              const Text("Sélectionnez le type d'entraînement :"),
              DropdownButton<String>(
                value: _selectedTrainingType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTrainingType = newValue!;
                  });
                },
                items: <String>[
                  'Renforcement',
                  'Hypertrophie',
                  'Force',
                  'Puissance',
                  'Hybride'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generateWorkout,
                child: const Text('Générer la séance'),
              ),
              const SizedBox(height: 20),
              if (_suggestions.isNotEmpty) ...[
                const Text(
                  "Séance suggérée :",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(_suggestions, style: const TextStyle(fontSize: 16)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
