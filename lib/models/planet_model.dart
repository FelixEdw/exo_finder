// lib/models/planet_model.dart

class Planet {
  final String name;
  final String imagePath;
  final String description;
  final String size;
  final String distance;
  final String atmosphere;
  final int potentialForLife;
  final double imageHeight; // Properti untuk tinggi gambar kustom

  Planet({
    required this.name,
    required this.imagePath,
    required this.description,
    required this.size,
    required this.distance,
    required this.atmosphere,
    required this.potentialForLife,
    this.imageHeight = 600, // Nilai default jika tidak diatur
  });
}

// Data lengkap untuk planet-planet di Tata Surya
final List<Planet> planets = [
  Planet(
    name: 'Mercury',
    imagePath: 'assets/mercury.png',
    description: 'The smallest planet in our solar system and nearest to the Sun, Mercury is only slightly larger than Earth\'s Moon.',
    size: "7.48 x 10^7 km²",
    distance: "57.9 million km",
    atmosphere: "Oxygen, Sodium, Hydrogen",
    potentialForLife: 1,
    imageHeight: 600.0,
  ),
  Planet(
    name: 'Venus',
    imagePath: 'assets/venus.png',
    description: 'Venus spins slowly in the opposite direction from most planets. A thick atmosphere traps heat in a runaway greenhouse effect.',
    size: "4.60 x 10^8 km²",
    distance: "108.2 million km",
    atmosphere: "Carbon Dioxide, Nitrogen",
    potentialForLife: 1,
    imageHeight: 600.0,
  ),
  Planet(
    name: 'Earth',
    imagePath: 'assets/earth.png',
    description: 'Our Home Planet. The third planet from the Sun and the only astronomical object known to harbor life.',
    size: "5.10 x 10^8 km²",
    distance: "149.6 million km",
    atmosphere: "Nitrogen, Oxygen",
    potentialForLife: 5,
    imageHeight: 600.0,
  ),
  Planet(
    name: 'Mars',
    imagePath: 'assets/mars.png',
    description: 'The Red Planet. It is the second-smallest planet in the Solar System, being larger than only Mercury.',
    size: "1.45 x 10^8 km²",
    distance: "227.9 million km",
    atmosphere: "Carbon Dioxide, Argon",
    potentialForLife: 3,
    imageHeight: 600.0,
  ),
  Planet(
    name: 'Jupiter',
    imagePath: 'assets/jupiter.png',
    description: 'Jupiter is more than twice as massive as all the other planets combined. The giant planet\'s Great Red Spot is a centuries-old storm.',
    size: "6.14 x 10^10 km²",
    distance: "778.5 million km",
    atmosphere: "Hydrogen, Helium",
    potentialForLife: 1,
    imageHeight: 600.0,
  ),
  Planet(
    name: 'Saturn',
    imagePath: 'assets/saturn.png',
    description: 'Adorned with a dazzling, complex system of icy rings, Saturn is unique in our solar system. The other giant planets have rings, but none are as spectacular.',
    size: "4.27 x 10^10 km²",
    distance: "1.4 billion km",
    atmosphere: "Hydrogen, Helium",
    potentialForLife: 1,
    imageHeight: 1000.0, // Ukuran khusus untuk Saturnus
  ),
  Planet(
    name: 'Uranus',
    imagePath: 'assets/uranus.png',
    description: 'Uranus—seventh planet from the Sun—rotates at a nearly 90-degree angle from the plane of its orbit. This unique tilt makes Uranus appear to spin on its side.',
    size: "8.1 x 10^9 km²",
    distance: "2.9 billion km",
    atmosphere: "Hydrogen, Helium, Methane",
    potentialForLife: 1,
    imageHeight: 600.0,
  ),
  Planet(
    name: 'Neptune',
    imagePath: 'assets/neptune.png',
    description: 'Neptune—the eighth and most distant major planet orbiting our Sun—is dark, cold, and whipped by supersonic winds. It was the first planet located through mathematical calculation.',
    size: "7.6 x 10^9 km²",
    distance: "4.5 billion km",
    atmosphere: "Hydrogen, Helium, Methane",
    potentialForLife: 1,
    imageHeight: 600.0,
  ),
];