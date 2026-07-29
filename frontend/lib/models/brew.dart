class Brew {
  final int id;
  final String roasterName;
  final String brewMethod;
  final int coffeeWeight;
  final int waterWeight;
  final int rating;
  final String? notes;

  Brew({
    required this.id,
    required this.roasterName,
    required this.brewMethod,
    required this.coffeeWeight,
    required this.waterWeight,
    required this.rating,
    this.notes
  });

  // Convert JSON from FastAPI into a Flutter Brew object
  factory Brew.fromJson(Map<String, dynamic> json) {
    return Brew(
      id: json['id'] as int? ?? 0,
      roasterName: json['roaster_name'] as String? ?? '',
      brewMethod: json['brew_method'] as String? ?? '',
      coffeeWeight: json['coffee_weight'] as int? ?? 0,
      waterWeight: json['water_weight'] as int? ?? 0,
      rating: json['rating'] as int? ?? 0,
      notes: json['notes'] as String?,
    );
  }

  // Convert Flutter Brew object to JSON payload for POST/PATCH
  Map<String, dynamic> toJson() {
    return {
      'roaster_name': roasterName,
      'brew_method': brewMethod,
      'coffee_weight': coffeeWeight,
      'water_weight': waterWeight,
      'rating': rating,
      'notes': notes,
    };
  }
}