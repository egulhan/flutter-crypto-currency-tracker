import 'package:http/http.dart' as Http;
import 'dart:convert';

const String apiBaseURL =
    'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class API {
  Future<Map> getCryptoCoinPrice(String crypto, String currency) async {
    String url = apiBaseURL + '/short?crypto=$crypto&fiat=$currency';
    print(url);
    Http.Response response = await Http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      double value = data[crypto + currency]['last'];

      return {'crypto': crypto, 'currency': currency, 'value': value};
    } else {
      throw 'Could not fetch Crypto Coin prices!';
    }
  }
}
