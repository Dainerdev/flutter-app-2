import 'package:flutter/material.dart';
import 'package:flutter_app_und4/ui/expenseScreens/expense.add.dart';
import 'package:flutter_app_und4/ui/expenseScreens/expense.list.dart';
import 'package:flutter_app_und4/ui/expenseScreens/expense.search.dart';
import 'package:flutter_app_und4/ui/homeScreens/home.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Column(
              children: [
                Text(
                  'Gastos',
                  style: TextStyle(
                    color: Color.fromARGB(255, 141, 74, 180),
                    fontSize: 50,
                    fontWeight: FontWeight.bold
                  ),
                ),

                SizedBox(height: 40),

                Text(
                  '¿Qué deseas realizar?',
                  style: TextStyle(fontSize: 20)
                )
              ],
            ),

            const SizedBox(height: 60),

            Column(
              children: [
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, 
                      MaterialPageRoute(builder: (context) => AddExpenseScreen())
                    );
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
                    'Agregar',
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
                      MaterialPageRoute(builder: (context) => SearchExpenseScreen())
                    );
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
                    'Buscar',
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
                      MaterialPageRoute(builder: (context) => ExpenseListScreen())  
                    );
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
                    'Ver Gastos',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                    ),
                  )
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  
}