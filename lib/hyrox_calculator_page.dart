import 'package:flutter/material.dart';

class HyroxCalculatorPage extends StatefulWidget {
  const HyroxCalculatorPage({super.key});

  @override
  _HyroxCalculatorPageState createState() => _HyroxCalculatorPageState();
}

class _HyroxCalculatorPageState extends State<HyroxCalculatorPage> {
  // Les variables pour stocker les informations nécessaires
  String _selectedLevel = 'Débutant';
  String _selectedTime = '30 minutes';
  String _suggestions = "";

  final Map<String, List<String>> _workouts = {
    'Débutant': [
      '4 x 400m de course + 50 Air Squats',
      '4 x 500m Rameur + 30 Burpees',
      '3 x 1km de course + 20 Wall Balls',
      '4 x 30 Cal Row + 20 Lunges avec Kettlebell',
      '2 x 500m SkiErg + 40 Kettlebell Swings',
      // Ajoutez d'autres séances
    ],
    'Intermédiaire': [
      '5 x 500m Rameur + 30 Wall Balls',
      '4 x 800m de course + 20 Push-Ups',
      '3 x 600m SkiErg + 30 Kettlebell Swings',
      '5 x 400m de course + 25 Lunges avec Dumbbell',
      '4 x 1000m de course + 40 Air Squats',
      // Ajoutez d'autres séances
    ],
    'Avancé': [
      '6 x 500m de course + 40 Air Squats',
      '5 x 1000m Rameur + 50 Burpees',
      '5 x 800m SkiErg + 30 Dumbbell Snatches',
      '3 x 800m de course + 60 Air Squats',
      '6 x 30 Cal Row + 30 Burpee Box Jumps',
      // Ajoutez d'autres séances
    ],
    'Expert': [
      '8 x 500m de course + 50 Air Squats',
      '6 x 1000m Rameur + 100 Burpees',
      '7 x 600m SkiErg + 50 Kettlebell Swings',
      '5 x 1000m de course + 60 Air Squats',
      '8 x 500m Rameur + 60 Lunges avec Kettlebell',
      // Ajoutez d'autres séances
    ],
  };

  void _generateWorkout() {
    if (_selectedLevel.isNotEmpty && _selectedTime.isNotEmpty) {
      List<String> availableWorkouts = _workouts[_selectedLevel]!;
      availableWorkouts.shuffle();

      int workoutCount;
      switch (_selectedTime) {
        case '30 minutes':
          workoutCount = 1;
          break;
        case '45 minutes':
          workoutCount = 2;
          break;
        case '60 minutes':
          workoutCount = 3;
          break;
        case '90 minutes':
          workoutCount = 4;
          break;
        default:
          workoutCount = 2;
      }

      setState(() {
        _suggestions = availableWorkouts.take(workoutCount).join('\n\n');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.black, // Couleur de fond de l'AppBar
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: const Color(0xFFFFC700), // Jaune Hyrox
        ),
        scaffoldBackgroundColor: Colors.black, // Fond noir
        textTheme: const TextTheme(
          headlineLarge: TextStyle(
              color: Color(0xFFFFC700),
              fontSize: 24,
              fontWeight: FontWeight.bold),
          bodyMedium: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFFFC700)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Row(
            children: [
              Image.asset(
                'assets/images/icon_hyrox.png',
                width: 24,
                height: 24,
              ), // Icône à côté du titre
              const SizedBox(width: 10), // Espacement entre l'icône et le texte
              const Text('Calculateur Hyrox',
                  style: TextStyle(color: Colors.white)),
            ],
          ),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Sélectionnez la durée de l'entraînement :",
                style: TextStyle(color: Colors.white),
              ),
              DropdownButton<String>(
                value: _selectedTime,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedTime = newValue!;
                  });
                },
                dropdownColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                items: <String>[
                  '30 minutes',
                  '45 minutes',
                  '60 minutes',
                  '90 minutes'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
              const Text(
                "Sélectionnez le niveau :",
                style: TextStyle(color: Colors.white),
              ),
              DropdownButton<String>(
                value: _selectedLevel,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedLevel = newValue!;
                  });
                },
                dropdownColor: Colors.black,
                style: const TextStyle(color: Colors.white),
                items: <String>['Débutant', 'Intermédiaire', 'Avancé', 'Expert']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generateWorkout,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFC700), // Jaune Hyrox
                  foregroundColor: Colors.black, // Texte noir
                ),
                child: const Text('Générer la séance'),
              ),
              const SizedBox(height: 20),
              if (_suggestions.isNotEmpty) ...[
                const Text(
                  "Séance suggérée :",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  _suggestions,
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
