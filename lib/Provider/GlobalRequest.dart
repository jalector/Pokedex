import 'dart:convert';
import 'package:Pokedex/Model/Pokemon.dart';
import 'package:http/http.dart' as http;

class GlobalRequest {
  Future<List<Pokemon>> getPokedex() async {
    List<Pokemon> answer = [];

    http.Response response =
        await http.get("https://www.pokemon.com/es/api/pokedex/kalos");
    if (response.statusCode == 200) {
      List<dynamic> content = json.decode(response.body);
      answer = Pokemon.fromJSONCollection(content);
    }
    return answer;
  }
}