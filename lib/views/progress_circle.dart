import 'package:flutter/material.dart';

class CircularProgressWidget extends StatefulWidget {
  final double progress;
  const CircularProgressWidget({super.key, required this.progress});

  @override
  State<CircularProgressWidget> createState() => _CircularProgressWidgetState();
}

class _CircularProgressWidgetState extends State<CircularProgressWidget> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      height: 150,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: widget.progress * _controller.value,
                strokeWidth: 60,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getProgressColor(widget.progress),
                ),
              ),
              Text(
                '${(widget.progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

//! COLORES DEL DIAGRAMA MEDIANTE LOS PORCENTAJES
  Color _getProgressColor(double value) {
    if (value < 0.3) return Colors.red;
    if (value < 0.7) return Colors.orange;
    return Colors.green;
  }
}