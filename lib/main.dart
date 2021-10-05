import 'package:math_expressions/math_expressions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String ansString = "0";
  String expression = '0';

  void enterValue(var e) {
    setState(() {
      if (expression == "0") {
        expression = "$e";
      } else {
        //value =value * 10 + e;
        expression += "$e";
      }
    });
    calculate();
  }

  void calculate() {
    String exp = expression.replaceAll("X", "*").replaceAll("÷", "/");

    int n = exp.length - 1;
    var el = exp[n];
    if (el == '+' || el == '-' || el == '*' || el == '/') {
      exp = exp.substring(0, n);
    }
    setState(() {
      try {
        Parser p = Parser();
        ContextModel cm = ContextModel();
        Expression _exp = p.parse(exp);
        ansString = _exp.evaluate(EvaluationType.REAL, cm).toString();
        // ignore: empty_catches
      } on Exception {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 40),
            child: Container(
              height: 140,
              width: MediaQuery.of(context).size.width,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      height: 62,
                      alignment: Alignment.centerRight,
                      color: Colors.grey,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          expression,
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                    ),
                    Container(
                      height: 62,
                      alignment: Alignment.centerRight,
                      color: Colors.grey,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child: Text(
                          ansString,
                          textAlign: TextAlign.right,
                          style: const TextStyle(fontSize: 40),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Table(
                children: [
                  TableRow(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                expression = "0";
                                ansString = '0';
                              });
                            },
                            child: const Text("C"),
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Colors.red,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                  backgroundColor: Colors.grey,
                                  textStyle: const TextStyle(fontSize: 40),
                                ),
                                onPressed: () => enterValue(7),
                                child: const Text("7")),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                                backgroundColor: Colors.grey,
                                textStyle: const TextStyle(fontSize: 40),
                              ),
                              onPressed: () => enterValue(4),
                              child: const Text("4")),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                  backgroundColor: Colors.grey,
                                  textStyle: const TextStyle(fontSize: 40),
                                ),
                                onPressed: () => enterValue(1),
                                child: const Text("1")),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                                backgroundColor: Colors.grey,
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  expression = expression + ".";
                                });
                              },
                              child: const Text("."))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                expression += "X";
                              });
                            },
                            child: const Text("X"),
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Colors.amber,
                              textStyle: const TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                  backgroundColor: Colors.grey,
                                  textStyle: const TextStyle(fontSize: 40),
                                ),
                                onPressed: () => enterValue(8),
                                child: const Text("8")),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                                backgroundColor: Colors.grey,
                                textStyle: const TextStyle(fontSize: 40),
                              ),
                              onPressed: () => enterValue(5),
                              child: const Text("5")),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                  backgroundColor: Colors.grey,
                                  textStyle: const TextStyle(fontSize: 40),
                                ),
                                onPressed: () => enterValue(2),
                                child: const Text("2")),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                                backgroundColor: Colors.grey,
                                textStyle: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 40,
                                ),
                              ),
                              onPressed: () => enterValue(0),
                              child: const Text("0"))
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                expression += "÷";
                              });
                            },
                            child: const Text("÷"),
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Colors.amber,
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                  backgroundColor: Colors.grey,
                                  textStyle: const TextStyle(fontSize: 40),
                                ),
                                onPressed: () => enterValue(9),
                                child: const Text("9")),
                          ),
                          TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                                backgroundColor: Colors.grey,
                                textStyle: const TextStyle(fontSize: 40),
                              ),
                              onPressed: () => enterValue(6),
                              child: const Text("6")),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                  backgroundColor: Colors.grey,
                                  textStyle: const TextStyle(fontSize: 40),
                                ),
                                onPressed: () => enterValue(3),
                                child: const Text("3")),
                          ),
                          SizedBox(
                            height: 63,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.red,
                                  backgroundColor: Colors.grey,
                                  textStyle: const TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (expression.isNotEmpty) {
                                      expression = expression.substring(
                                          0, expression.length - 1);
                                      if (expression.isEmpty) {
                                        expression = "0";
                                      }
                                    }
                                  });
                                  calculate();
                                },
                                child: const Text("del")),
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {
                              setState(() {
                                expression += "-";
                              });
                            },
                            child: const Text("-"),
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                              backgroundColor: Colors.amber,
                              textStyle: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: SizedBox(
                              height: 140,
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                    primary: Colors.black,
                                    backgroundColor: Colors.amber,
                                    textStyle: const TextStyle(fontSize: 40),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      expression += "+";
                                    });
                                  },
                                  child: const Text("+")),
                            ),
                          ),
                          SizedBox(
                            height: 140,
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                  backgroundColor: Colors.amber,
                                  textStyle: const TextStyle(fontSize: 40),
                                ),
                                onPressed: () {
                                  calculate();
                                  expression = ansString;
                                },
                                child: const Text("=")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
