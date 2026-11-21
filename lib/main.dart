import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: true,
      home: MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<StatefulWidget> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final List<Receta> recetas = [
    Receta(
      titulo: 'Test',
      ingredientes: ['test 1', 'test 2'],
      procesos: ['paso 1', 'paso 2'],
      minutosPreparacion: 10,
      icono: Icons.restaurant,
      colorFondo: Colors.green.shade100,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: const Text('Recetario kiwi'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: agregarReceta,
        tooltip: 'Añadir una nueva receta',
        backgroundColor: Colors.green.shade500,
        child: const Icon(Icons.add, color: Colors.black,),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 50.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Inserta tus recetas a continuación:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.green.shade500,
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 100.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: recetas.map((receta) => TarjetaReceta(receta: receta)).toList(),
              ),
            ),
          ),
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
    required this.minutosPreparacion,
  });

  void anadirIngrediente(String ingrediente) {
    ingredientes.add(ingrediente);
  }

  void eliminarIngrediente(String ingrediente) {
    ingredientes.remove(ingrediente);
  }
}

class TarjetaReceta extends StatefulWidget {
  final Receta receta;

  const TarjetaReceta({super.key, required this.receta});

  @override
  State<TarjetaReceta> createState() => _TarjetaRecetaState();
}

class _TarjetaRecetaState extends State<TarjetaReceta> {
  bool _mostrarIngredientes = false;
  bool _mostrarProcesos = false;

  @override
  Widget build(BuildContext context) {
    final receta = widget.receta;

    return Card(
      margin: const EdgeInsets.only(top: 14),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: receta.colorFondo,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(receta.icono, size: 28),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    receta.titulo,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Desplegable de ingredientes
                  InkWell(
                    onTap: () {
                      setState(() {
                        _mostrarIngredientes = !_mostrarIngredientes;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Text(
                            'Ingredientes',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Icon(
                            _mostrarIngredientes
                                ? Icons.expand_less
                                : Icons.expand_more,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_mostrarIngredientes)
                    ...receta.ingredientes.map(
                      (ingrediente) => Padding(
                        padding: const EdgeInsets.only(left: 8, top: 2),
                        child: Text('• $ingrediente'),
                      ),
                    ),

                  const SizedBox(height: 4),
                  const Divider(color: Color.fromARGB(255, 19, 43, 19)),

                  // Desplegable de pasos / procesos
                  InkWell(
                    onTap: () {
                      setState(() {
                        _mostrarProcesos = !_mostrarProcesos;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          const Text(
                            'Pasos',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Icon(
                            _mostrarProcesos
                                ? Icons.expand_less
                                : Icons.expand_more,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (_mostrarProcesos)
                    ...receta.procesos.map(
                      (paso) => Padding(
                        padding: const EdgeInsets.only(left: 8, top: 2),
                        child: Text('- $paso'),
                      ),
                    ),

                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Spacer(),
                      Text(
                        '${receta.minutosPreparacion} min',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}