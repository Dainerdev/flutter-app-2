import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app_und4/main.dart';
import 'homeScreens/home.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';



class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

  // Obtener el id desde SharedPreferences
  Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId');
  }

  // funcion para comunicar con la api
  Future<Map<String, dynamic>> login(String ema, String pass) async {

    final apiUrl = Uri.parse('http://10.0.2.2:3312/api/users/login');

    final response = await http.post(apiUrl,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": ema, "password": pass}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al iniciar sesión.');
    }
  }

class _LoginScreenState extends State<LoginScreen> {
  // Identificadores de los textfields
  final email = TextEditingController();
  final password = TextEditingController();

  // Guardar el id en SharedPreferences
  Future<void> saveUserId(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', userId);
  }

  // funcion para validaciones con la respuesta de la api
  Future<void> _useLogin() async {
    final ema = email.text;
    final pass = password.text;

    try {
      final result = await login(ema, pass);

      if (result.containsKey('id')) {
        // Usuario existe
        // Guardar el id del usuario
        await saveUserId(result['id'].toString());

        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
            barrierDismissible: false,
            barrierColor: Color.fromARGB(180, 0, 0, 0),
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Notificación!',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  content: SingleChildScrollView(
                    child: ListBody(
                      children: [
                        Text(
                          'Inicio de sesión exitoso.',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        Text('Bienvenido(a) ${result['names']}',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                            const HomeScreen()),
                      );
                    },
                    child: Text(
                      'Continuar',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              );
            }
          );
      } else {
        // Usuario no existe
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          barrierDismissible: false,
          barrierColor: Color.fromARGB(180, 0, 0, 0),
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Notificación!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text(
                        'Credeniales incorrectas. Verifique e inténtelo nuevamente.',
                        style: TextStyle(fontSize: 16),
                      )
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Entiendo',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
                  ],
                );
              }
          );
      }

    } catch (error) {
      // error
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Inicia Sesión',
                style: TextStyle(
                  color: Color.fromARGB(255, 141, 74, 180),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              // Campo email
              TextField(
                controller: email,
                decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email_outlined),
                    labelText: 'Correo',
                    hintText: 'ejemplo.correo@gmail.com',
                    border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {},
              ),
              const SizedBox(height: 20),

              // Campo password
              TextField(
                controller: password,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.password_outlined),
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {},
                obscureText: true,
              ),
              const SizedBox(height: 30),
              // button
              ElevatedButton(
                onPressed: () {
                  //Guardar los datos en las variables
                  var ema = email.text;
                  var pass = password.text;

                  // Validar que los campos no esten vacios
                  if (ema == '' || pass == '') {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Color.fromARGB(180, 0, 0, 0),
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(
                              'Notificación!',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text(
                                    'Por favor, ingrese los datos de usuario.',
                                    style: TextStyle(fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    'Entiendo',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ],
                          );
                        }
                    );
                  
                  } else if (ema != '' && pass != '') {
                    //Validar que los datos pertenezcan a un usuario                    
                    _useLogin();
                    
                    login(ema, pass);                     
                  }

                  // Vaciar los campos
                  email.text = '';
                  password.text = '';
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 141, 74, 180),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MainApp()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 245, 230, 253),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text(
                  'Regresar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 141, 74, 180),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
