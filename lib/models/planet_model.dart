// lib/models/planet_model.dart

class Planet {
  final String name;
  final double? radius; // Radius Planet (dalam satuan Bumi)
  final double? mass;   // Massa Planet (dalam satuan Bumi)
  final double? distanceFromEarth; // Jarak (dalam parsec)
  final double? stellarTemperature; // Temperatur Bintang Induk (Kelvin)

  Planet({
    required this.name,
    this.radius,
    this.mass,
    this.distanceFromEarth,
    this.stellarTemperature,
  });

  // Factory constructor untuk membuat instance Planet dari JSON
  // Ini bagian yang paling penting untuk API
  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['pl_name'] as String,
      radius: (json['pl_rade'] as num?)?.toDouble(),
      mass: (json['pl_masse'] as num?)?.toDouble(),
      distanceFromEarth: (json['sy_dist'] as num?)?.toDouble(),
      stellarTemperature: (json['st_teff'] as num?)?.toDouble(),
    );
  }
}