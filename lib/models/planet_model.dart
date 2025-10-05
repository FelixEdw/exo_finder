// lib/models/planet_model.dart

class Planet {
  final String name;
  final double? radius;
  final double? mass;
  final double? distanceFromEarth;
  final double? stellarTemperature;
  final String? habitability; // Addition: Habitability status
  final String? composition;  // Addition: Planet composition

  Planet({
    required this.name,
    this.radius,
    this.mass,
    this.distanceFromEarth,
    this.stellarTemperature,
    this.habitability,
    this.composition,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    double? stellarTemp = (json['st_teff'] as num?)?.toDouble();
    double? planetRadius = (json['pl_rade'] as num?)?.toDouble();
    String habitabilityStatus = 'Unknown';
    String planetComposition = 'Unknown';

    // Simple logic to determine habitability
    if (stellarTemp != null && stellarTemp > 4000 && stellarTemp < 7000) {
      habitabilityStatus = 'Potentially habitable';
    } else {
      habitabilityStatus = 'Not habitable';
    }

    // Simple logic to determine composition
    if (planetRadius != null) {
      if (planetRadius < 2) {
        planetComposition = 'Rocky';
      } else if (planetRadius >= 2 && planetRadius < 10) {
        planetComposition = 'Gas';
      } else {
        planetComposition = 'Gas Giant';
      }
    }

    return Planet(
      name: json['pl_name'] as String,
      radius: planetRadius,
      mass: (json['pl_masse'] as num?)?.toDouble(),
      distanceFromEarth: (json['sy_dist'] as num?)?.toDouble(),
      stellarTemperature: stellarTemp,
      habitability: habitabilityStatus,
      composition: planetComposition,
    );
  }
}