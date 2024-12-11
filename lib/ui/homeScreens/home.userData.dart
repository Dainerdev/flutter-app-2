import 'package:flutter/material.dart';
import 'home.dart';
import '../login.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class UserDataScreen extends StatefulWidget {
  const UserDataScreen({super.key});

  @override
  State<UserDataScreen> createState() => _UserDataScreenState();  
}

class _UserDataScreenState extends State<UserDataScreen> {

  String? userId;
  Map<String, dynamic>? userData;

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
                'Mis Datos',
                style: TextStyle(
                  color: Color.fromARGB(255, 141, 74, 180),
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              TextField(
                controller: TextEditingController(text: userData?['username'] ?? 'Loading'),
                decoration: const InputDecoration(
                  labelText: 'Usuario',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: userData?['email'] ?? 'Loading'),
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ), 
              const SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: userData?['names'] ?? 'Loading'),
                decoration: const InputDecoration(
                  labelText: 'Nombre(s)',
                  border: OutlineInputBorder(),                  
                ),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: userData?['lastNames'] ?? 'Loading'),
                decoration: const InputDecoration(
                  labelText: 'Apellido(s)',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: userData?['country'] ?? 'Loading'),
                decoration: const InputDecoration(
                  labelText: 'País',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: TextEditingController(text: userData?['city'] ?? 'Loading'),
                decoration: const InputDecoration(
                  labelText: 'Ciudad',
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
              ),
              const SizedBox(height: 60),
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => HomeScreen())
                  );
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