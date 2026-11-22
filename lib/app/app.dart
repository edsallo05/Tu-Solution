import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../views/screens.dart';

class TuSolutionApp extends StatefulWidget {
  const TuSolutionApp({super.key});

  @override
  State<TuSolutionApp> createState() => _TuSolutionAppState();
}

class _TuSolutionAppState extends State<TuSolutionApp> {
  ThemeMode _tema = ThemeMode.system;
  bool _temaElegidoEnEstaSesion = false;

  @override
  void initState() {
    super.initState();
    _cargarTemaGuardado();
  }

  // Restaura la última apariencia elegida; sin dato, respeta el sistema.
  Future<void> _cargarTemaGuardado() async {
    final preferencias = await SharedPreferences.getInstance();
    final temaGuardado = preferencias.getString('tema_apariencia');
    if (!mounted || temaGuardado == null || _temaElegidoEnEstaSesion) return;
    setState(() {
      _tema = temaGuardado == 'oscuro' ? ThemeMode.dark : ThemeMode.light;
    });
  }

  // Aplica y guarda la apariencia elegida desde la pantalla principal.
  Future<void> _seleccionarTema(ThemeMode tema) async {
    setState(() {
      _tema = tema;
      _temaElegidoEnEstaSesion = true;
    });
    final preferencias = await SharedPreferences.getInstance();
    await preferencias.setString(
      'tema_apariencia',
      tema == ThemeMode.dark ? 'oscuro' : 'claro',
    );
  }

  // Configura los temas y conserva la preferencia mientras la app está abierta.
  @override
  Widget build(BuildContext context) {
    const colorPrincipal = Color(0xFF155EEF);
    return MaterialApp(
      title: 'Tu Solution',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: colorPrincipal),
        scaffoldBackgroundColor: const Color(0xFFF7F8FA),
        cardTheme: const CardThemeData(elevation: 0, margin: EdgeInsets.zero),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF8EAAFF),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF101318),
        cardTheme: const CardThemeData(
          elevation: 0,
          margin: EdgeInsets.zero,
          color: Color(0xFF1A1F27),
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
          filled: true,
        ),
      ),
      themeMode: _tema,
      home: InicioNavegacion(alSeleccionarTema: _seleccionarTema),
    );
  }
}

class InicioNavegacion extends StatefulWidget {
  const InicioNavegacion({
    super.key,
    required this.alSeleccionarTema,
  });

  final ValueChanged<ThemeMode> alSeleccionarTema;

  @override
  State<InicioNavegacion> createState() => _InicioNavegacionState();
}

class _InicioNavegacionState extends State<InicioNavegacion> {
  int _indice = 0;

  // Selecciona la pantalla de trabajo desde la barra de navegación.
  @override
  Widget build(BuildContext context) {
    final pantallas = [
      ResumenScreen(alSeleccionarTema: widget.alSeleccionarTema),
      const OrdenesScreen(),
      const ClientesScreen(),
      const InventarioScreen(),
      const TecnicosScreen(),
    ];
    return Scaffold(
      body: SafeArea(child: pantallas[_indice]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _indice,
        onDestinationSelected: (indice) => setState(() => _indice = indice),
        destinations: const [
          NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              selectedIcon: Icon(Icons.dashboard),
              label: 'Resumen'),
          NavigationDestination(
              icon: Icon(Icons.build_outlined),
              selectedIcon: Icon(Icons.build),
              label: 'Órdenes'),
          NavigationDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people),
              label: 'Clientes'),
          NavigationDestination(
              icon: Icon(Icons.inventory_2_outlined),
              selectedIcon: Icon(Icons.inventory_2),
              label: 'Inventario'),
          NavigationDestination(
              icon: Icon(Icons.engineering_outlined),
              selectedIcon: Icon(Icons.engineering),
              label: 'Técnicos'),
        ],
      ),
    );
  }
}
