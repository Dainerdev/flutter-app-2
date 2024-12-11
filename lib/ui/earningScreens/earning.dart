import 'package:flutter/material.dart';
import 'package:flutter_app_und4/ui/earningScreens/earning.add.dart';
import 'package:flutter_app_und4/ui/earningScreens/earning.search.dart';
import 'package:flutter_app_und4/ui/homeScreens/home.dart';


class EarningScreen extends StatelessWidget {
  const EarningScreen({super.key});

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
                  'Ingresos',
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
                      MaterialPageRoute(builder: (context) => AddEarningScreen())
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
                      MaterialPageRoute(builder: (context) => SearchEarningScreen())
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
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 141, 74, 180),
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                  child: const Text(
                    'Ver Ingresos',
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
                      MaterialPageRoute(builder: (context) => const HomeScreen())
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
            )
          ],
        ),        
      )
    );
  }
}