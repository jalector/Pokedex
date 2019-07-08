class Pokemon {
  int id;
  String name;
  String number;
  double height;
  double weight;
  List<String> weakness;
  String thumbnailImage;
  List<String> type;

  Pokemon({
    this.id,
    this.name,
    this.number,
    this.type,
    this.weight,
    this.height,
    this.weakness,
  }) {
    if (this.number != null) {
      this.thumbnailImage =
          "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/$number.png";
    }
    if (this.weakness == null) {
      this.weakness = [];
    }
    if (this.type == null) {
      this.type = [];
    }
  }

  static Pokemon fromJSON(Map<String, dynamic> json) {
    var pokemon = Pokemon(
      id: json["id"],
      name: json["name"],
      number: json["number"],
      height: json["height"],
      weight: json["weight"],
    );

    for (var type in json["type"]) {
      pokemon.type.add(type.toString());
    }

    for (var weak in json["weakness"]) {
      pokemon.weakness.add(weak.toString());
    }

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
