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

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text('Recetario kiwi')
      ),
      body: Column(
        children: [
          Container(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            backgroundColor: Colors.green.shade50,
            children: [
              Text(
                'Inserta tus recetas a continuación:', 
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold
                  
              ),)
            ],
          ),)
        ],
        
      ),
    );

  }

}