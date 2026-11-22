import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/taller_repository.dart';
import '../app/providers.dart';
import '../viewmodels/ordenes_view_model.dart';
import 'shared_widgets.dart';
import 'widget_formatters.dart';
import '../views/workshop_actions.dart';

class OrdenCard extends ConsumerWidget {
  const OrdenCard({super.key, required this.dato});

  final OrdenConDetalles dato;

  // Expande los datos de una orden y sus acciones de reparación.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trabajos = ref.watch(trabajosOrdenProvider(dato.orden.id));
    final piezas = ref.watch(piezasOrdenProvider(dato.orden.id));
    final tecnicos = ref.watch(tecnicosProvider);
    return Card(
      child: ExpansionTile(
        title: Text('${dato.dispositivo.marca} ${dato.dispositivo.modelo}',
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(
            'Orden #${dato.orden.id} · ${dato.cliente.nombre} · ${dato.orden.estado}'),
        leading: EstadoIcono(estado: dato.orden.estado),
        childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        children: [
          FilaDato(
              etiqueta: 'Falla reportada', valor: dato.orden.fallaReportada),
          FilaDato(
              etiqueta: 'Equipo',
              valor:
                  '${dato.dispositivo.tipo} · Serie ${dato.dispositivo.numeroSerie ?? '—'}'),
          Align(
            alignment: Alignment.centerLeft,
            child: ProcesoOrden(estado: dato.orden.estado),
          ),
          Row(children: [
            Expanded(
                child: FilaDato(
                    etiqueta: 'Responsable', valor: dato.tecnico.nombre)),
            if (ordenAbierta(dato.orden))
              TextButton(
                onPressed: () => tecnicos.whenData((lista) =>
                    elegirTecnico(context, ref, lista, dato.orden.id)),
                child: const Text('Cambiar'),
              ),
          ]),
          const Divider(),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text('Trabajos realizados',
                  style: TextStyle(fontWeight: FontWeight.w600))),
          trabajos.when(
            data: (lista) => lista.isEmpty
                ? const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Sin trabajos registrados.'))
                : Column(
                    children: lista
                        .map((trabajo) => FilaDato(
                            etiqueta: trabajo.descripcion,
                            valor: formatoDinero(trabajo.costeCentavos)))
                        .toList()),
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text(error.toString()),
          ),
          const Align(
              alignment: Alignment.centerLeft,
              child: Text('Repuestos usados',
                  style: TextStyle(fontWeight: FontWeight.w600))),
          piezas.when(
            data: (lista) => lista.isEmpty
                ? const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Sin repuestos registrados.'))
                : Column(
                    children: lista
                        .map((pieza) => FilaDato(
                              etiqueta:
                                  '${pieza.repuesto.nombre} × ${pieza.uso.cantidad}',
                              valor: formatoDinero(pieza.uso.cantidad *
                                  pieza.uso.precioUnitarioCentavos),
                            ))
                        .toList()),
            loading: () => const LinearProgressIndicator(),
            error: (error, _) => Text(error.toString()),
          ),
          FutureBuilder<int>(
            future: ref
                .read(tallerRepositoryProvider)
                .calcularTotalOrden(dato.orden.id),
            builder: (context, resultado) => FilaDato(
              etiqueta: 'Total de la orden',
              valor: resultado.hasData
                  ? formatoDinero(resultado.data!)
                  : 'Calculando…',
              destacado: true,
            ),
          ),
          if (ordenAbierta(dato.orden)) ...[
            const SizedBox(height: 8),
            Wrap(spacing: 6, runSpacing: 4, children: [
              OutlinedButton.icon(
                onPressed: () => crearTrabajo(context, ref, dato.orden.id),
                icon: const Icon(Icons.add_task),
                label: const Text('Trabajo'),
              ),
              OutlinedButton.icon(
                onPressed: () => usarRepuesto(context, ref, dato.orden.id),
                icon: const Icon(Icons.add_box_outlined),
                label: const Text('Repuesto'),
              ),
              if (siguienteEstadoOrden(dato.orden.estado)
                  case final estadoSiguiente?)
                FilledButton.icon(
                  onPressed: () => ejecutarAccion(
                    context,
                    () => ref
                        .read(ordenesViewModelProvider.notifier)
                        .cambiarEstado(dato.orden.id, estadoSiguiente),
                  ),
                  icon: const Icon(Icons.arrow_forward),
                  label: Text(_etiquetaSiguienteEstado(dato.orden.estado)),
                ),
              TextButton.icon(
                onPressed: () => cancelarOrden(context, ref, dato.orden.id),
                icon: const Icon(Icons.cancel_outlined),
                label: const Text('Cancelar orden'),
              ),
            ]),
          ],
        ],
      ),
    );
  }
}

// Traduce la próxima fase a una acción clara para el técnico.
String _etiquetaSiguienteEstado(String estado) {
  return switch (estado) {
    'Recibida' => 'Comenzar reparación',
    'En reparación' => 'Marcar como lista',
    'Lista' => 'Entregar al cliente',
    _ => 'Continuar',
  };
}
