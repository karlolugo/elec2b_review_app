import 'package:elec2b_review/safe_cracker_widgets/safe_dial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Review App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SafeCrackerView(),
    );
  }
}

class SafeCrackerView extends StatefulWidget {
  const SafeCrackerView({Key? key}) : super(key: key);
  @override
  State<SafeCrackerView> createState() => _SafeCrackerViewState();
}

class _SafeCrackerViewState extends State<SafeCrackerView> {
  List<int> values = [0, 0, 0];
  String combination = "420";
  String feedback = '';
  bool isUnlocked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade50,
      appBar: AppBar(
        title: const Text(
          "Safe Cracker",
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
                isUnlocked
                    ? CupertinoIcons.lock_open_fill
                    : CupertinoIcons.lock_fill,
                size: 100,
                color: Colors.blueGrey),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              height: 120,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                for (int i = 0; i < values.length; i++)
                  SafeDial(
                    startingValue: values[i],
                    onIncrement: () {
                      setState(() {
                        values[i]++;
                      });
                    },
                    onDecrement: () {
                      setState(() {
                        values[i]--;
                      });
                    },
                  ),
              ]),
            ),
            if (feedback.isNotEmpty)
              Text(
                feedback,
                style: const TextStyle(color: Colors.red),
              ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: TextButton(
                onPressed: unlockSafe(),
                child: Container(
                  padding: const EdgeInsets.all(37),
                  color: Colors.blueGrey,
                  child: const Text("Open the safe",
                      style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  sumOfAllValues(List<int> list) {
    var temp = 0;
    // list.forEach((val) {temp+=val; });
    for (int i = 0; i < list.length; i++) {
      temp += list[i];
    }
    // for (int number in list) {
    //   temp += number;
    // }
    return temp;
  }
}

class NumberHolder extends StatelessWidget {
  final dynamic content;
  const NumberHolder({Key? key, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(minHeight: 60),
      width: double.infinity,
      color: Colors.orangeAccent,
      child: Center(
        child: Text(
          "$content",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class IncrementalNumberHolder extends StatefulWidget {
  final Function(int) onUpdate;
  final int startingValue;
  const IncrementalNumberHolder(
      {Key? key, this.startingValue = 0, required this.onUpdate})
      : super(key: key);

  @override
  State<IncrementalNumberHolder> createState() =>
      _IncrementalNumberHolderState();
}

class _IncrementalNumberHolderState extends State<IncrementalNumberHolder> {
  @override
  void initState() {
    currentValue = widget.startingValue;
    super.initState();
  }

  late int currentValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      color: Colors.orangeAccent,
      constraints: const BoxConstraints(minHeight: 60),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              setState(() {
                currentValue--;
              });
              widget.onUpdate(currentValue);
            },
            icon: const Icon(Icons.chevron_left),
          ),
          Expanded(
            child: Text(
              "$currentValue",
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                currentValue++;
              });
              widget.onUpdate(currentValue);
            },
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}
