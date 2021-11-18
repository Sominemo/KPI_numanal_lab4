import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:math_parser/math_parser.dart';
import 'package:numanal_lab4/result.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Integrate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formula = TextEditingController(text: '1/sqrt(3*x^2-0.4)');
  final lowerLimit = TextEditingController(text: '1.3');
  final higherLimit = TextEditingController(text: '2.1');
  final n = TextEditingController(text: '20');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Integrate'),
      ),
      body: ListView(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    SizedBox(
                      width: 36,
                      height: 24,
                      child: TextFormField(
                        controller: higherLimit,
                        inputFormatters: [
                          TextInputFormatter.withFunction(
                              (oldValue, newValue) =>
                                  (num.tryParse(newValue.text) != null
                                      ? newValue
                                      : oldValue))
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/integral.png',
                      height: 36,
                    ),
                    SizedBox(
                      width: 36,
                      height: 24,
                      child: TextFormField(
                        controller: lowerLimit,
                        inputFormatters: [
                          TextInputFormatter.withFunction(
                              (oldValue, newValue) =>
                                  (num.tryParse(newValue.text) != null
                                      ? newValue
                                      : oldValue))
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: TextFormField(
                controller: formula,
              )),
              const Padding(
                padding: EdgeInsets.all(15),
                child: Text('dx'),
              ),
            ],
          ),
          Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text('n = '),
              ),
              SizedBox(
                width: 36,
                height: 24,
                child: TextFormField(
                  controller: n,
                  inputFormatters: [
                    TextInputFormatter.withFunction((oldValue, newValue) =>
                        (int.tryParse(newValue.text) != null
                            ? newValue
                            : oldValue))
                  ],
                ),
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.calculate),
        onPressed: () async {
          late final MathNode expr;
          try {
            expr = MathNodeExpression.fromString(formula.text);
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Can't parse formula")));
          }

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(
                  expr.definiteIntegralByRightRectangles(
                    int.parse(n.text),
                    num.parse(lowerLimit.text),
                    num.parse(higherLimit.text),
                  ),
                  expr.definiteIntegralByLeftRectangles(
                    int.parse(n.text),
                    num.parse(lowerLimit.text),
                    num.parse(higherLimit.text),
                  ),
                  expr.definiteIntegralByMiddleRectangles(
                    int.parse(n.text),
                    num.parse(lowerLimit.text),
                    num.parse(higherLimit.text),
                  ),
                  expr.definiteIntegralBySimpson(
                    int.parse(n.text),
                    num.parse(lowerLimit.text),
                    num.parse(higherLimit.text),
                  ),
                  expr.definiteIntegralByTrapezoids(
                    int.parse(n.text),
                    num.parse(lowerLimit.text),
                    num.parse(higherLimit.text),
                  ),
                ),
              ));
        },
      ),
    );
  }
}
