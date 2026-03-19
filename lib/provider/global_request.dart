import 'dart:convert';
import 'package:pokedex/model/pokemon.dart';
import 'package:http/http.dart' as http;

class GlobalRequest {
  Future<List<Pokemon>> getPokedex() async {
    List<Pokemon> answer = [];

    final uri = Uri.parse("https://www.pokemon.com/es/api/pokedex/kalos");
    http.Response response = await http.get(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );
    
    if (response.statusCode == 200) {
      List<dynamic> content = json.decode(response.body);
      answer = Pokemon.fromJSONCollection(content);
    }
    return answer;
  }
}
