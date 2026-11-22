import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/taller_repository.dart';
import '../app/providers.dart';
import 'shared_widgets.dart';
import 'widget_formatters.dart';

class HistorialOrdenCard extends ConsumerWidget {
  const HistorialOrdenCard({super.key, required this.dato});

  final OrdenConDetalles dato;

  // Desglosa en el historial la mano de obra y los repuestos de la orden.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trabajos = ref.watch(trabajosOrdenProvider(dato.orden.id));
    final piezas = ref.watch(piezasOrdenProvider(dato.orden.id));
    return Card(
      child: ExpansionTile(
        tilePadding: EdgeInsets.zero,
        title: Text('Orden #${dato.orden.id} · ${dato.orden.estado}'),
        subtitle: Text(
            '${dato.orden.fallaReportada}\nResponsable: ${dato.tecnico.nombre}'),
        children: [
          trabajos.when(
            data: (lista) => Column(
              children: lista.isEmpty
                  ? [
                      const FilaDato(
                          etiqueta: 'Trabajos',
                          valor: 'Sin trabajos registrados')
                    ]
                  : lista
                      .map((trabajo) => FilaDato(
                            etiqueta: trabajo.descripcion,
                            valor: formatoDinero(trabajo.costeCentavos),
                          ))
                      .toList(),
            ),
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text(error.toString()),
          ),
          piezas.when(
            data: (lista) => Column(
              children: lista.isEmpty
                  ? [
                      const FilaDato(
                          etiqueta: 'Repuestos',
                          valor: 'Sin repuestos registrados')
                    ]
                  : lista
                      .map((pieza) => FilaDato(
                            etiqueta:
                                '${pieza.repuesto.nombre} × ${pieza.uso.cantidad}',
                            valor: formatoDinero(
                              pieza.uso.cantidad *
                                  pieza.uso.precioUnitarioCentavos,
                            ),
                          ))
                      .toList(),
            ),
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text(error.toString()),
          ),
        ],
      ),
    );
  }
}
