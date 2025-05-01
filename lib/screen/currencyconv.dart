import 'package:currencttempconverter/data.dart';
import 'package:flutter/material.dart';

class CurrencyConv extends StatefulWidget {
  const CurrencyConv({super.key});

  @override
  State<CurrencyConv> createState() => _CurrencyConvState();
}

class _CurrencyConvState extends State<CurrencyConv> {
  final TextEditingController _controller = TextEditingController();
  final double val = 0.0075;
  double? convertedValue;
  String fromCurrency = 'USD';
  String toCurrency = 'NRS';

  List<String> get toCurrencyOptions => currency[fromCurrency]!.keys.toList();

  void convert(){
    try{
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
        title: const Text('Currency Converter',style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 215, 72, 11),
        foregroundColor: Colors.white,
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Convert Currency', style: TextStyle(fontSize: 22)),
            const SizedBox(height: 20),
            Column(
              children: [
                DropdownButton<String>(
                  value: fromCurrency,
                  onChanged: (value) {
                    setState(() {
                      fromCurrency = value!;
                      toCurrency = currency[fromCurrency]!.keys.first;
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
            style: TextStyle(
              fontSize: 18,
            ),
                        ),
                        const SizedBox(height: 20),
                        TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Enter amount in $fromCurrency',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
                        ),
                        Text('Converted Value: ${convertedValue?.toStringAsFixed(2) ?? ''} $toCurrency',
                        style: TextStyle(
                          fontSize: 18,
                        ),),
                      ElevatedButton(onPressed: convert,
                      child: Text('Convert')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}