import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculateur d\'allure de course',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _vitesseController = TextEditingController();
  final TextEditingController _allureController = TextEditingController();
  String _resultatConversion = "";
  double vitesseconvertie = 0;
  void _convertirVitesseEnAllure() {
    final double vitesse = double.tryParse(_vitesseController.text) ?? 0;
    if (vitesse > 0) {
      // Calcul de l'allure en minutes par kilomètre
      final double allureDecimale = 60 / vitesse;
      // Séparation des minutes et des secondes
      final int minutes =
          allureDecimale.floor(); // partie entière pour les minutes
      final int secondes = ((allureDecimale - minutes) * 60)
          .round(); // partie décimale convertie en secondes

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
      final int minutes =
          allureDecimale.floor(); // partie entière pour les minutes
      final int secondes = ((allureDecimale - minutes) * 100)
          .round(); // partie décimale convertie en secondes
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
    // double.tryParse(_vitesseController.text) ?? 0;
    if (vitesse > 0) {
// 50%
      final double vitesse50 = vitesse * 0.50;

      final double allureDecimale50 = 60 / vitesse50;
      // Séparation des minutes et des secondes
      final int minutes50 =
          allureDecimale50.floor(); // partie entière pour les minutes
      final int secondes50 = ((allureDecimale50 - minutes50) * 60)
          .round(); // partie décimale convertie en secondes

// 55%
      final double vitesse55 = vitesse * 0.55;

      final double allureDecimale55 = 60 / vitesse55;
      // Séparation des minutes et des secondes
      final int minutes55 =
          allureDecimale55.floor(); // partie entière pour les minutes
      final int secondes55 = ((allureDecimale55 - minutes55) * 60)
          .round(); // partie décimale convertie en secondes

// 60%
      final double vitesse60 = vitesse * 0.60;

      final double allureDecimale60 = 60 / vitesse60;
      // Séparation des minutes et des secondes
      final int minutes60 =
          allureDecimale60.floor(); // partie entière pour les minutes
      final int secondes60 = ((allureDecimale60 - minutes60) * 60)
          .round(); // partie décimale convertie en secondes

// 65%
      final double vitesse65 = vitesse * 0.65;

      final double allureDecimale65 = 60 / vitesse65;
      // Séparation des minutes et des secondes
      final int minutes65 =
          allureDecimale65.floor(); // partie entière pour les minutes
      final int secondes65 = ((allureDecimale65 - minutes65) * 60)
          .round(); // partie décimale convertie en secondes

// 70%
      final double vitesse70 = vitesse * 0.70;

      final double allureDecimale70 = 60 / vitesse70;
      // Séparation des minutes et des secondes
      final int minutes70 =
          allureDecimale70.floor(); // partie entière pour les minutes
      final int secondes70 = ((allureDecimale70 - minutes70) * 60)
          .round(); // partie décimale convertie en secondes

// 75%
      final double vitesse75 = vitesse * 0.75;

      final double allureDecimale75 = 60 / vitesse75;
      // Séparation des minutes et des secondes
      final int minutes75 =
          allureDecimale75.floor(); // partie entière pour les minutes
      final int secondes75 = ((allureDecimale75 - minutes75) * 60)
          .round(); // partie décimale convertie en secondes

// 80%
      final double vitesse80 = vitesse * 0.80;

      final double allureDecimale80 = 60 / vitesse80;
      // Séparation des minutes et des secondes
      final int minutes80 =
          allureDecimale80.floor(); // partie entière pour les minutes
      final int secondes80 = ((allureDecimale80 - minutes80) * 60)
          .round(); // partie décimale convertie en secondes

// 85%
      final double vitesse85 = vitesse * 0.85;

      final double allureDecimale85 = 60 / vitesse85;
      // Séparation des minutes et des secondes
      final int minutes85 =
          allureDecimale85.floor(); // partie entière pour les minutes
      final int secondes85 = ((allureDecimale85 - minutes85) * 60)
          .round(); // partie décimale convertie en secondes

// 90%
      final double vitesse90 = vitesse * 0.90;

      final double allureDecimale90 = 60 / vitesse90;
      // Séparation des minutes et des secondes
      final int minutes90 =
          allureDecimale90.floor(); // partie entière pour les minutes
      final int secondes90 = ((allureDecimale90 - minutes90) * 60)
          .round(); // partie décimale convertie en secondes

// 95%
      final double vitesse95 = vitesse * 0.95;

      final double allureDecimale95 = 60 / vitesse95;
      // Séparation des minutes et des secondes
      final int minutes95 =
          allureDecimale95.floor(); // partie entière pour les minutes
      final int secondes95 = ((allureDecimale95 - minutes95) * 60)
          .round(); // partie décimale convertie en secondes

// 100%
      final double vitesse100 = vitesse;

      final double allureDecimale100 = 60 / vitesse100;
      // Séparation des minutes et des secondes
      final int minutes100 =
          allureDecimale100.floor(); // partie entière pour les minutes
      final int secondes100 = ((allureDecimale100 - minutes100) * 60)
          .round(); // partie décimale convertie en secondes

// 105%
      final double vitesse105 = vitesse * 1.05;

      final double allureDecimale105 = 60 / vitesse105;
      // Séparation des minutes et des secondes
      final int minutes105 =
          allureDecimale105.floor(); // partie entière pour les minutes
      final int secondes105 = ((allureDecimale105 - minutes105) * 60)
          .round(); // partie décimale convertie en secondes

// 110%
      final double vitesse110 = vitesse * 1.10;

      final double allureDecimale110 = 60 / vitesse110;
      // Séparation des minutes et des secondes
      final int minutes110 =
          allureDecimale110.floor(); // partie entière pour les minutes
      final int secondes110 = ((allureDecimale110 - minutes110) * 60)
          .round(); // partie décimale convertie en secondes

      setState(() {
        _resultatConversion =
            '50% Vitesse: ${(vitesse50).toStringAsFixed(1)} km/h - 50% Allure: $minutes50 min $secondes50 s par km\n'
            '55% Vitesse: ${(vitesse55).toStringAsFixed(1)} km/h - 55% Allure: $minutes55 min $secondes55 s par km\n'
            '60% Vitesse: ${(vitesse60).toStringAsFixed(1)} km/h - 60% Allure: $minutes60 min $secondes60 s par km\n'
            '65% Vitesse: ${(vitesse65).toStringAsFixed(1)} km/h - 65% Allure: $minutes65 min $secondes65 s par km\n'
            '70% Vitesse: ${(vitesse70).toStringAsFixed(1)} km/h - 70% Allure: $minutes70 min $secondes70 s par km\n'
            '75% Vitesse: ${(vitesse75).toStringAsFixed(1)} km/h - 75% Allure: $minutes75 min $secondes75 s par km\n'
            '80% Vitesse: ${(vitesse80).toStringAsFixed(1)} km/h - 80% Allure: $minutes80 min $secondes80 s par km\n'
            '85% Vitesse: ${(vitesse85).toStringAsFixed(1)} km/h - 85% Allure: $minutes85 min $secondes85 s par km\n'
            '90% Vitesse: ${(vitesse90).toStringAsFixed(1)} km/h - 90% Allure: $minutes90 min $secondes90 s par km\n'
            '95% Vitesse: ${(vitesse95).toStringAsFixed(1)} km/h - 95% Allure: $minutes95 min $secondes95 s par km\n'
            '100% Vitesse: ${vitesse.toStringAsFixed(1)} km/h - 100% Allure: $minutes100 min $secondes100 s par km\n'
            '105% Vitesse: ${(vitesse105).toStringAsFixed(1)} km/h - 105% Allure: $minutes105 min $secondes105 s par km\n'
            '110% Vitesse: ${(vitesse110).toStringAsFixed(1)} km/h - 110% Allure: $minutes110 min $secondes110 s par km\n';
        vitesseconvertie = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculateur de Course'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _vitesseController,
              decoration: InputDecoration(labelText: 'Vitesse (km/h)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20), // Espacement de 20 pixels
            ElevatedButton(
              onPressed: _convertirVitesseEnAllure,
              child: Text('Convertir en Allure'),
            ),
            TextField(
              controller: _allureController,
              decoration: InputDecoration(labelText: 'Allure (min/km)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20), // Espacement de 20 pixels
            ElevatedButton(
              onPressed: _convertirAllureEnVitesse,
              child: Text('Convertir en Vitesse'),
            ),
            SizedBox(height: 20),
            Text(_resultatConversion),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculerPourcentagesvitesse,
              child: Text('Calculer Pourcentages Vitesse'),
            ),
          ],
        ),
      ),
    );
  }
}
