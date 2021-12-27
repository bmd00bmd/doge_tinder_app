import 'lib/core/api/doge_api.dart';
import 'package:http/http.dart' as http;

void main() async {
  testRandomDoges();
  print('end of scratch.dart');
}

void testRandomDoges() async {
  final DogeApi dogeApi = DogeApi(httpClient: http.Client());
  var result = await dogeApi.fetchRandomDogeImages(4);
  print(result);
}
