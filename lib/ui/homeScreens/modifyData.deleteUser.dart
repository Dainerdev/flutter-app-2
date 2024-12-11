// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_app_und4/main.dart';
import 'package:http/http.dart' as http;
import '../login.dart';
import 'dart:convert';

class DeleteAccountScreen extends StatefulWidget {
  const DeleteAccountScreen({super.key});

  @override
  State<DeleteAccountScreen> createState() => _DeleteAccountScreenState();
}

class _DeleteAccountScreenState extends State<DeleteAccountScreen> {

  String? userId;
  Map<String, dynamic>? userData;
  String? pass;

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

  final passwordField = TextEditingController();
  final passConfirmField = TextEditingController();

  // Método para cargar el userId desde SharedPreferences
  Future<void> _loadUserId() async {
    // Obtiene el ID del usuario desde SharedPreferences
    final id = await getUserId();

    // Actualiza el estado con el ID
    setState(() {
      userId = id;
    });

    if (userId != null) {
      // Si tenemos un ID, obtenemos los datos del usuario
      _getUserData(userId!);
    }
  }

  // Método para obtener los datos del usuario usando la API
  Future<void> _getUserData(String userId) async {
    final url = Uri.parse('http://10.0.2.2:3312/api/users/$userId');
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          userData = data[0]; 
          
          // Inicializar los controladores con los datos del usuario
          pass = userData!['password'] ?? '';
        });
      } else {
        throw Exception('Failed to load user data.');
      }
    } catch (error) {
      setState(() {
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  // Método para eliminar la cuenta del usuario
  Future<void> _deleteAccount() async {

    if (userId != null) {
      final url = Uri.parse('http://10.0.2.2:3312/api/users/$userId');


      try {
        final response = await http.delete(url);

        if (response.statusCode == 200) {
          // Si la cuenta se eliminó correctamente
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Cuenta eliminada'),
                content: const Text('Tu cuenta ha sido eliminada correctamente.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MainApp()));
                    },
                    child: const Text('Entendido'),
                  ),
                ],
              );
            },
          );
        } else if (response.statusCode == 404) {
          // Si la contraseña no es válida
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Notificacion!'),
                content: const Text('No se encontró el usuario.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Entendido'),
                  ),
                ],
              );
            },
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $error')),
        );
      } 
      
    }    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 90.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Eliminar tu cuenta',
              style: TextStyle(
                color: Color.fromARGB(255, 216, 54, 54),
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Al eliminar tu cuenta, todos tus datos serán eliminados permanentemente y no podrán ser recuperados. '
              'Por favor, confirma tu contraseña para proceder.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: passwordField,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passConfirmField,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirmar contraseña',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 60),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 245, 230, 253),
                padding:
                  const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                minimumSize: const Size(45, 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                )
              ),
              child: const Text(
                'Cancelar',
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 141, 74, 180),
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () {
                // Navigator.pop(context);

                if (passwordField.text == '') {
                  showDialog(context: context, 
                    barrierDismissible: false,                      
                    barrierColor: Color.fromARGB(180, 0, 0, 0),
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Notificación!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text('Ingrese su contraseña.',
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
                            child: Text(
                              'Entiendo',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          )
                        ],
                      );
                    }
                  );
                } else if (passConfirmField.text == '') {
                  showDialog(context: context, 
                    barrierDismissible: false,                      
                    barrierColor: Color.fromARGB(180, 0, 0, 0),
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Notificación!',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text('Confirme su contraseña.',
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
                            child: Text(
                              'Entiendo',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          )
                        ],
                      );
                    }
                  );
                } else if (passConfirmField.text != passwordField.text) {
                  showDialog(context: context, 
                    barrierDismissible: false,                      
                    barrierColor: Color.fromARGB(180, 0, 0, 0),
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          'Notificación!',
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
                            child: Text(
                              'Entiendo',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          )
                        ],
                      );
                    }
                  );
                } else {
                  if (passwordField.text == pass) {
                    _deleteAccount();
                  } else {
                    showDialog(context: context, 
                      barrierDismissible: false,                      
                      barrierColor: Color.fromARGB(180, 0, 0, 0),
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(
                            'Notificación!',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text('Las contraseña es incorrecta. Verifique e intente nuevamente.',
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
                              child: Text(
                                'Entiendo',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                              )
                            )
                          ],
                        );
                      }
                    );
                  }                 
                }                
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 165, 31, 31),
                padding:
                  const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                minimumSize: const Size(45, 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                )
              ),
              child: const Text(
                'Eliminar',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
