import 'package:flutter/material.dart';

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
