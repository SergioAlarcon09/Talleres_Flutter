import 'dart:async';
import 'dart:isolate';
import 'package:flutter/material.dart';

class IsolateView extends StatefulWidget {
  const IsolateView({super.key});

  @override
  State<IsolateView> createState() => _IsolateViewState();
}

class _IsolateViewState extends State<IsolateView> {
  String resultado = "Presiona el botón";
  Isolate? _isolate;
  ReceivePort? _receivePort;
  bool _isRunning = false;

  @override
  void dispose() {
    _cancelIsolate();
    super.dispose();
  }

  void _cancelIsolate() {
    if (_isolate != null) {
      _isolate?.kill(priority: Isolate.immediate);
      _isolate = null;
    }
    _receivePort?.close();
    _receivePort = null;
    _isRunning = false;
  }

  Future<void> isolateTask() async {
    if (_isRunning) return;
    
    setState(() {
      _isRunning = true;
      resultado = "Calculando...";
    });

    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_tareaPesada, _receivePort!.sendPort);

    try {
      final sendPort = await _receivePort!.first as SendPort;
      final response = ReceivePort();
      sendPort.send(["Hola desde el hilo principal", response.sendPort]);

      final result = await response.first as String;

      if (!mounted) return;
      setState(() {
        resultado = result;
        _isRunning = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result),
          duration: const Duration(seconds: 3),
        ),
      );
    } catch (e) {
      if (!mounted) return;
      setState(() {
        resultado = "Operación cancelada";
        _isRunning = false;
      });
    }
  }

  static void _tareaPesada(SendPort sendPort) {
    final port = ReceivePort();
    sendPort.send(port.sendPort);
    
    port.listen((message) {
      final data = message[0] as String;
      final puertoReceptor = message[1] as SendPort;

      int counter = 0;
      for (int i = 1; i <= 5000; i++) {
        counter += i;
      }

      puertoReceptor.send(
        "Tarea completada. Suma del 1 al 5000: $counter. Mensaje: '$data'",
      );
      port.close();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tarea pesada")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(resultado, textAlign: TextAlign.center),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isRunning ? null : isolateTask,
                child: const Text("Ejecutar tarea en segundo plano"),
              ),
              if (_isRunning) ...[
                const SizedBox(height: 20),
                const CircularProgressIndicator(),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: _cancelIsolate,
                  child: const Text("Cancelar"),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}