import 'package:flutter/material.dart';
import 'package:flutter_app_und4/ui/expenseScreens/expense.dart';

class ExpenseListScreen extends StatefulWidget {
  const ExpenseListScreen({super.key});

  @override
  State<ExpenseListScreen> createState() => _SearchExpenseScreenState();  
}

class _SearchExpenseScreenState extends State<ExpenseListScreen> {

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
                    '220,00',
                    // '\$${totalAmount.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                    ),
                  )
                ],
              ),



            ],
          ),
        ),
      ),
    );
  }
}