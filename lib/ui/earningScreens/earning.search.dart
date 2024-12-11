import 'package:flutter/material.dart';
import 'package:flutter_app_und4/ui/earningScreens/earning.dart';
// import 'package:flutter_app_und4/ui/earningScreens/earning.dart';

class SearchEarningScreen extends StatefulWidget {
  const SearchEarningScreen({super.key});
  
  @override
  State<SearchEarningScreen> createState() => _SearchEarningScreenState();
}

class _SearchEarningScreenState extends State<SearchEarningScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.2),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Buscar Ingreso',
                style: TextStyle(
                  color: Color.fromARGB(255, 141, 74, 180),
                  fontSize: 40,
                  fontWeight: FontWeight.bold
                ),
              ),

              const SizedBox(height: 60),

              TextField(
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton.icon(
                onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 141, 74, 180),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                    ),
                ),
                label: Text(
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
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: (){
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EarningScreen())
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
              ),

              const SizedBox(height: 60),

              Text('Información del Ingreso:',
                style: TextStyle(
                  fontSize: 20
                ),
              ),

              const SizedBox(height: 60),

              //Informacion del ingreso

            ],
          ),
        ),        
      ),
    );
  }
}

