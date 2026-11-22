import 'package:flutter/material.dart';

class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton({
    super.key,
    required this.onSeleccionarTema,
  });

  final ValueChanged<ThemeMode> onSeleccionarTema;

  // Selecciona el tema opuesto al que está mostrando el sistema.
  @override
  Widget build(BuildContext context) {
    final estaOscuro = Theme.of(context).brightness == Brightness.dark;
    final temaSiguiente = estaOscuro ? ThemeMode.light : ThemeMode.dark;
    final descripcion =
        estaOscuro ? 'Cambiar a modo claro' : 'Cambiar a modo oscuro';

    return IconButton.filledTonal(
      tooltip: descripcion,
      onPressed: () => onSeleccionarTema(temaSiguiente),
      icon: Icon(
          estaOscuro ? Icons.light_mode_outlined : Icons.dark_mode_outlined),
    );
  }
}
