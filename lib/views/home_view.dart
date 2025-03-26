import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hola_mundo/views/base_view.dart';
import 'package:hola_mundo/views/contador.dart';
import 'package:hola_mundo/views/progress_circle.dart'; // Importa el nuevo widget

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'UCEVA',
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Inicio'),
                Tab(icon: Icon(Icons.list), text: 'Lista'),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  //! Pestaña 1 - Inicio 
                  SingleChildScrollView(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(height: 5),
                          
                          //! Widget de Contador
                          const Card(
                            elevation: 8,
                            margin: EdgeInsets.all(20),
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Contador(),
                            ),
                          ),
                          const SizedBox(height: 30),
                          
                          //! Widget progress_circle
                          const Text(
                            'Progreso',
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(height: 5),
                          CircularProgressWidget(progress: 0.9), //! Valor de ejemplo
                          const SizedBox(height: 5),
                          
                          // Botón 
                          ElevatedButton(
                            onPressed: () => context.go('/form'),
                            child: const Text('Ir a Formulario'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  //! Pestaña 2 - GridView
                  GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(10, (index) {
                      return Center(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Text('Ítem ${index + 1}'),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}