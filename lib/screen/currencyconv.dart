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
  bool toUSD = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String fromCurrency = toUSD ? 'NRS' : 'USD';
    String toCurrency = toUSD ? 'USD' : 'NRS';
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
                        Text(convertedValue == null ? '' : 'Converted Value: ${toCurrency =="USD" ? "\$" : "Rs"}${convertedValue!.toStringAsFixed(2)} USD',
                        style: TextStyle(
                          fontSize: 18,
                        ),),
                      ElevatedButton(onPressed: (){
                        setState(() {
            double inputValue = double.parse(_controller.text);
            convertedValue = toUSD ? inputValue * val : inputValue / val;
                        });
                      }, child: Text('Convert')),
                      ElevatedButton(
            onPressed: () {
              setState(() {
                toUSD = !toUSD;
                convertedValue = null;
                _controller.clear();
              });
            },
            child: Text(toUSD ? 'Switch to USD → NRS' : 'Switch to NRS → USD'),
                        ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}