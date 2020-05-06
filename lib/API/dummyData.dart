import 'dart:convert';
import 'package:http/http.dart' as http;

class DummyData {
  static Future getData() async {
    String url = "https://jsonplaceholder.typicode.com/todos/1";
    var response = await http.get(url);
    return jsonDecode(response.body);
  }
}
