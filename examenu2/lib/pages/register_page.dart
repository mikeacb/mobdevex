import 'dart:async';
import 'package:fzregex/fzregex.dart';
import 'package:flutter/material.dart';
import 'package:examenu2/components/background.dart';
import 'package:examenu2/pages/login_page.dart';
import 'package:fzregex/utils/pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  //_ quiere decir que es privada
  String _name = "";
  String _user = "";
  String _pass = "";
  String _temppass = ""; //Comprobación que las contraseñas coincidan
  String _email = ""; //Validación del email

  var _formKey = GlobalKey<FormState>();

  RegisterPage({Key? key}) : super(key: key);

  _setState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('nombre', _name);
    prefs.setString('usuario', _user);
    prefs.setString('contraseña', _pass);
    prefs.setString('email', _email);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Background(
            child: Form(
      key: _formKey,
      //Formulario
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: size.height * 0.10,
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Sing in",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2661FA),
                  fontSize: 26),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          //Nombre
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              validator: (value) =>
                  value.toString().isEmpty ? "El nombre es obligatorio" : null,
              onSaved: (value) => this._name = value.toString(),
              //onChanged: (nam) => this._name = nam,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person), labelText: "Nombre completo"),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          //Usuario
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              validator: (value) =>
                  value.toString().isEmpty ? "El usuario es obligatorio" : null,
              onSaved: (value) => this._user = value.toString(),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.person_outlined),
                  labelText: "Usuario"),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          //Email
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              validator: (value) =>
                  value.toString().isEmpty ? "El email es obligatorio" : null,
              onSaved: (value) => this._email = value.toString(),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email), labelText: "Email"),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          //Contraseña
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              obscureText: true,
              validator: (value) => value.toString().isEmpty
                  ? "La contraseña es obligatorio"
                  : null,
              onSaved: (value) => this._pass = value.toString(),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock), labelText: "Contraseña"),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          //Verificar la contraseña
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              obscureText: true,
              validator: (value) {
                if (value.toString().isEmpty) {
                  return "Reescribe la contraseña";
                } else {
                  if (_pass != _temppass) {
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
                            child: Text("Las contraseñas no son iguales"),
                          )
                        ],
                      ),
                      duration: Duration(seconds: 2),
                    ));
                  } else {
                    this._temppass = value.toString();
                  }
                }
              },
              onSaved: (value) => value.toString(),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  labelText: "Reescribir la contraseña"),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          //Botón de guardar
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                _setState();
                final form = _formKey.currentState;
                if (form!.validate()) {
                  form.save();
                  if (Fzregex.hasMatch(_email, FzPattern.email) == false) {
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
                  } else if (_pass == _temppass) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Row(children: [
                          Icon(
                            Icons.verified_user,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text("Registro exitoso"),
                          )
                        ])));
                    Timer(Duration(seconds: 1), () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Row(children: [
                          Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Text("Usuario y/o contraseña incorrectos"),
                            //duration: Duration(seconds: 2),
                          )
                        ])));
                  }
                } else {
                  print("No válido");
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80)),
                padding: EdgeInsets.all(0),
              ),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: size.width * 0.50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    gradient: LinearGradient(colors: [
                      Color.fromARGB(255, 255, 136, 34),
                      Color.fromARGB(255, 255, 177, 41)
                    ])),
                child: Text(
                  "Guardar",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: GestureDetector(
              onTap: () {
                print("Click en guardar");
                Navigator.pop(context);
                //Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                "Regresar al login",
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2661FA)),
              ),
            ),
          )
        ],
      ),
    )));
  }
}
