// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_und4/models/earning.model.dart';
import 'package:http/http.dart' as http;

class EditEarningScreen extends StatefulWidget {

  final Earning earning;
  const EditEarningScreen({super.key,  required this.earning});

  @override
  State<EditEarningScreen> createState() => _EditEarningScreenState();  
}

class _EditEarningScreenState extends State<EditEarningScreen> {

  late TextEditingController nameField;
  late TextEditingController amountField;
  late TextEditingController descriptionField;

  // obtener los datos del ingreso
  @override
  void initState() {
    super.initState();
    nameField = TextEditingController(text: widget.earning.name);
    amountField = TextEditingController(text: widget.earning.amount.toString());
    descriptionField = TextEditingController(text: widget.earning.description);
  }

  @override
  void dispose() {
    nameField.dispose();
    amountField.dispose();
    descriptionField.dispose();
    super.dispose();
  }

  void _saveEarning() async {
    final updatedEarning = Earning(
      id: widget.earning.id, 
      name: nameField.text,
      amount: double.parse(amountField.text),
      description: descriptionField.text
    );

    // llama a la API para actualizar el ingreso en la BD
    final response = await _updatedEarning(updatedEarning);
    if (response.statusCode == 200) {      
      Navigator.pop(context, updatedEarning);
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
                  Text('Ingreso modificado exitosamente.',
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
                child: Text('Continuar',
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
      // Muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el ingreso')),
      );
    }
  }

    // Enviar los datos nuevos a la API
  Future<http.Response> _updatedEarning(Earning earning) async {
    final apiUrl = Uri.parse('http://10.0.2.2:3312/api/earnings/edit/${earning.id}');
    final response = await http.put(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': earning.name,
        'description': earning.description,
        'amount': earning.amount,
      }),
    );
    return response;
  }

  // Metodo para eliminar ingresos
  Future<void> _deleteEarnings() async {
    final response = await _removeEarnings(widget.earning.id.toString());
    if (response.statusCode == 200) {
      Navigator.pop(context); // Regresar a la pantalla anterior
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Notifiación!'),
            content: const Text('Ingreso eliminado con éxito.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Entendido'),
              ),
            ],
          );
        }
      );

    } else {
      
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Notifiación!'),
            content: const Text('Error al eliminar el ingreso.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Entendido'),
              ),
            ],
          );
        }
      );
    }
  }

  // Comunicacion con la API para eliminar el gasto
  Future<http.Response> _removeEarnings(String id) async {
    final apiUrl = Uri.parse('http://10.0.2.2:3312/api/earnings/$id');
    return await http.delete(apiUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Modificar Ingreso',
                style: TextStyle(
                  color: Color.fromARGB(255, 141, 74, 180),
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 50),

              TextField(
                controller: nameField,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder()
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: amountField,
                decoration: const InputDecoration(
                  labelText: 'Monto',
                  border: OutlineInputBorder()
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: descriptionField,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder()
                ),
              ),

              const SizedBox(height: 60),

              ElevatedButton(
                onPressed: (){
                  _saveEarning();
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 141, 74, 180),
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)
                  )
                ),
                child: const Text(
                  'Editar',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                )
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: (){
                  showDialog(
                    context: context,
                    barrierDismissible: false,                      
                    barrierColor: Color.fromARGB(180, 0, 0, 0), 
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Eliminar ingreso',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text(
                                '¿Deseas eliminar el ingreso?',
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
                              // metodo eliminar
                              _deleteEarnings();
                            }, 
                            child: const Text(
                              'Eliminar',
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
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
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
                )
              ),

              const SizedBox(height: 40),

              ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                }, 
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 245, 230, 253),
                  padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                  minimumSize: const Size(double.infinity, 50),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}