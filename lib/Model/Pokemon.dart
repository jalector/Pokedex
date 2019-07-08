class Pokemon {
  int id;
  String name;
  String number;
  String thumbnailImage;
  List<String> type;

  Pokemon({this.id, this.name, this.number, this.type}) {
    if (this.number != null) {
      this.thumbnailImage =
          "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/$number.png";
    }
  }

  static Pokemon fromJSON(Map<String, dynamic> json) {
    Pokemon pokemon = Pokemon(
        id: json["id"],
        name: json["name"],
        number: json["number"],
        type: json["types"]);

    return pokemon;
  }

  static List<Pokemon> fromJSONCollection(List json, {int limit = 300}) {
    List<Pokemon> list = [];

    for (var i = 0; i < limit; i++) {
      var pokemon = Pokemon.fromJSON(json[i]);
      if (i > 0) {
        if (list.last.number == pokemon.number) continue;
        pokemon.id = i;
        list.add(pokemon);
      } else {
        pokemon.id = i;
        list.add(pokemon);
      }
    }

    return list;
  }
}
