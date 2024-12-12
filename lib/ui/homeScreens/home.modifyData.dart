import 'package:flutter/material.dart';
import 'home.dart';
import '../login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'modifyData.deleteUser.dart';


class UserEditDataScreen extends StatefulWidget {
  const UserEditDataScreen({super.key});

  @override
  State<UserEditDataScreen> createState() => _UserEditDataScreenState();  
}

class _UserEditDataScreenState extends State<UserEditDataScreen> {

  String? userId;
  Map<String, dynamic>? userData;

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

  @override
  void initState() {
    super.initState();
    _loadUserId();
  }

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
          userField.text = userData!['username'] ?? '';
          emailField.text = userData!['email'] ?? '';
          namesField.text = userData!['names'] ?? '';
          lastNamesField.text = userData!['lastNames'] ?? '';
          countryField.text = userData!['country'] ?? '';
          cityField.text = userData!['city'] ?? '';
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      setState(() {
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  //Alerta para Confirmar que desea regresar
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
              content: const Text('Los cambios realizados se perderán.',
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()));
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

  // funcion para comunicar con la api
  Future<void> _updateUserData() async {

    if (userId != null) {
      final url = Uri.parse('http://10.0.2.2:3312/api/users/edit/$userId');

      final updatedData = {
        'username': userField.text,
        'email': emailField.text,
        'password': passwordField.text,
        'names': namesField.text,
        'lastNames': lastNamesField.text,
        'country': countryField.text,
        'city': cityField.text,
      };

      try {
        final jsonData = json.encode(updatedData);
        // Solicitud PUT a la API
        final response = await http.put(url, headers: {"Content-Type": "application/json"}, body: jsonData);

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
                      Text('Datos modificados exitosamente.',
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
                        MaterialPageRoute(builder: (context) => const HomeScreen())
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
                content: Text("No se han podido modificar los datos. Inténtelo nuevamente."),
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
          SnackBar(content: Text('Error al modificar los datos: $e')),
        );
      }
    }    
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
                'Modificar Datos',
                style: TextStyle(
                  color: Color.fromARGB(255, 141, 74, 180),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: userField,
                onChanged: (value) {},
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
                ),
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

                  if (userField.text == '' || emailField.text == '' || passwordField.text == '' || 
                      passConfirmField.text == '' || namesField.text == '' || lastNamesField.text == '' || 
                      countryField.text == '' || cityField.text == '') {
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
                  } else {
                    _updateUserData();
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
                  'Modificar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {                 
                  showDialog(
                    context: context,
                    barrierDismissible: false,                      
                    barrierColor: Color.fromARGB(180, 0, 0, 0), 
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Eliminar mi cuenta',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text(
                                '¿Deseas eliminar tu cuenta?',
                                style: TextStyle(
                                  fontSize: 16
                                ),
                              ),
                            ],
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                              Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => DeleteAccountScreen())
                              );
                            }, 
                            child: const Text(
                              'Continuar',
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
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 165, 31, 31),
                  padding:
                    const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                ),
                child: Text(
                  'Eliminar Cuenta',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )
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
      ),
    );
  }

}