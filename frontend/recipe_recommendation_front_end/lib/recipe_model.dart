// Recipe model class
class Recipe {
  final String title;
  final String ingredients;
  final String instructions;

  Recipe({
    required this.title,
    required this.ingredients,
    required this.instructions,
  });

  // Factory method to create a Recipe from a JSON object
  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      title: json['Title'],
      ingredients: json['Ingredients'],
      instructions: json['Instructions'],
    );
  }
}
