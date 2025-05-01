import 'package:flutter/material.dart';
import 'package:currencttempconverter/data.dart';

class TempConv extends StatefulWidget {
  const TempConv({super.key});

  @override
  State<TempConv> createState() => _TempConvState();
}

class _TempConvState extends State<TempConv> {
  final TextEditingController _controller = TextEditingController();
  String fromUnit = 'Celsius';
  String? toUnit = 'Fahrenheit';
  double? result;

  List<String> get toUnitOptions => temp[fromUnit]!.keys.toList();

  void convert() {
    try {
      final input = double.parse(_controller.text);
      final func = temp[fromUnit]![toUnit!];
      setState(() {
        result = func!(input);
      });
    } catch (e) {
      setState(() {
        result = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid number')),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
        backgroundColor: Colors.deepOrange,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Convert Temperature', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            DropdownButton<String>(
              value: fromUnit,
              onChanged: (value) {
                setState(() {
                  fromUnit = value!;
                  toUnit = temp[fromUnit]!.keys.first;
                  result = null;
                });
              },
              items: temp.keys.map((unit) {
                return DropdownMenuItem(value: unit, child: Text(unit));
              }).toList(),
            ),
            DropdownButton<String>(
              value: toUnit,
              onChanged: (value) {
                setState(() {
                  toUnit = value!;
                  result = null;
                });
              },
              items: toUnitOptions.map((unit) {
                return DropdownMenuItem(value: unit, child: Text(unit));
              }).toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration:  InputDecoration(
                labelText: 'Enter temperature',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    setState(() {
                      result = null;
                    });
                  },
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            if (result != null)
              Text('Result: ${result!.toStringAsFixed(2)} $toUnit',
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                  ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: convert, child: const Text('Convert')),
          ],
        ),
      ),
    );
  }
}
