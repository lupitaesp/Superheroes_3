import 'package:flutter/cupertino.dart';
import 'main.dart';
import 'package:super_heroes_2/main.dart';


class HeroHub {
  List<Hero> heroe;

  HeroHub({this.heroe});


  }
//jsonData = json.decode(jsonString);

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