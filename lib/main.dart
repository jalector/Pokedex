import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: new Home(),
    );
  }
}

class Home extends StatelessWidget {
  Provider provider;

  Home({Key key}) : super(key: key) {
    this.provider = Provider();

    this.provider.getPokedex();
  }

  List<PokemonCard> buildPokemonCards(List<Pokemon> pokedexInformation) {
    return List<PokemonCard>.generate(pokedexInformation.length, (i) {
      return PokemonCard(pokedexInformation[i]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            expandedHeight: 250.0,
            backgroundColor: Colors.orange[300],
            flexibleSpace: FlexibleSpaceBar(
                titlePadding: EdgeInsets.only(top: 10, bottom: 5),
                background: SafeArea(child: _HomeTitle()),
                title: _PokemonSearchBar()),
          ),
          FutureBuilder<List<Pokemon>>(
            future: provider.getPokedex(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Pokemon>> snapshot) {
              Widget futureWidget;

              if (snapshot.hasData) {
                var pokemonCards = this.buildPokemonCards(snapshot.data);
                futureWidget = SliverGrid.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  children: pokemonCards,
                );
              } else {
                futureWidget = SliverGrid.count(
                  crossAxisCount: 4,
                  crossAxisSpacing: 3,
                  mainAxisSpacing: 3,
                  children: [CircularProgressIndicator()],
                );
              }

              return futureWidget;
            },
          ),
        ],
      ),
    );
  }
}

class _HomeTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
          image: DecorationImage(
              image: ExactAssetImage("assets/pikachu_background.jpg"),
              fit: BoxFit.cover)),
      child: Text(
        "Gotta catch 'em all!",
        style: TextStyle(
            fontSize: 60.0, fontWeight: FontWeight.bold, color: Colors.white70),
      ),
    );
  }
}

class _PokemonSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          color: Colors.black87, borderRadius: BorderRadius.circular(15.0)),
      child: TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.orangeAccent),
          border: InputBorder.none,
          hintText: "Type your pokemon name..",
          hintStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white30),
        ),
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  PokemonCard(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return PokemonDetail(pokemon: this.pokemon);
        }));
      },
      child: Card(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Hero(
                tag: 'pokemonImage' + this.pokemon.id.toString(),
                child: FadeInImage.assetNetwork(
                  image: this.pokemon.thumbnailImage,
                  placeholder: 'assets/load_pokeball.gif',
                ),
              ),
              flex: 5,
            ),
            Expanded(
              child: Text(this.pokemon.name),
              flex: 1,
            )
          ],
        ),
      ),
    );
  }
}

class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon;

  PokemonDetail({Key key, @required this.pokemon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag: 'pokemonImage' + this.pokemon.number,
                child: FadeInImage.assetNetwork(
                  image: this.pokemon.thumbnailImage,
                  fit: BoxFit.contain,
                  placeholder: 'assets/load_pokeball.gif',
                ),
              ),
              Text(this.pokemon.name)
            ],
          ),
        ),
      ),
    );
  }
}

class Provider {
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

  static List<Pokemon> getPokedexInformation() {
    return <Pokemon>[
      Pokemon(1, "Bulbasaur", "001"),
      Pokemon(1, "Ivysaur", "002"),
      Pokemon(1, "Venusaur", "003"),
      Pokemon(1, "Charmander", "004"),
      Pokemon(1, "Charmeleon", "005"),
      Pokemon(1, "Charizard", "006"),
      Pokemon(1, "Squirtle", "007"),
      Pokemon(1, "Wartortle", "008"),
      Pokemon(1, "Blastoise", "009"),
      Pokemon(1, "Caterpie", "010"),
      Pokemon(1, "Metapod", "011"),
      Pokemon(1, "Butterfree", "012"),
      Pokemon(1, "Weedle", "013"),
      Pokemon(1, "Kakuna", "014"),
      Pokemon(1, "Beedrill", "015"),
      Pokemon(1, "Pidgey", "016"),
      Pokemon(1, "Pidgeotto", "017"),
      Pokemon(1, "Pidgeot", "018"),
      Pokemon(1, "Ratta", "019"),
      Pokemon(1, "Raticate", "020"),
      Pokemon(1, "Spearow", "021"),
      Pokemon(1, "Ferow", "022"),
      Pokemon(1, "Ecans", "023"),
      Pokemon(1, "Arbok", "024"),
      Pokemon(1, "Pikachu", "025"),
      Pokemon(1, "Raichu", "026"),
      Pokemon(1, "Sandshrew", "027"),
      Pokemon(1, "Sandlash", "028"),
      Pokemon(1, "Nidoran", "029"),
      Pokemon(1, "Nidorina", "031"),
      Pokemon(1, "Nidoqueen", "032"),
      Pokemon(1, "Nidoran", "033"),
      Pokemon(1, "Nidorino", "034"),
      Pokemon(1, "NidoKing", "035"),
    ];
  }
}

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

  static List<Pokemon> fromJSONCollection(List json) {
    List<Pokemon> list = [];
    int i = 0;
    for (var wildPokemon in json) {
      var pokemon = Pokemon.fromJSON(wildPokemon);
      pokemon.id = i++;
      list.add(pokemon);
    }

    return list;
  }
}
