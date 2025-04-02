import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/models/meals.dart';
import 'package:hola_mundo/services/meal_service.dart';
import 'package:hola_mundo/views/base_view.dart';

class MealListView extends StatefulWidget {
  const MealListView({super.key});

  @override
  State<MealListView> createState() => _MealListViewState();
}

class _MealListViewState extends State<MealListView> {
  final MealService _mealService = MealService();  //*Instancia de la clase mealService
  late Future<List<Meal>> _futureMeals;   //* Variable tipo future que contendrá la lista de comidas

  @override
  void initState() {
    super.initState();
    _futureMeals = _mealService.getMeals();   //* Se llama al método getMeals de la clase mealService
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Recetas - Comida de mar',
      //* FutureBuilder para construir widgets basados en future, se encargará de hacer la lista de comidas 
      body: FutureBuilder<List<Meal>>(
        future: _futureMeals,
        builder: (context, snapshot) {
          if (snapshot.hasData) {  //* Respuesta del future
            final meals = snapshot.data!;  //* Se obtiene la lista de comidas
            return ListView.builder(     //* Se muestran los datos con un ListView.builder
              itemCount: meals.length,
              itemBuilder: (context, index) {
                final meal = meals[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: GestureDetector(   //* GestureDetector para gestos de usuario, nos llevará a la vista detalle de comida
                    onTap: () {
                      context.push('/meal/${meal.id}');
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                meal.image,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meal.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${meal.category} - ${meal.area}',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
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