import 'package:Pokedex/Model/Pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  PokemonCard(this.pokemon);

  Widget buildDialogChild(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    Color accent = PokemonCard.chooseByPokemonType(this.pokemon.type[0]);

    TextStyle title = TextStyle(fontWeight: FontWeight.bold);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: accent,
            ),
            child: FadeInImage.assetNetwork(
              image: this.pokemon.thumbnailImage,
              imageSemanticLabel: "Pokemon",
              placeholderSemanticLabel: "Loading",
              placeholderScale: 0.7,
              placeholder: 'assets/load_pokeball.gif',
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            margin: EdgeInsets.all(10),
            width: width * 0.30,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  pokemon.name,
                  style: TextStyle(
                    color: accent,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Row(
                  children: typeList(),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Weight",
                        style: title,
                      ),
                      flex: 1,
                    ),
                    Text(pokemon.weight.toString()),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        "Height",
                        style: title,
                      ),
                      flex: 1,
                    ),
                    Text(pokemon.height.toString()),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Weakness types",
                  style: title,
                ),
                Container(
                  child: Wrap(
                    direction: Axis.horizontal,
                    children: weaknewssList(),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> typeList() {
    List<Widget> list = [];

    for (String type in pokemon.type) {
      Color accent = PokemonCard.chooseByPokemonType(type);
      list.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
          decoration: BoxDecoration(
            color: accent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(type),
        ),
      );
    }

    return list;
  }

  List<Widget> weaknewssList() {
    List<Widget> list = [];

    for (String type in pokemon.weakness) {
      var cont = Container(
        margin: EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
        decoration: BoxDecoration(
          color: Colors.black45,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          type,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

      list.add(cont);
    }

    return list;
  }

  static Color chooseByPokemonType(String type) {
    Color color = Colors.blue;
    switch (type) {
      case "grass":
        color = Colors.green;
        break;
      case "bug":
        color = Colors.greenAccent;
        break;
      case "dark":
        color = Colors.brown[800];
        break;
      case "dragon":
        color = Colors.purple;
        break;
      case "electric":
        color = Colors.yellow;
        break;
      case "fairy":
        color = Colors.pink[200];
        break;
      case "fighting":
        color = Colors.brown[700];
        break;
      case "fire":
        color = Colors.red;
        break;
      case "flying":
        color = Colors.blue;
        break;
      case "ghost":
        color = Colors.purple;
        break;
      case "ground":
        color = Colors.brown[200];
        break;
      case "ice":
        color = Colors.cyan[300];
        break;
      case "normal":
        color = Colors.black38;
        break;
      case "poison":
        color = Colors.purple;
        break;
      case "psychic":
        color = Colors.pink;
        break;
      case "rock":
        color = Colors.brown[300];
        break;
      case "steel":
        color = Color.fromRGBO(160, 160, 160, 1.0);
        break;
      case "water":
        color = Colors.blue[600];
        break;
    }

    return color;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return Dialog(
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: this.buildDialogChild(context),
              );
            });
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
