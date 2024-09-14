import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_challenge/assets/task_list_page/task_provider.dart';
import 'pages/tip_calculator_page.dart';
import 'pages/task_list_page.dart';
import 'pages/consumo_api.dart';

void main() {
  runApp(
    //Se agrega para que este disponible provider en toda la aplicacion.
    //MultiProvider es com un contenedor que guarda todos los estados de provider.
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => TaskProvider()), //Taskprovider es el gestor de tareas y notifica cuando hay cambios..
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Technical Challenge', // Título de la aplicación.
      debugShowCheckedModeBanner: false, // Oculta la etiqueta de debug.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 109, 168), //Color principal.
          primary: const Color.fromARGB(
              212, 0, 56, 168), // Color primario personalizado.
          secondary: const Color(0xFFFF0000), // Color secundario personalizado.
        ),
        useMaterial3: true, // Utiliza el estilo de Material Design 3.
      ),
      home:
          const HomePage(), // Se establece la HomePage como la página de inicio.
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState(); // Se crea el estado asociado a HomePage.
}

class _HomePageState extends State<HomePage> {
  int _currentIndex =
      0; // Índice actual para controlar la página seleccionada en el BottomNavigationBar.
  final List<Widget> _pages = [
    const TipCalculatorPage(), // Página de la calculadora de propinas.
    const TaskListPage(), // Página de la lista de tareas.
    const ApiPage(), // Página que consume la API.
  ];

  // Método para actualizar el índice cuando se selecciona una nueva pestaña en el BottomNavigationBar.
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index; // Actualiza el índice y redibuja la interfaz.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context)
            .colorScheme
            .primary, // Establece el color de fondo del AppBar.
        leading: Padding(
          padding: const EdgeInsets.only(
              left: 10.0,
              top: 3.0,
              bottom: 3.0), // Se añade padding a la imagen.
          child: Image.asset(
            'lib/images/logo_sgq.png', // Ruta de la imagen para el logo.
          ),
        ),
        title: const Text(
          'Technical Challenge', // Título del AppBar.
          style: TextStyle(
            color: Colors.white, // Estilo del texto en blanco.
            fontWeight: FontWeight.bold, // Texto en negrita.
            overflow: TextOverflow.ellipsis, // Trunca el texto si es muy largo.
          ),
          maxLines: 1, // Asegura que el texto ocupe solo una línea.
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(
            milliseconds:
                300), // Duración de la animación al cambiar de página.
        child:
            _pages[_currentIndex], // Muestra la página seleccionada en _pages.
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex, // Índice actual del BottomNavigationBar.
        onTap:
            _onTabTapped, // Llama a _onTabTapped cuando se selecciona una pestaña.
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons
                .monetization_on), // Ícono de la pestaña para la calculadora de propinas.
            label:
                'Propinas', // Etiqueta de la pestaña para la calculadora de propinas.
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
            label: 'Tareas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.art_track_sharp),
            label: 'API',
          ),
        ],
        selectedItemColor: Theme.of(context)
            .colorScheme
            .primary, // Color del ítem seleccionado.
        unselectedItemColor: Theme.of(context)
            .colorScheme
            .onSurface
            .withOpacity(0.6), // Color de los ítems no seleccionados.
      ),
    );
  }
}
