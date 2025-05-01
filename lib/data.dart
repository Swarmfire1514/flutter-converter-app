import 'package:flutter/material.dart';
import 'package:currencttempconverter/screen/currencyconv.dart';
import 'package:currencttempconverter/screen/tempconv.dart';


class ConversionItem {
  final String title;
  final Widget page;

  ConversionItem({required this.title, required this.page});
}

// Now you can use it
final List<ConversionItem> types = [
  ConversionItem(title: 'Currency', page: CurrencyConv()),
  ConversionItem(title: 'Temperature', page: TempConv()),
];

/*Map<String, List<String>> temp = [
  'Celsius'=[
    'toFahrenheit',
    'toKelvin',
  ],
  'Fahrenheit'=[
    'toCelsius',
    'toKelvin',
  ],
  'Kelvin'=[
    'toCelsius',
    'toFahrenheit',
  ],
];*/

Map<String, Map<String, Function(double)>> temp = {
  'Celsius': {
    'Fahrenheit': (double celsius) => (celsius * 9 / 5) + 32,
    'Kelvin': (double celsius) => celsius + 273.15,
  },
  'Fahrenheit': {
    'Celsius': (double fahrenheit) => (fahrenheit - 32) * 5 / 9,
    'Kelvin': (double fahrenheit) => ((fahrenheit - 32) * 5 / 9) + 273.15,
  },
  'Kelvin': {
    'Celsius': (double kelvin) => kelvin - 273.15,
    'Fahrenheit': (double kelvin) => ((kelvin - 273.15) * 9 / 5) + 32,
  },
};
