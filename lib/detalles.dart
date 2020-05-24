import 'main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:super_heroes_2/main.dart';

class SuperDetail extends StatelessWidget {
  final heroes hero;

  SuperDetail(this.hero);
  //Declara un campo que contenga la clase

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: Text(hero.nombre),
          centerTitle: true,
          backgroundColor: Colors.redAccent[200],
          automaticallyImplyLeading: false,
      ),
      body: Stack(
            children: <Widget>[
              Positioned(
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 1.4,
                width: MediaQuery
                    .of(context)
                    .size
                    .width - 19,
                left: 10.0,
                top: MediaQuery
                    .of(context)
                    .size
                    .height * 0.12,
                child: Container(
                              child: SingleChildScrollView(
                                // ENCIERRA TODA LA CARTA, FUNCION DE FLUTTER, HACE QUE SE MUEVA LA TARJETA
                                child: Card(
                                  color: Colors.red[200],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0)),
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      SizedBox(
                                        height: 25.0,
                                      ),
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Hero(
                                          tag: hero.img,
                                            child: Container(
                                              height: 300.0,
                                              width: 300.0,
                                              decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage(hero.img),
                                                    fit: BoxFit.cover),
                                              ),
                                            )),
                                      ),
                                      new Padding(padding: EdgeInsets.all(20.0)),
                                      new Text(
                                          "Nombre:  ${hero.nombre}",
                                          style: TextStyle(
                                              fontSize: 25.0,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black)),
                                      new Text(
                                          "Identidad Secreta:  ${hero.identidad} ",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                      new Text(
                                          "Edad:  ${hero.edad}",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                      new Text(
                                          "Altura:  ${hero.altura}",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                      new Text(
                                          "Genero:  ${hero.genero}",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                      new Text(
                                          "Descripcion:  ${hero.descripcion}",
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold)),
                                      new Padding(padding: EdgeInsets.all(20.0)),
                                    ],
                                  ),
                                ),
                                //ORIENTACION DEL MOVIMIENTO
                                scrollDirection: Axis.vertical,
                                //PARA QUE REGRESE
                                reverse: false,
                              ),
                ),
              ),

          ],
    ),
        );
  }
}
