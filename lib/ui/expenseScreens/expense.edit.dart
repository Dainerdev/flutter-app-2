// ignore_for_file: use_build_context_synchronously
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app_und4/models/expense.model.dart';
import 'package:http/http.dart' as http;

class EditExpenseScreen extends StatefulWidget {

  final Expense expense;

  const EditExpenseScreen({super.key,  required this.expense});

  @override
  State<EditExpenseScreen> createState() => _EditExpenseScreenState();
  
}

class _EditExpenseScreenState extends State<EditExpenseScreen> {

  late TextEditingController nameField;
  late TextEditingController amountField;
  late TextEditingController descriptionField;

  // obtener los datos del gasto
  @override
  void initState() {
    super.initState();
    nameField = TextEditingController(text: widget.expense.name);
    amountField = TextEditingController(text: widget.expense.amount.toString());
    descriptionField = TextEditingController(text: widget.expense.description);
  }

  @override
  void dispose() {
    nameField.dispose();
    amountField.dispose();
    descriptionField.dispose();
    super.dispose();
  }

  void _saveExpense() async {
    final updatedExpense = Expense(
      id: widget.expense.id, 
      name: nameField.text,
      amount: double.parse(amountField.text),
      description: descriptionField.text
    );

    // llama a la API para actualizar el gasto en la BD
    final response = await _updateExpense(updatedExpense);
    if (response.statusCode == 200) {      
      Navigator.pop(context, updatedExpense);
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
                  Text('Gasto modificado exitosamente.',
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
        SnackBar(content: Text('Error al actualizar el gasto')),
      );
    }
  }

  // Enviar los datos nuevos a la API
  Future<http.Response> _updateExpense(Expense expense) async {
    final apiUrl = Uri.parse('http://10.0.2.2:3312/api/expenses/edit/${expense.id}');
    final response = await http.put(
      apiUrl,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': expense.name,
        'description': expense.description,
        'amount': expense.amount,
      }),
    );
    return response;
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
                'Modificar Gasto',
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
                  _saveExpense();
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