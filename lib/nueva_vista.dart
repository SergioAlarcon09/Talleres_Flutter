import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NuevaVista extends StatefulWidget {
  final String textoRecibido;
  
  const NuevaVista({super.key, required this.textoRecibido});

  @override
  State<NuevaVista> createState() => _NuevaVistaState();
}

class _NuevaVistaState extends State<NuevaVista> {
  String myVariable = "";

  //!MÉTODOS EN CONSOLA: initState(), didChangeDependencies(), dispose(), build() y setState()

  @override
  void initState() {
    super.initState();
    myVariable = widget.textoRecibido;
    print('initState() - Valor inicial: $myVariable');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('didChangeDependencies()');
  }

  @override
  void dispose() {
    print('dispose()');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('build()');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Nueva Vista"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  onChanged: (value) {
                    //!MÉTODO setState()
                    setState(() {
                      print('setState()');
                      myVariable = value;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Texto',
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                "Texto Recibido",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 10),
              Text(
                myVariable,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              const Text(
                "Texto Original",
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 10),
              Text(
                widget.textoRecibido,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () => context.go('/'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text(
                  'Volver al Inicio',
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