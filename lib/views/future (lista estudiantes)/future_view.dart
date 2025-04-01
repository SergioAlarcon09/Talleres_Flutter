import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';


class FutureView extends StatefulWidget {
  const FutureView({super.key});

  @override
  State<FutureView> createState() => _FutureViewState();
}

class _FutureViewState extends State<FutureView> {
  List<String> _nombres = []; //declaramos una lista.

  @override
  void initState() {
    super.initState();
    obtenerDatos(); // Los datos cargan al iniciar
  }

  //* Espera 3 segundos antes de cargar los datos (simulación)
  Future<List<String>> nombresEstd() async {
    //future.delayed() para simular una carga de datos
    await Future.delayed(const Duration(seconds: 3));
    return [
      'David - Ingeniería',
      'Michael - Medicina',
      'Jesus - Medicina',
      'Alejandro - Derecho',
      'Valentina - Derecho',
      'Laura - Ingeniería',
      'José - Licenciatura',
      'Sofia - Licenciatura',
      'Sara - Licenciatura',
      'Pedro - Contaduría',
      'Mike - Contaduría',
      'Isabel - Enfermería',
      'Stephany - Derecho',
      'Paula - Ingeniería',
      'Ximena - Derecho',
      'Luz - Comercio I',
      'Esteban - Trabajo S',
      'Andrés - Trabajo S',
      'Jorge - Ingeniería',
    ];
  }

  // !Funcion para obtener los datos
  Future<void> obtenerDatos() async {
    final datos = await nombresEstd();

    //*mounted para verificar si el widget está montado en el árbol de widgets
    if (!mounted) return;
    setState(() {
      _nombres = datos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView(
      title: 'Lista de estudiantes',
      body:
          //* CircularProgressIndicator para mostrar el círculo de carga
          _nombres.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                padding: const EdgeInsets.all(10.0),
                child: GridView.builder(
                  itemCount: _nombres.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // columnas
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 2,
                  ),
                  itemBuilder: (context, index) {
                    return Card(
                      color: const Color.fromARGB(255, 89, 14, 95),
                      child: Center(
                        child: Text(
                          _nombres[index],
                          style: const TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
    );
  }
}
