import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_und4/main.dart';
import 'login.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  // Identificadores de los textfields
  final userField = TextEditingController();
  final emailField = TextEditingController();
  final passwordField = TextEditingController();
  final passConfirmField = TextEditingController();
  final namesField = TextEditingController();
  final lastNamesField = TextEditingController();
  final countryField = TextEditingController();
  final cityField = TextEditingController();   

  //variables
  String user = '';
  String email = '';
  String pass = '';
  String passConfirm = '';
  String names = '';
  String lastNames = '';
  String country = '';
  String city = '';

  // funcion para comunicar con la api
  Future<void> register() async {

    final apiUrl = Uri.parse('http://10.0.2.2:3312/api/users/');

    //Mapa de los datos del usuario
    final Map<String, dynamic> userData ={
      "username": userField.text,
      "email": emailField.text,
      "password": passwordField.text,
      "names": namesField.text,
      "lastNames": lastNamesField.text,
      "country": countryField.text,
      "city": cityField.text,
    };

    try {
      
      // Solicitud POST a la API
      final response = await http.post(apiUrl,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(userData),
      );

      if (response.statusCode == 200) {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          barrierDismissible: false,                      
          barrierColor: Color.fromARGB(180, 0, 0, 0),
          builder: (BuildContext context){
            return AlertDialog(
              title: Text('Notificación!',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text('Usuario registrado exitosamente. ¿Desea iniciar sesión?',
                      style: TextStyle(
                        fontSize: 16
                      ),
                    )
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const MainApp())
                    );
                  }, 
                  child: Text('Salir',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const LoginScreen())
                    );
                  }, 
                  child: Text('Continuar',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  )
                ),
              ],
            );
          }
        );
      } else {
        showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text("No se pudo registrar el usuario. Inténtelo nuevamente."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("Entendido"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  //Alerta para Confirmara que desea regresar
  Future<bool> _exitConfirmation() async {
    return await showDialog(
          context: context,
          barrierDismissible: false,                      
          barrierColor: Color.fromARGB(180, 0, 0, 0),
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('¿Deseas regresar?',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              content: const Text('Los datos ingresados se perderán.',
                style: TextStyle(
                  fontSize: 16
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cancela y no regresa
                  },
                  child: const Text('Cancelar',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Confirma y regresa
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MainApp()));

                    // Vaciar los campos
                    userField.text = '';
                    emailField.text = '';
                    passwordField.text = '';
                    passConfirmField.text = '';
                    namesField.text = '';
                    lastNamesField.text = '';
                    countryField.text = '';
                    cityField.text = '';
                  },
                  child: const Text('Regresar',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 90.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Resístrate',
                style: TextStyle(
                  color: Color.fromARGB(255, 141, 74, 180),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: userField,
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: emailField,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo', 
                  hintText: 'ejemplo.correo@gmail.com',
                  border: OutlineInputBorder(),
                )
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordField,
                decoration: const InputDecoration(
                  labelText: 'Contraseña',
                    border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passConfirmField,
                decoration:
                  const InputDecoration(
                    labelText: 'Confirmar contraseña',
                    border: OutlineInputBorder(),
                  ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: namesField,
                decoration: const InputDecoration(
                  labelText: 'Nombre(s)',
                    border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: lastNamesField,
                decoration: const InputDecoration(
                  labelText: 'Apellido(s)',
                    border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: countryField,
                decoration: const InputDecoration(
                  labelText: 'País',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: cityField,
                decoration: const InputDecoration(
                  labelText: 'Ciudad',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: () {

                  //Guardar los datos en las variables
                  user = userField.text;
                  email = emailField.text;
                  pass = passwordField.text;
                  passConfirm = passConfirmField.text;
                  names = namesField.text;
                  lastNames = lastNamesField.text;
                  country = countryField.text;
                  city = cityField.text;

                  if (user == '' || email == '' || pass == '' || passConfirm == '' || names == '' || lastNames == '' || country == '' || city == '') {
                    showDialog(
                        context: context,
                        barrierDismissible: false,                      
                        barrierColor: Color.fromARGB(180, 0, 0, 0),
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Notificación!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text('Todos los campos son requeridos. Por favor, ingrese sus datos.',
                                    style: TextStyle(
                                      fontSize: 16
                                    ),
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }, 
                                child: Text('Entiendo',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ),
                            ],
                          );
                        }
                      );
                  } else if (passConfirm != pass) {
                    showDialog(
                        context: context,
                        barrierDismissible: false,                      
                        barrierColor: Color.fromARGB(180, 0, 0, 0),
                        builder: (BuildContext context){
                          return AlertDialog(
                            title: Text('Notificación!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              ),
                            ),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text('Las contraseñas no coinciden. Asegúrese de que sean iguales.',
                                    style: TextStyle(
                                      fontSize: 16
                                    ),
                                  )
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                }, 
                                child: Text('Entiendo',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold
                                  ),
                                )
                              ),
                            ],
                          );
                        }
                      );
                  }else {
                    register();
                    
                    // Vaciar los campos
                    userField.text = '';
                    emailField.text = '';
                    passwordField.text = '';
                    passConfirmField.text = '';
                    namesField.text = '';
                    lastNamesField.text = '';
                    countryField.text = '';
                    cityField.text = '';

                  } 
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
                  'Registrar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _exitConfirmation,
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
      )
    );
  }
}
