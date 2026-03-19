class Pokemon {
  int id;
  String name;
  String number;
  double height;
  double weight;
  List<String> weakness;
  List<String> type;

  Pokemon({
    required this.id,
    required this.name,
    required this.weight,
    required this.height,
    this.number = '',
    this.weakness = const [],
    this.type = const [],
  });

  String? get thumbnailImage {
    return this.number.isNotEmpty
        ? "https://assets.pokemon.com/assets/cms2/img/pokedex/detail/$number.png"
        : null;
  }

  static Pokemon fromJSON(Map<String, dynamic> json) {
    var pokemon = Pokemon(
      id: json["id"],
      name: json["name"],
      number: json["number"],
      height: json["height"],
      weight: json["weight"],
      type: (json["type"] as List).map<String>((e) => e.toString()).toList(),
      weakness: (json["weakness"] as List)
          .map<String>((e) => e.toString())
          .toList(),
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
