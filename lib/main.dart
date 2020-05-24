import 'package:flutter/material.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:splashscreen/splashscreen.dart';
import 'package:flutter/services.dart';
import 'package:super_heroes_2/detalles.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';

void main() => runApp(MaterialApp(
      home: new MyApp(),
      theme: ThemeData(brightness: Brightness.dark, fontFamily: 'Center'),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      image: Image.network(
        "https://www.stickpng.com/assets/images/585f9357cb11b227491c3582.png",
      ),
      photoSize: 200.0,
      seconds: 15,
      backgroundColor: Colors.white,
      title: new Text(
        'Bienvenido',
        style: new TextStyle(
            fontWeight: FontWeight.bold, fontSize: 40.0, color: Colors.red),
      ),
      navigateAfterSeconds: new AfterSplash(),
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
// TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false, //BANER DE DEPURACION
      theme:
          ThemeData(brightness: Brightness.light, primarySwatch: Colors.cyan),
      darkTheme: ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.blueGrey),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _myHomePageState createState() => new _myHomePageState();
}

class _myHomePageState extends State<homePage> {
  //Metodo Asincrono para leer JSON
  Future<String> _loadAsset() async {
    return await rootBundle.loadString('assets/personajes.json');
  }

  Future<List<heroes>> _getHeroes() async {
    String jsonString = await _loadAsset();
    var jsonData = json.decode(jsonString);
    print(jsonData.toString());

    List<heroes> heros = [];
    for (var h in jsonData) {
      heroes he = heroes(h["img"], h["nombre"], h["identidad"], h["edad"],
          h["altura"], h["genero"], h["descripcion"]);
      heros.add(he);
    }
    print("Numero de elementos");
    print(heros.length);
    return heros;
  }

  String _searchText = "";
  final TextEditingController _search = new TextEditingController();
  Widget _appBarTitle = new Text("Super Heroes");
  bool _typing = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  AudioPlayer audioPlayer;
  AudioCache audioCache;

  final audioname = "audio2.mp3";

  @override
  void initState() {
    super.initState();

    audioPlayer = AudioPlayer();
    audioCache = AudioCache();
    var loop = 1;

    setState(() {
      audioCache.play(audioname);
    });
  }

  String search = "";
  bool _Searching = false;
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.redAccent[200],
        centerTitle: true,
        title: _Searching
            ? TextField(
                decoration:
                    InputDecoration(hintText: "Buscando un superheroe...."),
                onChanged: (value) {
                  setState(() {
                    search = value;
                  });
                },
                controller: searchController,
              )
            : Text("Superheroes"),
        actions: <Widget>[
          !_Searching
              ? IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    setState(() {
                      search = "";
                      this._Searching = !this._Searching;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    setState(() {
                      this._Searching = !this._Searching;
                    });
                  },
                )
        ],
      ),
      body: Container(
        child: FutureBuilder(
          future: _getHeroes(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("Cargando...."),
                ),
              );
            } else {
              return ListView.builder(
                  scrollDirection: Axis.vertical, //ROTACION
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return snapshot.data[index].nombre.contains(search)
                        ? ListTile(
                            trailing: Icon(Icons.keyboard_arrow_right),
                            //AGREGA LAS FLECHAS DE LA DERECHA
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.0, horizontal: 15.0),
                            leading: CircleAvatar(
                                minRadius: 30.0, //Diseño de la bolita
                                maxRadius: 30.0,
                                backgroundImage: NetworkImage(
                                  snapshot.data[index].img
                                      .toString(), //Linea de la imagen
                                )),
                            title: new Text(
                              snapshot.data[index].nombre.toString(),
                              style: TextStyle(fontSize: 20.0),
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          SuperDetail(snapshot.data[index])));
                            },
                          )
                        : Container();
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

  heroes(this.img, this.nombre, this.identidad, this.edad, this.altura,
      this.genero, this.descripcion);
}
