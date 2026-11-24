import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainApp(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.green,
          primary: Colors.green.shade700,
          secondary: Colors.green.shade500,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green.shade600,
            foregroundColor: Colors.white,
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.green.shade800,
            side: BorderSide(color: Colors.green.shade600),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.green.shade800,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green.shade700, width: 2),
          ),
          floatingLabelStyle: TextStyle(color: Colors.green.shade800),
          prefixIconColor: Colors.green.shade700,
        ),
      ),
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
        onPressed: _irAFormulario,
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
                children: List.generate(
                  recetas.length,
                  (index) => TarjetaReceta(
                    receta: recetas[index],
                    onEditar: () => _editarReceta(index),
                    onEliminar: () => eliminarReceta(recetas[index]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _irAFormulario() async {
    final nuevaReceta = await Navigator.push<Receta>(
      context,
      MaterialPageRoute(
        builder: (context) => const PantallaNuevaReceta(),
      ),
    );

     if (nuevaReceta != null) {
      setState(() {
        recetas.add(nuevaReceta);
      });
     }
  }

  void eliminarReceta(Receta receta) {
    setState(() {
     recetas.remove(receta);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Se ha eliminado correctamente la receta')),
    );
  }

  Future<void> _editarReceta(int index) async {
    final recetaActualizada = await Navigator.push<Receta>(
      context,
      MaterialPageRoute(
        builder: (context) => PantallaNuevaReceta(
          recetaInicial: recetas[index],
        ),
      ),
    );

    if (recetaActualizada != null) {
      setState(() {
        recetas[index] = recetaActualizada;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Receta actualizada correctamente')),
        );
      }
    }
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
  final VoidCallback? onEditar;
  final VoidCallback? onEliminar;

  const TarjetaReceta({
    super.key,
    required this.receta,
    this.onEditar,
    this.onEliminar,
  });

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
                  if (widget.onEditar != null || widget.onEliminar != null) ...[
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (widget.onEditar != null)
                          OutlinedButton.icon(
                            onPressed: widget.onEditar,
                            icon: const Icon(Icons.edit_outlined),
                            label: const Text('Editar'),
                          ),
                        if (widget.onEditar != null && widget.onEliminar != null)
                          const SizedBox(width: 8),
                        if (widget.onEliminar != null)
                          ElevatedButton.icon(
                            onPressed: widget.onEliminar,
                            icon: const Icon(Icons.delete_outline),
                            label: const Text('Eliminar receta'),
                          ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// PANTALLA FORMULARIO RECETA
class PantallaNuevaReceta extends StatefulWidget {
  final Receta? recetaInicial;

  const PantallaNuevaReceta({super.key, this.recetaInicial});

  @override
  State<PantallaNuevaReceta> createState() => _PantallaNuevaEstado();
}

class _PantallaNuevaEstado extends State<PantallaNuevaReceta> {
  final _formularioKey = GlobalKey<FormState>();

  late final TextEditingController _nombreController;
  late final TextEditingController _duracionController;
  late final List<TextEditingController> _ingredientesControllers;
  late final List<TextEditingController> _procesosControllers;

  @override
  void initState() {
    super.initState();
    final receta = widget.recetaInicial;

    _nombreController = TextEditingController(text: receta?.titulo ?? '');
    _duracionController = TextEditingController(
      text: receta != null ? receta.minutosPreparacion.toString() : '',
    );

    _ingredientesControllers = (receta != null && receta.ingredientes.isNotEmpty)
        ? receta.ingredientes.map((ing) => TextEditingController(text: ing)).toList()
        : [TextEditingController()];

    _procesosControllers = (receta != null && receta.procesos.isNotEmpty)
        ? receta.procesos.map((paso) => TextEditingController(text: paso)).toList()
        : [TextEditingController()];
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _duracionController.dispose();
    for (final c in _ingredientesControllers) {
      c.dispose();
    }
    for (final c in _procesosControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _validarYGuardar() {
    if (_formularioKey.currentState!.validate()) {
      final ingredientes = _ingredientesControllers
          .map((c) => c.text.trim())
          .where((texto) => texto.isNotEmpty)
          .toList();

      final procesos = _procesosControllers
          .map((c) => c.text.trim())
          .where((texto) => texto.isNotEmpty)
          .toList();

      final duracion = int.tryParse(_duracionController.text.trim()) ?? 10;

      final recetaResultado = Receta(
        titulo: _nombreController.text.trim(),
        minutosPreparacion: duracion,
        ingredientes: ingredientes,
        procesos: procesos,
        icono: widget.recetaInicial?.icono ?? Icons.event_available,
        colorFondo: widget.recetaInicial?.colorFondo ?? Colors.purple.shade100,
      );

      Navigator.pop(context, recetaResultado);
    }
  }
  

  Widget _construirSeccionDinamica({
    required String titulo,
    required String etiquetaCampo,
    required List<TextEditingController> controladores,
    required VoidCallback onAnadir,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...List.generate(controladores.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controladores[index],
                    decoration: InputDecoration(
                      labelText: '$etiquetaCampo ${index + 1}',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (index == 0 && (value == null || value.trim().isEmpty)) {
                        return 'Añade al menos un ${etiquetaCampo.toLowerCase()}';
                      }
                      return null;
                    },
                  ),
                ),
                if (controladores.length > 1) ...[
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        final eliminado = controladores.removeAt(index);
                        eliminado.dispose();
                      });
                    },
                    icon: const Icon(Icons.remove_circle_outline),
                    tooltip: 'Eliminar',
                  ),
                ],
              ],
            ),
          );
        }),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: onAnadir,
            icon: const Icon(Icons.add),
            label: Text('Añadir ${etiquetaCampo.toLowerCase()}'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.recetaInicial == null ? 'Insertar Receta' : 'Editar Receta',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 30),
        child: Form(
          key: _formularioKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Introduce a continuación los datos de la receta',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'El nombre es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              _construirSeccionDinamica(
                titulo: 'Ingredientes',
                etiquetaCampo: 'Ingrediente',
                controladores: _ingredientesControllers,
                onAnadir: () {
                  setState(() {
                    _ingredientesControllers.add(TextEditingController());
                  });
                },
              ),
              const SizedBox(height: 24),
              _construirSeccionDinamica(
                titulo: 'Procesos',
                etiquetaCampo: 'Paso',
                controladores: _procesosControllers,
                onAnadir: () {
                  setState(() {
                    _procesosControllers.add(TextEditingController());
                  });
                },
              ),

              const SizedBox(height: 24),

               // CAMPO DURACIÓN (Solo números, sin letras)
              TextFormField(
                controller: _duracionController,
                keyboardType: TextInputType.number,
                // Bloquea físicamente que se escriban letras en el teclado
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  labelText: 'Duración (minutos)',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.timer),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Introduce la duración en minutos';
                  }
                  // Doble validación lógica: intentamos convertir a entero
                  final minutos = int.tryParse(value.trim());
                  if (minutos == null) {
                    return 'No se permiten letras, solo números';
                  }
                  if (minutos <= 0) {
                    return 'La duración debe ser mayor a 0 minutos';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),

              // BOTÓN VALIDAR Y GUARDAR
              ElevatedButton.icon(
                onPressed: _validarYGuardar,
                icon: const Icon(Icons.save),
                label: const Text('Validar y guardar'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
              const SizedBox(height: 12),

              // BOTÓN CANCELAR / VOLVER
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar y volver'),
              )
            ],
          ),
        ),
      ),
    );
  }
}