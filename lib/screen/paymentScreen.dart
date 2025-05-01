import 'package:flutter/material.dart';
import 'package:esewa_flutter/esewa_flutter.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? refId;
  String errorMessage = '';
  bool _isProcessing = false;

  Future<void> _startPayment() async {
    setState(() {
      _isProcessing = true;
      errorMessage = '';
      refId = null;
    });

    try {
      // Use test URLs that actually work with eSewa's sandbox environment
      final config = ESewaConfig.dev(
        amt: 100.0,
        pid: 'TEST_${DateTime.now().millisecondsSinceEpoch}', // Unique product ID
        su: 'https://mobile.esewa.com.np', // Replace with your actual success URL
        fu: 'https://mobile.esewa.com.np', // Replace with your actual failure URL
      );

      final result = await Esewa.i.init(
        context: context,
        eSewaConfig: config,
      );

      if (result.hasData) {
        setState(() {
          refId = result.data!.refId;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment Successful. Ref ID: $refId'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        setState(() {
          errorMessage = result.error ?? 'Payment failed without error message';
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment Failed: $errorMessage'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: ${e.toString()}';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Exception: $errorMessage'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isProcessing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('eSewa Payment'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pay NPR 100.00 via eSewa',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              if (_isProcessing)
                const CircularProgressIndicator()
              else
                ElevatedButton(
                  onPressed: _startPayment,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 15),
                  ),
                  child: const Text(
                    'Pay with eSewa',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              const SizedBox(height: 30),
              if (refId != null)
                Column(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      'Payment Successful\nRef ID: $refId',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.green),
                    ),
                  ],
                ),
              if (errorMessage.isNotEmpty)
                Column(
                  children: [
                    const Icon(Icons.error, color: Colors.red, size: 50),
                    const SizedBox(height: 10),
                    Text(
                      'Error: $errorMessage',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}