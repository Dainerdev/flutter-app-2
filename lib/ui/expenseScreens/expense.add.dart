import 'package:flutter/material.dart';
import 'package:flutter_app_und4/ui/expenseScreens/expense.dart';

class AddExpenseScreen extends StatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  State<AddExpenseScreen> createState() => _AddEarningScreenState();
  
}

class _AddEarningScreenState extends State<AddExpenseScreen> {

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
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder()
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                decoration: const InputDecoration(
                  labelText: 'Monto',
                  border: OutlineInputBorder()
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder()
                ),
              ),

              const SizedBox(height: 60),

              ElevatedButton(
                onPressed: (){

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