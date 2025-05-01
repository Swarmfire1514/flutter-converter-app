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

Map<String,Map<String,Function(double)>> currency = {
  'USD': {
    'NRS': (double usd) => usd * 133.33,
    'INR': (double usd) => usd * 82.0,
    'EUR': (double usd) => usd * 0.85,
    'AUD': (double usd) => usd * 1.4,
    'CAD': (double usd) => usd * 1.39,
    'GBP': (double usd) => usd * 0.75,
    'JPY': (double usd) => usd * 110.0,
    'CNY': (double usd) => usd * 6.5,
    'NZD': (double usd) => usd * 1.5,
  },
  'NRS': {
    'USD': (double nrs) => nrs * 0.0075,
    'INR': (double nrs) => nrs * 0.6,
    'EUR': (double nrs) => nrs * 0.0063,
    'AUD': (double nrs) => nrs * 0.011,
    'CAD': (double nrs) => nrs * 0.0094,
    'GBP': (double nrs) => nrs * 0.0056,
    'JPY': (double nrs) => nrs * 0.75,
    'CNY': (double nrs) => nrs * 0.045,
    'NZD': (double nrs) => nrs * 0.012,
  },
  'INR': {
    'USD': (double inr) => inr * 0.012,
    'NRS': (double inr) => inr * 1.67,
    'EUR': (double inr) => inr * 0.011,
    'AUD': (double inr) => inr * 0.017,
    'CAD': (double inr) => inr * 0.014,
    'GBP': (double inr) => inr * 0.0092,
    'JPY': (double inr) => inr * 1.5,
    'CNY': (double inr) => inr * 0.075,
    'NZD': (double inr) => inr * 0.018,
  },
  'EUR': {
    'USD': (double eur) => eur * 1.18,
    'NRS': (double eur) => eur * 158.73,
    'INR': (double eur) => eur * 90.0,
    'AUD': (double eur) => eur * 1.65,
    'CAD': (double eur) => eur * 1.5,
    'GBP': (double eur) => eur * 0.88,
    'JPY': (double eur) => eur * 130.0,
    'CNY': (double eur) => eur * 7.5,
    'NZD': (double eur) => eur * 1.75,
  },
  'AUD': {
    'USD': (double aud) => aud * 0.71,
    'NRS': (double aud) => aud * 87.5,
    'INR': (double aud) => aud * 59.0,
    'EUR': (double aud) => aud * 0.61,
    'CAD': (double aud) => aud * 0.91,
    'GBP': (double aud) => aud * 0.53,
    'JPY': (double aud) => aud * 85.0,
    'CNY': (double aud) => aud * 4.5,
    'NZD': (double aud) => aud * 1.1,
  },
  'CAD': {
    'USD': (double cad) => cad * 0.72,
    'NRS': (double cad) => cad * 100.0,
    'INR': (double cad) => cad * 70.0,
    'EUR': (double cad) => cad * 0.67,
    'AUD': (double cad) => cad * 1.1,
    'GBP': (double cad) => cad * 0.59,
    'JPY': (double cad) => cad * 75.0,
    'CNY': (double cad) => cad * 4.0,
    'NZD': (double cad) => cad * 1.2,
  },
  'GBP': {
    'USD': (double gbp) => gbp * 1.33,
    'NRS': (double gbp) => gbp * 178.57,
    'INR': (double gbp) => gbp * 108.0,
    'EUR': (double gbp) => gbp * 1.14,
    'AUD': (double gbp) => gbp * 1.89,
    'CAD': (double gbp) => gbp * 1.69,
    'JPY': (double gbp) => gbp * 127.0,
    'CNY': (double gbp) => gbp * 7.2,
    'NZD': (double gbp) => gbp * 2.0,
  },
  'JPY': {
    'USD': (double jpy) => jpy * 0.0091,
    'NRS': (double jpy) => jpy * 13.33,
    'INR': (double jpy) => jpy * 0.67,
    'EUR': (double jpy) => jpy * 0.0077,
    'AUD': (double jpy) => jpy * 0.012,
    'CAD': (double jpy) => jpy * 0.013,
    'GBP': (double jpy) => jpy * 0.0079,
    'CNY': (double jpy) => jpy * 0.055,
    'NZD': (double jpy) => jpy * 0.015,
  },
  'CNY': {
    'USD': (double cny) => cny * 0.15,
    'NRS': (double cny) => cny * 22.22,
    'INR': (double cny) => cny * 13.33,
    'EUR': (double cny) => cny * 0.13,
    'AUD': (double cny) => cny * 0.22,
    'CAD': (double cny) => cny * 0.25,
    'GBP': (double cny) => cny * 0.14,
    'JPY': (double cny) => cny * 18.18,
    'NZD': (double cny) => cny * 0.3,
  },
  'NZD': {
    'USD': (double nzd) => nzd * 0.67,
    'NRS': (double nzd) => nzd * 83.33,
    'INR': (double nzd) => nzd * 55.0,
    'EUR': (double nzd) => nzd * 0.57,
    'AUD': (double nzd) => nzd * 0.91,
    'CAD': (double nzd) => nzd * 0.83,
    'GBP': (double nzd) => nzd * 0.5,
    'JPY': (double nzd) => nzd * 75.0,
    'CNY': (double nzd) => nzd * 3.33,
  },
};
