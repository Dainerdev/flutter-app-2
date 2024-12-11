import 'package:flutter/material.dart';
import 'package:flutter_app_und4/ui/expenseScreens/expense.dart';
import 'package:flutter_app_und4/ui/login.dart';
import 'home.userData.dart';
import 'home.modifyData.dart';
import '../earningScreens/earning.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  'Inicio',
                  style: TextStyle(
                    color: Color.fromARGB(255, 141, 74, 180),
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 40),
                Text(
                  '¿Qué deseas realizar?',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),

            const SizedBox(height: 60),

            Column(
              children: [
                ElevatedButton.icon(
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => UserDataScreen())                    
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 141, 74, 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 15
                    ),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ), 
                  label: Text('Ver Datos',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Icon(
                    Icons.person_2_outlined,
                    color: Colors.white,
                    size: 24,                    
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => UserEditDataScreen())                    
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 141, 74, 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 90,
                      vertical: 15
                    ),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ), 
                  label: const Text(
                    'Modificar Datos',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Icon(
                    Icons.edit,
                    color: Colors.white,
                    size: 24,                    
                  ),
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: (){
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => EarningScreen())                    
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 141, 74, 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100,
                      vertical: 15
                    ),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ), 
                  label: Text('Ingresos',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),

                const SizedBox(height: 20),

                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => ExpensesScreen())                    
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 141, 74, 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 90,
                      vertical: 15
                    ),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ), 
                  label: const Text(
                    'Gastos',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),

                const SizedBox(height: 60),
                
                ElevatedButton(
                  onPressed: () {           
                    showDialog(
                      context: context, 
                      barrierDismissible: false,                      
                      barrierColor: Color.fromARGB(180, 0, 0, 0),
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('¿Deseas cerrar sesión?',
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          content: const Text('Si regresas cerrarás sesión.',
                            style: TextStyle(
                              fontSize: 16
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Cancela y no regresa
                              },
                              child: const Text('Cancelar',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Confirma y regresa
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                              },
                              child: const Text('Regresar',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                    ); // Regresa a la pantalla de login
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 245, 230, 253),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 100, vertical: 15
                    ),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                  ),
                  child: Text(
                    'Cerrar Sesión',
                    style: TextStyle(
                      fontSize: 20,
                      color: Color.fromARGB(255, 141, 74, 180),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}