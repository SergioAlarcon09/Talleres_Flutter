import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  late Timer _timer;
  late Timer _timer2;
  int _cont = 0;
  int _cont2 = 0;
  int _indiceSeleccionado = 0;
  bool _paused1 = false; // Nuevo estado para pausa del timer1
  bool _paused2 = false; // Nuevo estado para pausa del timer2

  @override
  void initState() {
    super.initState();
    _iniciarTemporizador();
    _iniciarTemporizador2();
  }

  void _iniciarTemporizador() {
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (!_paused1) { // Solo incrementa si no está pausado
        setState(() {
          _cont++;
        });
      }
    });
  }

  void _iniciarTemporizador2() {
    _timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_paused2) { // Solo incrementa si no está pausado
        setState(() {
          _cont2++;
        });
      }
    });
  }

  //! Método para pausar/reanudar 
  void _togglePausa1() {
    setState(() {
      _paused1 = !_paused1;
    });
  }

  void _togglePausa2() {
    setState(() {
      _paused2 = !_paused2;
    });
  }

  //! Método para reiniciar los contadores
  void _reiniciar() {
    setState(() {
      _cont = 0;
      _cont2 = 0;
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _timer2.cancel();
    super.dispose();
  }

  void _itemSeleccionado(int index) {
    setState(() {
      _indiceSeleccionado = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> paginas = [
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Medio segundo: $_cont',
            style: const TextStyle(fontSize: 28),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _togglePausa1,
                child: Text(_paused1 ? 'Reanudar' : 'Pausar'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _reiniciar,
                child: const Text('Reiniciar'),
              ),
            ],
          ),
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Segundos: $_cont2',
            style: const TextStyle(fontSize: 28),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _togglePausa2,
                child: Text(_paused2 ? 'Reanudar' : 'Pausar'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: _reiniciar,
                child: const Text('Reiniciar'),
              ),
            ],
          ),
        ],
      ),
    ];

    return BaseView(
      title: 'Temporizadores',
      body: Column(
        children: [
          Expanded(child: paginas[_indiceSeleccionado]),
          BottomNavigationBar(
            currentIndex: _indiceSeleccionado,
            onTap: _itemSeleccionado,
            selectedItemColor: const Color.fromARGB(255, 218, 68, 255),
            unselectedItemColor: Colors.grey,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: 'Medio Segundo',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: 'Segundos',
              ),
            ],
          ),
        ],
      ),
    );
  }
}