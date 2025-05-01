import 'package:flutter/material.dart';
import 'package:currencttempconverter/data.dart';

class CurrencyConv extends StatefulWidget {
  const CurrencyConv({super.key});

  @override
  State<CurrencyConv> createState() => _CurrencyConvState();
}

class _CurrencyConvState extends State<CurrencyConv> {
  final TextEditingController _controller = TextEditingController();

  String fromCurrency = 'USD';
  String toCurrency = 'NRS';
  double? convertedValue;

  List<String> get toCurrencyOptions => currency[fromCurrency]!.keys.toList();

  void convert() {
    try {
      final input = double.parse(_controller.text);
      final func = currency[fromCurrency]![toCurrency];

      setState(() {
        convertedValue = func!(input);
      });
    } catch (e) {
      setState(() {
        convertedValue = null;
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
        title: const Text(
          'Currency Converter',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 215, 72, 11),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Convert Currency',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            DropdownButton<String>(
              value: fromCurrency,
              onChanged: (value) {
                setState(() {
                  fromCurrency = value!;
                  toCurrency = currency[fromCurrency]!.keys.first;
                  convertedValue = null;
                });
              },
              items: currency.keys.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            DropdownButton<String>(
              value: toCurrency,
              onChanged: (value) {
                setState(() {
                  toCurrency = value!;
                  convertedValue = null;
                });
              },
              items: toCurrencyOptions.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            Text(
              'Convert your currency here FROM $fromCurrency TO $toCurrency',
              style: const TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter amount in $fromCurrency',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _controller.clear();
                    setState(() {
                      convertedValue = null;
                    });
                  },
                ),
              ),
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 20),

            if(convertedValue != null)
              Text(
                'Result: ${convertedValue!.toStringAsFixed(2)} $toCurrency',
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: convert,
              child: const Text('Convert'),
            ),
          ],
        ),
      ),
    );
  }
}
