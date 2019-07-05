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
        showGeneralDialog(
            barrierColor: Colors.black.withOpacity(0.5),
            transitionBuilder: (context, a1, a2, widget) {
              return Transform.scale(
                scale: a1.value,
                child: Opacity(
                  opacity: a1.value,
                  child: AlertDialog(
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    title: Text(pokemon.name),
                    content: Text(pokemon.number),
                  ),
                ),
              );
            },
            transitionDuration: Duration(milliseconds: 200),
            barrierDismissible: true,
            barrierLabel: '',
            context: context,
            pageBuilder: (context, animation1, animation2) {});
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
            elevation: 3,
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
/**
 * 
 Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.orange[200],
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Colors.orange[400],
                  width: 2,
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Text(
                      this.pokemon.number,
                      style: TextStyle(
                        color: Colors.black26,
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    top: -10,
                    left: -10,
                  ),
                  Positioned(
                    bottom: -50,
                    left: 20,
                    height: 160,
                    width: 160,
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
            );
 */
