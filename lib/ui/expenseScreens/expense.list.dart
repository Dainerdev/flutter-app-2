// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_und4/models/expense.model.dart';
import 'package:flutter_app_und4/ui/expenseScreens/expense.dart';
import 'package:flutter_app_und4/ui/login.dart';
import 'package:http/http.dart' as http;

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _SearchExpenseScreenState();  
}

class _SearchExpenseScreenState extends State<ExpenseListScreen> {

    // Lista de ingresos
  List<Expense> expenses = [];

  String? userId;
  Map<String, dynamic>? userData;
  double totalAmount = 0;

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

  // Metodo para obtener los gastos
  Future<void> _getExpenses() async {

    final user = userId!;

    final apiUrl = Uri.parse('http://10.0.2.2:3312/api/expenses/list/$user');

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
                      'Se encontró almenos un gasto guardado.',
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
          expenses = jsonData.map((data) => Expense.fromJson(data)).toList();
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

  // Metodo para obtener el total de ingresos
  Future<void> _getTotalAmount() async {

    final user = userId!;

    final apiUrl = Uri.parse('http://10.0.2.2:3312/api/expenses/total/$user');

    try {
      final response = await http.get(apiUrl);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        final totalExpenses = (data['total_expenses'] as num).toDouble();

        setState(() {
          totalAmount = totalExpenses;
        });

      } else {
        throw Exception('Failed to load total amount data.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
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
                'Lista de Gastos',
                style: TextStyle(
                  color: Color.fromARGB(255, 141, 74, 180),
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 40), 

              Text(
                'Presione el botón "Consultar" para listar todos sus gastos.',
                style: TextStyle(
                  fontSize: 20
                ),
              ),

              const SizedBox(height: 40),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, 
                          MaterialPageRoute(builder: (context) => ExpensesScreen())
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 245, 230, 253),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                      child: const Text(
                        'Regresar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color:  Color.fromARGB(255, 141, 74, 180),
                          fontSize: 20
                        ),
                      )
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        _getExpenses();
                        _getTotalAmount();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 141, 74, 180),
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)
                        )
                      ),
                      child: const Text(
                        'Consultar',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20
                        ),
                      )
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 40),

              Text(
                'Información de Gatos:',
                style: TextStyle(
                  fontSize: 20
                ),
              ),

              const SizedBox(height: 40),

              Row(
                children: [
                  Text(
                    'Total de ingresos: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),
                    
                  ),

                  const SizedBox(width: 10),

                  Text(
                    '\$${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),
                  )
                ],
              ),

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
                    ),
                  );
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}