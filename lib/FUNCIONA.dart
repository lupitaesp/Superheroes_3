import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:flutter/services.dart';

// bibli
//https://medium.com/@mohammedijas/circle-image-avatar-with-border-in-flutter-513cdf82df43
//https://medium.com/@suragch/a-complete-guide-to-flutters-listtile-597a20a3d449
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget{
  @override
  _myHomePageState createState()=> new _myHomePageState();

}

class HomePage1 extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<homePage> {

  //Metodo Asincrono para leer JSON
  Future<String> _loadAsset() async{
    return await rootBundle.loadString('assets/personajes.json');
  }

  Future<List<heroes>> _getHeroes() async{
    String jsonString = await _loadAsset();
    var jsonData = json.decode(jsonString);
    print(jsonData.toString());

    List<heroes> heros = [];
    for(var h in jsonData){
      heroes he = heroes(h["img"], h["nombre"], h["identidad"],h["edad"],h["altura"],h["genero"],h["descripcion"]);
      heros.add(he);
    }
    print("Numero de elementos");
    print(heros.length);
    return heros;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(title: new Text("Super Heroes"),),
      body: Container(
        child: FutureBuilder(
          future: _getHeroes(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            if(snapshot.data == null){
              return Container(
                child: Center(
                  child: Text("Cargando...."),
                ),
              );
            }
            else{
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index){
                    print("Data Value:$snapshot.data[index].img.toString()");
                    return ListTile(
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data[index].img.toString())),
                      title: new Text(snapshot.data[index].nombre.toString()),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}


class heroes {
  final String img;
  final String nombre;
  final String identidad;
  final String edad;
  final String altura;
  final String genero;
  final String descripcion;

  heroes(this.img, this.nombre, this.identidad, this.edad, this.altura, this.genero, this.descripcion);
}


