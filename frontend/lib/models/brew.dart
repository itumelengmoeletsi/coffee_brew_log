class Brew {
  final int id;
  final String roasterName;
  final String brewMethod;
  final double coffeeWeight;
  final double waterWeight;
  final String? grindSize;
  final String? notes;

  Brew({
    required this.id,
    required this.roasterName,
    required this.brewMethod,
    required this.coffeeWeight,
    required this.waterWeight,
    this.grindSize,
    this.notes
  });

  // Convert JSON from FastAPI into a Flutter Brew object
  factory Brew.fromJson(Map<String, dynamic> json) {
    return Brew(
      id: json['id'],
      roasterName: json['roaster_name'],
      brewMethod: json['brew_method'],
      coffeeWeight: (json['coffee_weight'] as num).toDouble(),
      waterWeight: (json['coffee_weight'] as num).toDouble(),
      grindSize: json['grind_size'],
      notes: json['notes'],
    );
  }

  // Convert Flutter Brew object to JSON payload for POST/PATCH
  Map<String, dynamic> toJson() {
    return {
      'roaster_name': roasterName,
      'brew_method': brewMethod,
      'coffee_weight': coffeeWeight,
      'water_weight': waterWeight,
      'grind_size': grindSize,
      'notes': notes,
    };
  }
}