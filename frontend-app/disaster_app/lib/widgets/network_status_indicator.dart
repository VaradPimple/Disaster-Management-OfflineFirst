import 'package:flutter/material.dart';

class NetworkStatusIndicator extends StatelessWidget {
  final bool isOnline;

  const NetworkStatusIndicator({super.key, required this.isOnline});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: isOnline ? Colors.green : Colors.red,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        isOnline ? "ONLINE MODE" : "OFFLINE MODE",
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
