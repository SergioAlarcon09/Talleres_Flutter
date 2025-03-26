// form_view.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FormView extends StatefulWidget {
  const FormView({super.key});

  @override
  State<FormView> createState() => _FormViewState();
}

class _FormViewState extends State<FormView> {
  String myVariable = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Formulario"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      myVariable = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Texto',
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Texto Capturado",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              Text(
                myVariable,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  context.go('/nueva-vista/$myVariable');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Enviar a Nueva Vista',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}