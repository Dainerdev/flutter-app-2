// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_und4/models/expense.model.dart';
import 'package:flutter_app_und4/ui/expenseScreens/expense.dart';
import 'package:flutter_app_und4/ui/expenseScreens/expense.edit.dart';
import 'package:flutter_app_und4/ui/login.dart';
import 'package:http/http.dart' as http;

class SearchExpenseScreen extends StatefulWidget {
  const SearchExpenseScreen({super.key});

  @override
  State<SearchExpenseScreen> createState() => _SearchExpenseScreenState();
  
}

class _SearchExpenseScreenState extends State<SearchExpenseScreen> {
  
  // identificadores
  final nameField = TextEditingController();

  // Lista de gastos
  List<Expense> expenses = [];

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
  
  // Metodo para buscar gastos por nombre
  Future<void> _searchExpensesByName(String name) async {

    final user = userId!;
    
    final apiUrl = Uri.parse('http://10.0.2.2:3312/api/expenses/name/$user/$name'); 

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
                      'Se encontró almenos un gasto con el nombre indicado.',
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

        // Convertir la lista de JSON a una lista de objetos Expenses
        setState(() {
          expenses = jsonData.map((data) => Expense.fromJson(data)).toList();
        });

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No se encontraron gastos con ese nombre.'))
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
                'Buscar Gasto',
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
                  border: OutlineInputBorder()
                ),
              ),

              const SizedBox(height: 40),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: (){
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => ExpensesScreen())
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
                    )
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
                                        'Indique el nombre del gasto a buscar.',
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
                          _searchExpensesByName(nameField.text);
                        }

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 141, 74, 180),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                      label: const Text(
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
                    )
                  )
                ],
              ),

              const SizedBox(height: 50),

              Text('Información del Gasto:',
                style: TextStyle(
                  fontSize: 20
                ),
              ),

              // Informacion del Gasto
              ListView.builder(
                shrinkWrap: true,
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return Card(
                    color: Color.fromARGB(255, 245, 230, 253),
                    elevation: 6,
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      title: Text('Monto: \$${expense.amount.toStringAsFixed(2)}',
                      style: TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(255, 141, 74, 180),
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text('Nombre: ${expense.name}\nDescripción: ${expense.description}',
                        style: TextStyle(
                          fontSize: 18
                        ),
                      ),
                      isThreeLine: true,
                      trailing: IconButton(
                        onPressed: (){
                          Navigator.push(context, 
                            MaterialPageRoute(builder: (context) => EditExpenseScreen(expense: expense))
                          );
                        },
                        style: IconButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 141, 74, 180),
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15)                          
                        ), 
                        icon: Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 24,
                        )
                      ),
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