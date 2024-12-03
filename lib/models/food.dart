class Food {
  final String id;
  final String name;
  final double caloric;
  final double fat;
  final double carbon;
  final double protein;
  final String category;

  Food({
    required this.id,
    required this.name,
    required this.caloric,
    required this.fat,
    required this.carbon,
    required this.protein,
    required this.category,
  });

  // Factory constructor to create Food object from Firestore data
  factory Food.fromMap(Map<String, dynamic> data) {
    return Food(
      id: data['id'] as String,
      name: data['name'] as String,
      caloric: double.parse(data['caloric'].toString()),
      fat: double.parse(data['fat'].toString()),
      carbon: double.parse(data['carbon'].toString()),
      protein: double.parse(data['protein'].toString()),
      category: data['category'] as String,
    );
  }

  // Convert Food object to Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'caloric': caloric,
      'fat': fat,
      'carbon': carbon,
      'protein': protein,
      'category': category,
    };
  }
}
