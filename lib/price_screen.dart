import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'api.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  API api = API();
  String selectedCurrency = 'USD';
  String btcValue = '?';
  String ethValue = '?';
  String ltcValue = '?';

  void getCryptoCoinPrices(String currency) async {
    try {
      Map data;

      data = await api.getCryptoCoinPrice('BTC', currency);
      double btcVal = data['value'];

      data = await api.getCryptoCoinPrice('ETH', currency);
      double ethVal = data['value'];

      data = await api.getCryptoCoinPrice('LTC', currency);
      double ltcVal = data['value'];

      setState(() {
        this.btcValue = btcVal.toStringAsFixed(2);
        this.ethValue = ethVal.toStringAsFixed(2);
        this.ltcValue = ltcVal.toStringAsFixed(2);
      });
    } on Exception catch (e) {
      print(e);
    }
  }

  void onCurrencyChanged(value) {
    setState(() {
      this.selectedCurrency = value;
    });

    this.getCryptoCoinPrices(this.selectedCurrency);
  }

  Widget getCurrencyPicker() {
    return Platform.isAndroid
        ? getAndroidCurrencyPicker()
        : getIOSCurrencyPicker();
  }

  Widget getAndroidCurrencyPicker() {
    return DropdownButton<String>(
      value: selectedCurrency,
      items: currenciesList.map((currency) {
        return DropdownMenuItem(
          child: Text(currency),
          value: currency,
        );
      }).toList(),
      onChanged: (value) {
        this.onCurrencyChanged(value);
      },
    );
  }

  Widget getIOSCurrencyPicker() {
    return CupertinoPicker(
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        String value = currenciesList[selectedIndex];
        this.onCurrencyChanged(value);
      },
      children: currenciesList.map((currency) {
        return Text(currency);
      }).toList(),
    );
  }

  @override
  void initState() {
    super.initState();

    this.getCryptoCoinPrices(this.selectedCurrency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = ${this.btcValue} ${this.selectedCurrency}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 ETH = ${this.ethValue} ${this.selectedCurrency}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 LTC = ${this.ltcValue} ${this.selectedCurrency}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: getCurrencyPicker(),
          )
        ],
      ),
    );
  }
}
