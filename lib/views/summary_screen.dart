import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/providers.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/theme_mode_button.dart';

class ResumenScreen extends ConsumerWidget {
  const ResumenScreen({
    super.key,
    required this.alSeleccionarTema,
  });

  final ValueChanged<ThemeMode> alSeleccionarTema;

  // Muestra el estado diario de órdenes, técnicos e inventario.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordenesAsync = ref.watch(ordenesProvider);
    final repuestosAsync = ref.watch(repuestosProvider);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Encabezado(
                titulo: 'Tu Solution',
                subtitulo: 'Taller de reparación',
              ),
            ),
            const SizedBox(width: 8),
            ThemeModeButton(onSeleccionarTema: alSeleccionarTema),
          ],
        ),
        const SizedBox(height: 20),
        ordenesAsync.when(
          data: (ordenes) {
            final abiertas =
                ordenes.where((dato) => ordenAbierta(dato.orden)).length;
            final enReparacion = ordenes
                .where((dato) => dato.orden.estado == 'En reparación')
                .length;
            final listas =
                ordenes.where((dato) => dato.orden.estado == 'Lista').length;
            return Row(children: [
              Expanded(
                  child: TarjetaIndicador(
                      titulo: 'Abiertas',
                      valor: '$abiertas',
                      icono: Icons.assignment_outlined)),
              const SizedBox(width: 10),
              Expanded(
                  child: TarjetaIndicador(
                      titulo: 'En reparación',
                      valor: '$enReparacion',
                      icono: Icons.handyman_outlined)),
              const SizedBox(width: 10),
              Expanded(
                  child: TarjetaIndicador(
                      titulo: 'Listas',
                      valor: '$listas',
                      icono: Icons.check_circle_outline)),
            ]);
          },
          loading: () => const LinearProgressIndicator(),
          error: (error, _) => ErrorContenido(mensaje: error.toString()),
        ),
        const SizedBox(height: 24),
        const TituloSeccion(titulo: 'Avisos de inventario'),
        const SizedBox(height: 10),
        repuestosAsync.when(
          data: (repuestos) {
            final bajos = repuestos
                .where(
                    (repuesto) => repuesto.existencias <= repuesto.nivelMinimo)
                .toList();
            if (bajos.isEmpty) {
              return const EstadoVacio(
                  mensaje: 'No hay repuestos por debajo del mínimo.');
            }
            return Column(
                children: bajos
                    .map((repuesto) => AvisoBajo(repuesto: repuesto))
                    .toList());
          },
          loading: () => const LinearProgressIndicator(),
          error: (error, _) => ErrorContenido(mensaje: error.toString()),
        ),
        const SizedBox(height: 24),
        const TituloSeccion(titulo: 'Órdenes recientes'),
        const SizedBox(height: 10),
        ordenesAsync.when(
          data: (ordenes) {
            final abiertas = ordenes
                .where((dato) => ordenAbierta(dato.orden))
                .take(4)
                .toList();
            if (abiertas.isEmpty) {
              return const EstadoVacio(mensaje: 'No hay órdenes abiertas.');
            }
            return Column(
                children:
                    abiertas.map((dato) => OrdenResumen(dato: dato)).toList());
          },
          loading: () => const LinearProgressIndicator(),
          error: (error, _) => ErrorContenido(mensaje: error.toString()),
        ),
      ],
    );
  }
}
