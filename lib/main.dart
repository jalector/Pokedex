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
  final Provider provider = Provider();

  Home({Key key}) : super(key: key);

  List<PokemonCard> buildPokemonCards(List<Pokemon> pokedexInformation) {
    return List<PokemonCard>.generate(pokedexInformation.length, (i) {
      return PokemonCard(pokedexInformation[i]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            sliver: FutureBuilder<List<Pokemon>>(
              future: provider.getPokedex(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Pokemon>> snapshot) {
                Widget futureWidget;

                if (snapshot.hasData) {
                  var pokemonCards = this.buildPokemonCards(snapshot.data);
                  futureWidget = SliverGrid.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 3,
                    mainAxisSpacing: 3,
                    children: pokemonCards,
                  );
                } else {
                  futureWidget = SliverList(
                    delegate: SliverChildListDelegate([
                      Center(
                        widthFactor: 200,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(
                            semanticsLabel: "Loading",
                            semanticsValue: "Loading",
                            backgroundColor: Colors.orange[300],
                          ),
                        ),
                      ),
                    ]),
                  );
                }

                return futureWidget;
              },
            ),
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
        margin: EdgeInsets.all(5),
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
                tag: 'pokemonImage' + this.pokemon.id.toString(),
                child: FadeInImage.assetNetwork(
                  image: this.pokemon.thumbnailImage,
                  placeholder: 'assets/load_pokeball.gif',
                ),
              ),
              Center(
                child: Text(
                  this.pokemon.name,
                  style: TextStyle(
                      color: Colors.white54,
                      fontSize: 80,
                      fontWeight: FontWeight.bold),
                ),
              )
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

  static List<Pokemon> fromJSONCollection(List json, {int limit = 300}) {
    List<Pokemon> list = [];

    for (var i = 0; i < limit; i++) {
      var pokemon = Pokemon.fromJSON(json[i]);
      pokemon.id = i;
      list.add(pokemon);
    }

    return list;
  }
}
