// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_und4/models/earning.model.dart';
import 'package:flutter_app_und4/ui/earningScreens/earning.dart';
import 'package:flutter_app_und4/ui/login.dart';
import 'package:http/http.dart' as http;
import 'dart:async';


class SearchEarningScreen extends StatefulWidget {
  const SearchEarningScreen({super.key});
  
  @override
  State<SearchEarningScreen> createState() => _SearchEarningScreenState();
}

class _SearchEarningScreenState extends State<SearchEarningScreen> {
  
  // identificadores
  final nameField = TextEditingController();

  // Lista de ingresos
  List<Earning> earnings = [];
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
  }

  // Metodo para buscar ingresos por nombre
  Future<void> _searchEarningsByName(String name) async {

    final user = userId!;
    
    final apiUrl = Uri.parse('http://10.0.2.2:3312/api/earnings/name/$user/$name'); 

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          barrierDismissible: false,
          barrierColor: Color.fromARGB(180, 0, 0, 0), 
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                'Notifiación!',
                style: TextStyle(
                  fontWeight: FontWeight.bold
                ),
              ),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                      'Se encontró almenos un ingreso con el nombre indicado.',
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
                  child: Text(
                    'Entiendo',
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
        
        // Decodificar la respuesta en formato JSON
        List<dynamic> jsonData = json.decode(response.body);

        // Convertir la lista de JSON a una lista de objetos Earning
        setState(() {
          earnings = jsonData.map((data) => Earning.fromJson(data)).toList();
        });

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se encontraron ingresos con ese nombre.'))
        );
      }

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e'))
      );     
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(          
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Buscar Ingreso',
                style: TextStyle(
                  color: Color.fromARGB(255, 141, 74, 180),
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 60),

              TextField(
                controller: nameField,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 40),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context,
                          MaterialPageRoute(builder: (context) => EarningScreen())
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 245, 230, 253),
                        padding: const EdgeInsets.symmetric(horizontal: 45, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                      child: const Text(
                        'Regresar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 141, 74, 180),
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: (){

                        if (nameField.text == '') {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            barrierColor: Color.fromARGB(180, 0, 0, 0),
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Notificación!',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      Text(
                                        'Indique el nombre del ingreso a buscar.',
                                        style: TextStyle(
                                          fontSize: 16
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: (){
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
                          _searchEarningsByName(nameField.text);
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 141, 74, 180),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 15
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)
                          ),
                      ),
                      label: Text(
                        'Buscar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      icon: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),                  
                  ),
                ],
              ),

              const SizedBox(height: 50),

              Text('Información del Ingreso:',
                style: TextStyle(
                  fontSize: 20
                ),
              ),

              // Informacion del ingreso
              ListView.builder(
                shrinkWrap: true,
                itemCount: earnings.length,
                itemBuilder: (context, index) {
                  final earning = earnings[index];
                  return Card(
                    color: Color.fromARGB(255, 245, 230, 253),
                    elevation: 6,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text('Monto: \$${earning.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(255, 141, 74, 180),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text('Nombre: ${earning.name}\nDescripción: ${earning.description}',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      isThreeLine: true,
                    ),
                  );
                },
              ),
            ],
          ),
        ),        
      ),
    );
  }
}

