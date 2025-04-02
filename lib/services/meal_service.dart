import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hola_mundo/models/meals.dart';

class MealService {
  final String apiUrl = dotenv.env['MEAL_API_URL']!;  //* URL de la API en el archivo .env

//! Método para obtener la lista de las comidas 
  Future<List<Meal>> getMeals() async {
    final response = await http.get(Uri.parse('${apiUrl}filter.php?c=Seafood'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['meals'];

//! Mapeo de la lista de resultados para obtener la lista de comidas
      List<Future<Meal>> futures = results.map((item) {
        return getMealById(item['idMeal']);
      }).toList();
      
      return Future.wait(futures);
    } else {
      throw Exception('Error al obtener la lista de comidas');
    }
  }

//! Mapeo de la lista de resultados para obtener el detalle de cada comida
  Future<Meal> getMealById(String id) async {
    final response = await http.get(Uri.parse('${apiUrl}lookup.php?i=$id'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Meal.fromJson(data['meals'][0]);
    } else {
      throw Exception('Error al obtener el detalle de la comida');
    }
  }
}