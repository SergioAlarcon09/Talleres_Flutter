import 'dart:async';
import 'package:flutter/material.dart';
import 'package:hola_mundo/views/base_view.dart';

class TimerView extends StatefulWidget {
  const TimerView({super.key});

  @override
  State<TimerView> createState() => _TimerViewState();
}

class _TimerViewState extends State<TimerView> {
  //* Late para variable no nula
  late Timer _timer;
  late Timer _timer2;
  int _cont = 0;
  int _cont2 = 0;
  int _indiceSeleccionado = 0; //* Nos servirá para "seleccionar"

  @override
  //* initState para cargar todo la primera vez
  void initState() {
    super.initState();
    _iniciarTemporizador();
    _iniciarTemporizador2();
  }

  //! Método para iniciar el temporizador
  void _iniciarTemporizador() {
    //* Timer.periodic para cada ejecución (medio segundo)
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _cont++;
      });
    });
  }

  void _iniciarTemporizador2() {
    //* Timer.periodic para cada ejecución (segundo)
    _timer2 = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _cont2++;
      });
    });
  }

  @override
  //* Dispose para cancelar temporizadores
  void dispose() {
    _timer.cancel();
    _timer2.cancel();
    super.dispose();
  }

  //! Método para cambiar de sección
  void _itemSeleccionado(int index) {
    setState(() {
      _indiceSeleccionado = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //*Lista de Widgets
    List<Widget> paginas = [
      Center(
        child: Text(
          'Medio segundo: $_cont',
          style: const TextStyle(fontSize: 28),
        ),
      ),
      Center(
        child: Text('Segundos: $_cont2', style: const TextStyle(fontSize: 28)),
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
                label: 'Contador (Segundos)',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.timer),
                label: 'Contador (Milisegundos)',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
