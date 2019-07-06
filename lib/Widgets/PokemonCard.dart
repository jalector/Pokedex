import 'package:Pokedex/Model/Pokemon.dart';
import 'package:Pokedex/Page/PokemonDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  PokemonCard(this.pokemon);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                elevation: 1.0,
                backgroundColor: Colors.transparent,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.green,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FadeInImage.assetNetwork(
                        image: this.pokemon.thumbnailImage,
                        imageSemanticLabel: "Pokemon",
                        placeholderSemanticLabel: "Loading",
                        placeholderScale: 0.7,
                        placeholder: 'assets/load_pokeball.gif',
                      ),
                      Text(
                        this.pokemon.name,
                        style: TextStyle(fontSize: 20),
                      )
                    ],
                  ),
                ),
              );
            });
      },
      onDoubleTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return PokemonDetail(pokemon: this.pokemon);
        }));
      },
      child: Stack(
        children: <Widget>[
          Card(
            color: Colors.orangeAccent,
            elevation: 1,
            child: Hero(
              tag: 'pokemonImage' + this.pokemon.id.toString(),
              child: FadeInImage.assetNetwork(
                image: this.pokemon.thumbnailImage,
                imageSemanticLabel: "Pokemon",
                placeholderSemanticLabel: "Loading",
                placeholderScale: 0.7,
                placeholder: 'assets/load_pokeball.gif',
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(this.pokemon.name),
            ),
          )
        ],
      ),
    );
  }
}
