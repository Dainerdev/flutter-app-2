// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_und4/ui/expenseScreens/expense.dart';
import 'package:flutter_app_und4/ui/login.dart';
import 'package:http/http.dart' as http;

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddEarningScreenState();
  
}

class _AddEarningScreenState extends State<AddExpenseScreen> {

  // Identificadores de los textfields
  final nameField = TextEditingController();
  final amountField = TextEditingController();
  final descriptionField = TextEditingController();

  //variables
  String name = '';
  String amount = '';
  String description = '';

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

  // funcion para comunicar con la api y guardar gasto
  Future<void> save() async {

    final apiUrl = Uri.parse('http://10.0.2.2:3312/api/expenses/');

    //Mapa de los datos del usuario
    final Map<String, dynamic> expenseData = {

      "user_id": userId!,
      "name": nameField.text,
      "amount": amountField.text,
      "description": descriptionField.text

    };

    try {
      
      // Solicitud POST a la API
      final response = await http.post(apiUrl,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(expenseData)
      );

      if (response.statusCode == 200) {
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
                    Text('Ingreso guardado exitosamente.',
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
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => ExpensesScreen())
                    );
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
        showDialog(
          context: context, 
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Error'),
              content: Text('No se pudo guardar el ingreso. Inténtelo neuvamente.'),
              actions: [
                TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  }, 
                  child: Text('Entiendo',
                    style: TextStyle(
                      fontSize: 16
                    ),
                  )
                )
              ],
            );
          }
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Agregar Gasto',
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

                  //Guardar los datos en las variables
                  name = nameField.text;
                  amount = amountField.text;
                  description = descriptionField.text;

                  if ( name == '' || amount == '' || description == '') {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      barrierColor: Color.fromARGB(180, 0, 0, 0),
                      builder: (BuildContext context){
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
                                Text('Todos los campos son requeridos. Por favor, indique los datos del gasto.',
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
                    save();
                  }
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
                  'Guardar',
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
                  Navigator.push(context, 
                    MaterialPageRoute(builder: (context) => ExpensesScreen())
                  );
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