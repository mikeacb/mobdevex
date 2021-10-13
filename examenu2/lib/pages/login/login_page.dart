import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:examenu2/pages/login/login_controller.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/material.dart';
import 'package:examenu2/components/background.dart';
import 'package:examenu2/pages/register/register_page.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Variable privada
  LoginController _controller = LoginController();
  // Variables para guardar los datos del registro
  String user = "";
  String pass = "";
  String email = "";
  String en = "";

  @override
  void initState() {
    super.initState();
    _cargarDatos();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // Puede que se den errores, porque se ejecuta antes que la vista
    // Para eso agregamos la siguiente función,
    // que se ejecuta después de la primera llamada del Build Method
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _controller.init(context);
    });
  }

  // Encriptación y Desencriptación de la contraseña (o cualquier otro texto)
  _encryptPass(String pass) {
    final plainText = pass;
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(8);
    final encrypter = encrypt.Encrypter(encrypt.Salsa20(key));
    final encrypted = encrypter.encrypt(plainText, iv: iv);
    _controller.en = encrypted.toString();
  }

  // Cargar los datos del registro para que se pueda accedar al Home
  _cargarDatos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = prefs.getString('usuario').toString();
      pass = prefs.getString('contraseña').toString();
      email = prefs.getString('email').toString();
      en = prefs.getString('encrypt').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        // Formulario
        child: Form(
          key: _controller.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Título
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "LOGIN",
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
              // Usuario
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    validator: (value) => value.toString().isEmpty
                        ? "Usuario es obligatorio"
                        : null,
                    onSaved: (value) =>
                        this._controller.user = value.toString(),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person), labelText: "Usuario"),
                  )),
              SizedBox(
                height: size.height * 0.03,
              ),
              // Correo
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    validator: (value) => value.toString().isEmpty
                        ? "El email es obligatorio"
                        : null,
                    onSaved: (value) =>
                        this._controller.email = value.toString(),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email), labelText: "Email"),
                  )),
              SizedBox(
                height: size.height * 0.03,
              ),
              // Contraseña
              Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value.toString().isEmpty) {
                        return "La contraseña es obligatoria";
                      } else {
                        this._controller.pass = value.toString();
                        _encryptPass(_controller.pass);
                      }
                    },
                    onSaved: (value) => value.toString(),
                    decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock), labelText: "Contraseña"),
                  )),
              //Recuperación de la contraseña
              Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Text(
                    "¿Se te olvidó la contraseña?",
                    style: TextStyle(fontSize: 12, color: Color(0xFF2661FA)),
                  )),
              SizedBox(
                height: size.height * 0.05,
              ),
              //Botón para entrar al Home
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: ElevatedButton(
                    onPressed: () => _controller.login(),
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
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                    )),
              ),
              //Te lleva al registro de usuarios
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterPage()));
                  },
                  child: Text(
                    "¿No tienes una cuenta?, Registrate...",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
