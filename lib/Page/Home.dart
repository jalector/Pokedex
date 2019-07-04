import 'package:Pokedex/Model/Pokemon.dart';
import 'package:Pokedex/Provider/GlobalRequest.dart';
import 'package:Pokedex/Widgets/PokemonCard.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final GlobalRequest globalRequest = GlobalRequest();

  Home({Key key}) : super(key: key);

  List<PokemonCard> buildPokemonCards(List<Pokemon> pokedexInformation) {
    return List<PokemonCard>.generate(pokedexInformation.length, (i) {
      return PokemonCard(pokedexInformation[i]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
              future: globalRequest.getPokedex(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Pokemon>> snapshot) {
                Widget futureWidget;

                if (snapshot.hasData) {
                  var pokemonCards = this.buildPokemonCards(snapshot.data);
                  futureWidget = SliverGrid.extent(
                    maxCrossAxisExtent: 130,
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
