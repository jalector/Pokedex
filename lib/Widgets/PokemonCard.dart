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
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return PokemonDetail(pokemon: this.pokemon);
          }));
        },
        child: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.orange[200],
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Colors.orange[400],
                width: 2,
              ),
              image: DecorationImage(
                image: ExactAssetImage("assets/pokeball.png", scale: 3.5),
                alignment: Alignment(8, 8),
                fit: BoxFit.none,
              )),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: Text(
                  this.pokemon.number,
                  style: TextStyle(
                    color: Colors.black26,
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                bottom: -5,
                right: 0,
              ),
              Positioned(
                top: -20,
                right: 10,
                height: 170,
                width: 170,
                child: Hero(
                  tag: 'pokemonImage' + this.pokemon.id.toString(),
                  child: FadeInImage.assetNetwork(
                    image: this.pokemon.thumbnailImage,
                    placeholder: 'assets/load_pokeball.gif',
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
