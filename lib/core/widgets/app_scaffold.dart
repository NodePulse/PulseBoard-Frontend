import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget? child;
  const AppScaffold({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              // radius: double,
              colors: [
                Color.fromARGB(255, 32, 30, 30),
                Color.fromARGB(255, 25, 3, 52),
              ],
            ),
          ),
          child: Padding(padding: EdgeInsets.all(12), child: child),
        ),
      ),
    );
  }
}
