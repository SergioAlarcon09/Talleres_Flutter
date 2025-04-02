//! Modelo para representar las comidas
class Meal {
  final String id;
  final String name;
  final String image;
  final String category;
  final String area;
  final String instructions;
  final List<String> ingredients;

//! Constructor con los atributos requeridos
  Meal({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.area,
    required this.instructions,
    required this.ingredients,
  });

//! Método para convertir una instancia de Meal a JSON
  factory Meal.fromJson(Map<String, dynamic> json) {
    // Extraer ingredientes (pueden ser hasta 20)
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      if (json['strIngredient$i'] != null && json['strIngredient$i'].toString().isNotEmpty) {
        ingredients.add(json['strIngredient$i']);
      }
    }

    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      image: json['strMealThumb'],
      category: json['strCategory'],
      area: json['strArea'],
      instructions: json['strInstructions'],
      ingredients: ingredients,
    );
  }
}