import 'package:flutter/material.dart';

class Wallet extends StatelessWidget {
  const Wallet({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        'Wallet Screen',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    ));
  }
}
