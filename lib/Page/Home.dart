import 'package:Pokedex/Model/Pokemon.dart';
import 'package:Pokedex/Provider/GlobalRequest.dart';
import 'package:Pokedex/Widgets/PokemonCard.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalRequest globalRequest = GlobalRequest();
  List<PokemonCard> baseList;
  List<PokemonCard> filterList;
  String searchedPokemon;
  TextEditingController searchedPokemonCtrl;

  _HomeState() {
    this.searchedPokemon = "";
    this.baseList = [];
    this.filterList = [];

    this.searchedPokemonCtrl = new TextEditingController();

    searchedPokemonCtrl.addListener(() {
      if (searchedPokemonCtrl.text.isEmpty) {
        setState(() {
          searchedPokemon = "";
          filterList = baseList;
        });
      } else {
        setState(() {
          searchedPokemon = searchedPokemonCtrl.text.toLowerCase();
        });
      }
    });
  }

  @override
  void initState() {
    this._getPokedex();
    super.initState();
  }

  void _getPokedex() async {
    var list = this.buildPokemonCards(await this.globalRequest.getPokedex());

    setState(() {
      this.baseList = list;
      this.filterList = this.baseList;
    });
  }

  List<PokemonCard> buildPokemonCards(List<Pokemon> pokedexInformation) {
    return List<PokemonCard>.generate(pokedexInformation.length, (i) {
      return PokemonCard(pokedexInformation[i]);
    });
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
          color: Colors.black87, borderRadius: BorderRadius.circular(15.0)),
      child: TextField(
        controller: searchedPokemonCtrl,
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

  Widget _buildTitle() {
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

  List<PokemonCard> buildFiteredList() {
    List<PokemonCard> filtered = [];
    for (var card in this.baseList) {
      if (card.pokemon.name.toLowerCase().contains(this.searchedPokemon)) {
        filtered.add(card);
      }
    }
    return filtered;
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
              background: SafeArea(
                child: _buildTitle(),
              ),
              title: _buildSearchBar(),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            sliver: SliverGrid.extent(
              maxCrossAxisExtent: 75,
              crossAxisSpacing: 2,
              mainAxisSpacing: 2,
              children: this.buildFiteredList(),
            ),
          ),
        ],
      ),
    );
  }
}
