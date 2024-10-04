import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: Image.asset(
          'assets/images/Logo.png', // Replace Chat History text with your logo
          height: 90,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Soil Moisture Graphical Stats (SMAP)
            StatGraph(
              title: 'Soil Moisture (SMAP)',
              icon: Icons.water_drop_outlined,
              percentage: 0.20, // 20%
              description: 'Ideal: 30% for Corn',
            ),
            StatGraph(
              title: 'Root Zone Moisture (SMAP)',
              icon: Icons.grass,
              percentage: 0.15, // 15%
              description: 'Ideal: 25% for Wheat',
            ),
            StatGraph(
              title: 'Rainfall (IMERG)',
              icon: Icons.cloud_queue,
              percentage: 0.12, // 12mm out of ideal 50mm
              description: 'Predicted: 40mm next 7 days',
            ),
            StatGraph(
              title: 'Land Temperature (MODIS)',
              icon: Icons.thermostat,
              percentage: 0.75, // 75% (approximation for ideal range)
              description: 'Ideal: 25-30°C for Corn',
            ),
            StatGraph(
              title: 'Evapotranspiration (ECOSTRESS)',
              icon: Icons.opacity,
              percentage: 0.50, // 5mm out of ideal 3mm/day
              description: 'Ideal: 3mm/day for Corn',
            ),
          ],
        ),
      ),
    );
  }
}

class StatGraph extends StatelessWidget {
  final String title;
  final IconData icon;
  final double percentage;
  final String description;

  const StatGraph({
    super.key,
    required this.title,
    required this.icon,
    required this.percentage,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    // Check current theme brightness to dynamically set icon color
    final iconColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white
        : Colors.black;

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Icon representation of the stat
            Icon(
              icon,
              size: 40.0,
              color: iconColor, // Dynamic icon color
            ),
            const SizedBox(width: 16),
            // Circular graphical representation
            CircularPercentIndicator(
              radius: 60.0,
              lineWidth: 13.0,
              animation: true,
              percent: percentage, // Percentage value (e.g., 0.50 for 50%)
              center: Text(
                "${(percentage * 100).toInt()}%",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              circularStrokeCap: CircularStrokeCap.round,
              progressColor: Colors.orangeAccent,
            ),
            const SizedBox(width: 16),
            // Textual description of the stat
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
