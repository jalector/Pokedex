import 'package:Pokedex/Model/Pokemon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PokemonCard extends StatelessWidget {
  final Pokemon pokemon;

  PokemonCard(this.pokemon);

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
        color = Colors.red[600];
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

  Widget buildDialogChild(BuildContext context) {
    Color accent = PokemonCard.chooseByPokemonType(this.pokemon.type[0]);

    TextStyle title = TextStyle(fontWeight: FontWeight.bold);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: accent,
            ),
            child: Stack(
                fit: StackFit.passthrough, children: this.pokemonImageView()),
          ),
          Container(
            padding: EdgeInsets.all(10),
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

  List<Widget> pokemonImageView() {
    List<Widget> list = [];
    double offset = -50;
    list.add(
      Positioned(
        top: offset,
        left: offset,
        child: Image.asset(
          "assets/badges/${this.pokemon.type[0]}.png",
        ),
      ),
    );

    if (this.pokemon.type.length > 1) {
      list.add(
        Positioned(
          bottom: offset,
          right: offset,
          child: Image.asset(
            "assets/badges/${this.pokemon.type[1]}.png",
          ),
        ),
      );
    }

    list.add(PokemonImagenTapView(numberPokemon: this.pokemon.number));

    return list;
  }

  List<Widget> typeList() {
    List<Widget> list = [];

    for (String type in pokemon.type) {
      Color accent = PokemonCard.chooseByPokemonType(type);
      list.add(
        Container(
          margin: EdgeInsets.symmetric(horizontal: 2),
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
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
        fit: StackFit.expand,
        children: <Widget>[
          Card(
            color: Colors.orangeAccent,
            elevation: 1,
            child: Hero(
              tag: 'pokemonImage' + this.pokemon.id.toString(),
              child: Image.asset(
                  "assets/poke_pixel/pokemon_icon_${this.pokemon.number}_00.png"),
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
              child: Text(this.pokemon.number),
            ),
          )
        ],
      ),
    );
  }
}

class PokemonImagenTapView extends StatefulWidget {
  final String numberPokemon;

  PokemonImagenTapView({Key key, this.numberPokemon}) : super(key: key);

  _PokemonImagenTapViewState createState() => _PokemonImagenTapViewState();
}

class _PokemonImagenTapViewState extends State<PokemonImagenTapView> {
  bool showShiny = false;

  @override
  Widget build(BuildContext context) {
    var list = <Widget>[];

    if (this.showShiny) {
      list = [
        Image.asset(
            "assets/pokemon_icons/pokemon_icon_${widget.numberPokemon}_00.png"),
        Image.asset(
            "assets/pokemon_icons/pokemon_icon_${widget.numberPokemon}_00_shiny.png")
      ];
    } else {
      list = [
        Image.asset(
            "assets/pokemon_icons/pokemon_icon_${widget.numberPokemon}_00_shiny.png"),
        Image.asset(
            "assets/pokemon_icons/pokemon_icon_${widget.numberPokemon}_00.png"),
      ];
    }

    list.add(Positioned(
      bottom: 0,
      left: 0,
      child: Switch(
        value: showShiny,
        onChanged: (bool value) {
          setState(() {
            showShiny = value;
          });
        },
      ),
    ));

    return GestureDetector(
      onDoubleTap: changePokemon,
      child: Stack(fit: StackFit.passthrough, children: list),
    );
  }

  void changePokemon() {
    setState(() {
      this.showShiny = !this.showShiny;
    });
  }
}
