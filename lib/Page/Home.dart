import 'package:Pokedex/Model/Pokemon.dart';
import 'package:Pokedex/Provider/GlobalRequest.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalRequest globalRequest = GlobalRequest();
  List<Pokemon> baseList;
  List<Pokemon> filterList;
  String searchedPokemon;
  TextEditingController searchedPokemonCtrl;
  PageController controller;
  int currentPage = 0;

  _HomeState() {
    this.searchedPokemon = "";
    this.baseList = [];
    this.filterList = [];
    this.searchedPokemonCtrl = new TextEditingController();
    this.controller = PageController(viewportFraction: 0.8);

    controller.addListener(() {
      int next = controller.page.round();
      if (currentPage != next) {
        setState(() {
          currentPage = next;
        });
      }
    });

    searchedPokemonCtrl.addListener(() {
      if (searchedPokemonCtrl.text.isEmpty) {
        currentPage = 0;
        setState(() {
          searchedPokemon = "";
          this.filterList = this.baseList;
        });
      } else {
        setState(() {
          searchedPokemon = searchedPokemonCtrl.text.toLowerCase();
          this.filterList = this.buildFiteredList();
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
    var list = await this.globalRequest.getPokedex();

    setState(() {
      this.baseList = list;
      this.filterList = this.baseList;
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

  List<Pokemon> buildFiteredList() {
    List<Pokemon> filtered = [];
    for (var pokemon in this.baseList) {
      if (pokemon.name.toLowerCase().contains(this.searchedPokemon)) {
        filtered.add(pokemon);
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
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            sliver: SliverGrid.extent(
              maxCrossAxisExtent: 210,
              crossAxisSpacing: 3,
              mainAxisSpacing: 3,
              children: [
                PageView.builder(
                  controller: controller,
                  itemCount: this.filterList.length,
                  itemBuilder: (context, int currentIndex) {
                    bool active = currentIndex == currentPage;
                    final double blur = active ? 30 : 0;
                    final double offset = active ? 20 : 0;
                    final double top = active ? 10 : 60;
                    final current = this.filterList[currentIndex];

                    return AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      margin: EdgeInsets.only(top: top, bottom: 50, right: 30),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.orange[300],
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            blurRadius: blur,
                            offset: Offset(offset, offset),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          current.name,
                          style: TextStyle(fontSize: 40, color: Colors.white),
                        ),
                      ),
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
