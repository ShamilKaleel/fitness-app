class UserModel {
  String? id;
  String? name;
  String email;
  int? age;
  double? height;
  double? weight;
  String? gender;
  List<String>? favoriteWorkouts;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.age,
    this.height,
    this.weight,
    this.gender,
    this.favoriteWorkouts,
  });

  // Convert UserModel to a Map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
      'favoriteWorkouts': favoriteWorkouts,
    };
  }

  // Convert a Map to a UserModel
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      age: map['age'],
      height: map['height'],
      weight: map['weight'],
      gender: map['gender'],
      favoriteWorkouts: List<String>.from(map['favoriteWorkouts'] ?? []),
    );
  }
}
