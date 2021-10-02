import 'package:flutter/material.dart';
import 'package:examenu2/components/background.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  String _user = ""; //_ quiere decir que es privada
  String _pass = "";
  var _formKey = GlobalKey<FormState>();

  LoginPage({Key? key}) : super(key: key);

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
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              "Login",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2661FA),
                  fontSize: 36),
              textAlign: TextAlign.left,
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: TextFormField(
              validator: (value) =>
                  value.toString().isEmpty ? "El usuario es obligatorio" : null,
              onSaved: (value) => this._user = value.toString(),
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email), labelText: "Usuario"),
            ),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
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
          Container(
              alignment: Alignment.centerRight,
              margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: GestureDetector(
                  onTap: () {
                    print("Click en olvidé la contraseña!");
                  },
                  child: Text(
                    "¿Se te olvió la contraseña?",
                    style: TextStyle(fontSize: 12, color: Color(0xFF2661FA)),
                  ))),
          SizedBox(
            height: size.height * 0.05,
          ),
          Container(
            alignment: Alignment.centerRight,
            margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: ElevatedButton(
              onPressed: () {
                final form = _formKey.currentState;
                if (form!.validate()) {
                  print("Válido");
                  print(_user);
                  print(_pass);
                  form.save();
                  print(_user);
                  print(_pass);
                  if (_user == "mike" && _pass == "Mike06") {
                    //Mandar a home
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
                  "Entrar",
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
                print("Click en registrar!");
              },
              child: Text(
                "¿No tienes una cuenta?, registrate ...",
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
