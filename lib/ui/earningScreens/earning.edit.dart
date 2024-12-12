import 'package:flutter/material.dart';
import 'package:flutter_app_und4/models/earning.model.dart';

class EditEarningScreen extends StatefulWidget {

  final Earning earning;
  const EditEarningScreen({super.key,  required this.earning});

  @override
  State<EditEarningScreen> createState() => _EditEarningScreenState();  
}

class _EditEarningScreenState extends State<EditEarningScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 100.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Modificar Ingreso',
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
                  showDialog(
                    context: context,
                    barrierDismissible: false,                      
                    barrierColor: Color.fromARGB(180, 0, 0, 0), 
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Eliminar ingreso',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: [
                              Text(
                                '¿Deseas eliminar el ingreso?',
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
                            child: const Text(
                              'Cancelar',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ),
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                              // metodo eliminar

                            }, 
                            child: const Text(
                              'Eliminar',
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