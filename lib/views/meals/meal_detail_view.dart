import 'package:flutter/material.dart';
import 'package:hola_mundo/models/meals.dart';
import 'package:hola_mundo/services/meal_service.dart';

class MealDetailView extends StatefulWidget {
  final String id;

  const MealDetailView({super.key, required this.id});

  @override
  State<MealDetailView> createState() => _MealDetailViewState();
}

class _MealDetailViewState extends State<MealDetailView> {
  final MealService _mealService = MealService();
  late Future<Meal> _futureMeal;  //* Variable tipo future para contener el detalle de la comida

  @override
  void initState() {
    super.initState();
    _futureMeal = _mealService.getMealById(widget.id); //* Se llama al método getMealById de la clase mealService
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Receta')),
      body: FutureBuilder<Meal>(
        future: _futureMeal,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final meal = snapshot.data!;  //* Se obtiene el detalle de la comida
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16.0),
                    child: Image.network(
                      meal.image, //* Imagen de la comida
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    meal.name,  //* Nombre de la comida
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Chip(
                        label: Text(meal.category),  
                        backgroundColor: Colors.blueGrey.shade100,
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(meal.area),
                        backgroundColor: Colors.blueGrey.shade100,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Ingredientes:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: meal.ingredients.map((ingredient) {  //* Ingredientes
                      return Chip(
                        label: Text(ingredient),
                        backgroundColor: Colors.blueGrey.shade100,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Instrucciones:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(meal.instructions),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}