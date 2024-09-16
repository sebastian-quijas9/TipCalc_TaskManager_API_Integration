import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:technical_challenge/assets/Consumo_api/blocs/search_bloc.dart';
import 'package:technical_challenge/assets/Consumo_api/repositories/unsplash_repository.dart';
import 'package:technical_challenge/assets/task_list_page/task_provider.dart';

import 'pages/tip_calculator_page.dart';
import 'pages/task_list_page.dart';
import 'pages/consumo_api.dart';

Future<void> main() async {
  await dotenv.load(
      fileName:
          ".env"); // Carga las variables de entorno desde el archivo .env.
  runApp(
    // MultiProvider permite gestionar múltiples proveedores de estado a lo largo de la aplicación.
    MultiProvider(
      providers: [
        // Proveedor para el TaskProvider, que gestiona la lista de tareas.
        ChangeNotifierProvider(
          create: (_) =>
              TaskProvider(), // TaskProvider es el gestor de tareas y notifica a los widgets cuando hay cambios.
        ),
        // BlocProvider para SearchBloc, que gestiona la lógica de búsqueda de fotos usando la API de Unsplash.
        BlocProvider(
          create: (_) => SearchBloc(
              UnsplashRepository()), // Se crea el BLoC de búsqueda utilizando el repositorio de Unsplash.
        ),
      ],
      child: const MyApp(), // MyApp es el widget principal de la aplicación.
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Technical Challenge', // Título de la aplicación.
      debugShowCheckedModeBanner:
          false, // Oculta la etiqueta de "debug" en la esquina superior derecha.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 0, 109,
              168), // Color principal de la aplicación basado en un color semilla.
          primary: const Color.fromARGB(212, 0, 56,
              168), // Color personalizado para elementos principales.
          secondary: const Color(0xFFFF0000), // Color secundario personalizado.
        ),
        useMaterial3:
            true, // Indica que se utilizará el estilo de Material Design 3.
      ),
      home:
          const HomePage(), // Define HomePage como la pantalla de inicio de la aplicación.
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() =>
      _HomePageState(); // Asocia el estado _HomePageState a HomePage.
}

class _HomePageState extends State<HomePage> {
  int _currentIndex =
      0; // Índice actual que controla la página seleccionada en el BottomNavigationBar.

  // Lista de páginas que se muestran cuando se seleccionan diferentes pestañas en el BottomNavigationBar.
  final List<Widget> _pages = [
    const TipCalculatorPage(), // Página de la calculadora de propinas.
    const TaskListPage(), // Página de la lista de tareas.
    const ApiPage(), // Página que consume la API de Unsplash.
  ];

  // Método que se llama cuando se selecciona una pestaña en el BottomNavigationBar.
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex =
          index; // Actualiza el índice actual y redibuja la interfaz.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context)
            .colorScheme
            .primary, // Establece el color de fondo del AppBar según el tema.
        leading: Padding(
          padding: const EdgeInsets.only(
              left: 10.0,
              top: 3.0,
              bottom: 3.0), // Agrega padding alrededor del logo.
          child: Image.asset(
            'lib/images/logo_sgq.png', // Ruta de la imagen del logo.
          ),
        ),
        title: const Text(
          'Technical Challenge', // Título que se muestra en el AppBar.
          style: TextStyle(
            color: Colors.white, // Estilo del texto del título en color blanco.
            fontWeight: FontWeight.bold, // Hace que el texto sea negrita.
            overflow: TextOverflow
                .ellipsis, // Si el texto es muy largo, se trunca con puntos suspensivos.
          ),
          maxLines: 1, // El texto se muestra en una sola línea.
        ),
      ),
      body: AnimatedSwitcher(
        duration: const Duration(
            milliseconds:
                300), // Duración de la animación al cambiar de página.
        child: _pages[
            _currentIndex], // Muestra la página seleccionada según el índice actual.
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex:
            _currentIndex, // Establece el índice actual del BottomNavigationBar.
        onTap:
            _onTabTapped, // Llama al método _onTabTapped cuando se selecciona una pestaña.
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons
                .monetization_on), // Ícono para la pestaña de la calculadora de propinas.
            label:
                'Propinas', // Etiqueta para la pestaña de la calculadora de propinas.
          ),
          BottomNavigationBarItem(
            icon: Icon(
                Icons.task), // Ícono para la pestaña de la lista de tareas.
            label: 'Tareas', // Etiqueta para la pestaña de la lista de tareas.
          ),
          BottomNavigationBarItem(
            icon:
                Icon(Icons.art_track_sharp), // Ícono para la pestaña de la API.
            label: 'API', // Etiqueta para la pestaña de la API.
          ),
        ],
        selectedItemColor: Theme.of(context)
            .colorScheme
            .primary, // Color del ítem seleccionado en el BottomNavigationBar.
        unselectedItemColor: Theme.of(context)
            .colorScheme
            .onSurface
            .withOpacity(0.6), // Color de los ítems no seleccionados.
      ),
    );
  }
}
