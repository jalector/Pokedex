class Pokemon {
  int id;
  String name;
  String number;
  String thumbnailImage;

  Pokemon(int id, String name, String number) {
    this.id = id;
    this.name = name;
    this.number = number;
    this.thumbnailImage =
        "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/$number.png";
  }

  static Pokemon fromJSON(Map<String, dynamic> json) {
    return Pokemon(
      json["id"],
      json["name"],
      json["number"],
    );
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
