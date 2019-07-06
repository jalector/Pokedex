import 'package:Pokedex/Model/Pokemon.dart';
import 'package:flutter/material.dart';

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
                      fontSize: 60,
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
