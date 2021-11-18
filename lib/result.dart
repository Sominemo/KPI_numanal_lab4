import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage(
    this.rightRectangle,
    this.leftRectangle,
    this.middleRectangle,
    this.simpson,
    this.trapezoid, {
    Key? key,
  }) : super(key: key);

  final num rightRectangle, leftRectangle, middleRectangle, simpson, trapezoid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('Right Rectangle'),
            subtitle: Text(rightRectangle.toString()),
          ),
          ListTile(
            title: const Text('Left Rectangle'),
            subtitle: Text(leftRectangle.toString()),
          ),
          ListTile(
            title: const Text('Middle Rectangle'),
            subtitle: Text(middleRectangle.toString()),
          ),
          ListTile(
            title: const Text('Simpson'),
            subtitle: Text(simpson.toString()),
          ),
          ListTile(
            title: const Text('Trapezoid'),
            subtitle: Text(trapezoid.toString()),
          ),
        ],
      ),
    );
  }
}
