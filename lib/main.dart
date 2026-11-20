import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(debugShowCheckedModeBanner: true, home: MainApp(),));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
  
}

class _MainAppState extends State<MainApp>{

  List<Receta> recetas = [];



  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text('Recetario kiwi')
      ),
      body: Column(
        children: [
          SizedBox(height: 50.0,),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 100.0, right: 100.0),
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Inserta tus recetas a continuación:', 
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                  
              ),)
            ],
          ),)),

          Divider(
            color: Colors.green.shade500,
          ),

          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 100.0, right: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                ],
              )),
          )
        ],
        
      ),
    );

  }

}

class Receta {
  final String titulo;
  List<String> ingredientes;
  List<String> procesos;
  final IconData icono;
  final Color colorFondo;
  final int minutosPreparacion;

  Receta({
    required this.titulo,
    required this.ingredientes,
    required this.procesos,
    required this.icono,
    required this.colorFondo,
    required this.minutosPreparacion
  });

  List<String> AnadirIngrediente(List<String> ingredientes, String ingrediente){
    ingredientes.add(ingrediente);
    this.ingredientes = ingredientes;
    return ingredientes;
  }

  List<String> EliminarIngrediente(List<String> ingredientes, String ingrediente){
    ingredientes.remove(ingrediente);
    this.ingredientes = ingredientes;
    return ingredientes;
  }

  int getDuracion(){
    return minutosPreparacion;
  }

  String getTitulo(){
    return titulo;
  }

}


Widget crearTarjeta(Receta receta){
  return Card(
    margin: const EdgeInsets.only(top: 14),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: Row(),
      ),
  );
}