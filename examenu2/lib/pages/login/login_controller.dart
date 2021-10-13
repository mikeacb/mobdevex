import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fzregex/utils/fzregex.dart';
import 'package:fzregex/utils/pattern.dart';

class LoginController {
  // Se tienen que poner púbilcas para que las pueda usar la vista
  String pass = "";
  String email = "";
  String en = "";
  var formKey = GlobalKey<FormState>();
  //Para que se inizialice tarde
  late BuildContext context;
  late FirebaseAuth _auth;
  //Nos regresa un valor de tipo Future
  //Sirve para vincular la vista con el controlador
  Future init(BuildContext context) async {
    this.context = context;
    this._auth = FirebaseAuth.instance;
    print(_auth.currentUser == null);
  }

  void login() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      _auth
          .signInWithEmailAndPassword(email: email, password: pass)
          .then((value) => print(_auth.currentUser!.uid));
      if (Fzregex.hasMatch(email, FzPattern.email) == false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text("No parece un email correcto"),
              )
            ],
          ),
          duration: Duration(seconds: 2),
        ));
      } else if (en == en && email == email) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.green,
          content: Row(
            children: [
              Icon(
                Icons.check,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text("Bienvenido de Vuelta"),
              )
            ],
          ),
          duration: Duration(seconds: 2),
        ));
        Timer(Duration(seconds: 2), () {
          // Esto es para que se quiten los elementos del stack
          // y no se regrese al login
          Navigator.of(context).pushReplacementNamed('Home');
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.white,
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text("Usuario y/o contraseña incorrectos!"),
              )
            ],
          ),
          duration: Duration(seconds: 2),
        ));
        pass = "";
      }
    } else {
      print("no válido");
    }
  }
}
