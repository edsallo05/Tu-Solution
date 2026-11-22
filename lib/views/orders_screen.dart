import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/providers.dart';
import '../data/taller_repository.dart';
import '../widgets/order_components.dart';
import '../widgets/shared_widgets.dart';
import 'workshop_actions.dart';

class OrdenesScreen extends ConsumerStatefulWidget {
  const OrdenesScreen({super.key});

  @override
  ConsumerState<OrdenesScreen> createState() => _OrdenesScreenState();
}

class _OrdenesScreenState extends ConsumerState<OrdenesScreen> {
  String _filtroSeleccionado = 'Abiertas';

  // Presenta órdenes y permite filtrarlas por estado.
  @override
  Widget build(BuildContext context) {
    final ordenesAsync = ref.watch(ordenesProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Órdenes de reparación'),
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => crearOrden(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Nueva orden'),
      ),
      body: ordenesAsync.when(
        data: (ordenes) {
          final ordenesFiltradas = ordenes.where(_coincideConFiltro).toList();
          return Column(
            children: [
              _filtros(),
              Expanded(
                child: ordenesFiltradas.isEmpty
                    ? EstadoVacio(
                        mensaje: ordenes.isEmpty
                            ? 'Registra la primera orden de reparación.'
                            : 'No hay órdenes para este filtro.',
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
                        itemCount: ordenesFiltradas.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, indice) =>
                            OrdenCard(dato: ordenesFiltradas[indice]),
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorContenido(mensaje: error.toString()),
      ),
    );
  }

  // Filtra las órdenes según el estado elegido en la barra.
  bool _coincideConFiltro(OrdenConDetalles orden) {
    return switch (_filtroSeleccionado) {
      'Abiertas' => ordenAbierta(orden.orden),
      'Recibidas' => orden.orden.estado == 'Recibida',
      'En reparación' => orden.orden.estado == 'En reparación',
      'Listas' => orden.orden.estado == 'Lista',
      'Entregadas' => orden.orden.estado == 'Entregada',
      'Canceladas' => orden.orden.estado == 'Cancelada',
      _ => true,
    };
  }

  // Muestra filtros táctiles en una fila que puede desplazarse.
  Widget _filtros() {
    const filtros = [
      'Abiertas',
      'Todas',
      'Recibidas',
      'En reparación',
      'Listas',
      'Entregadas',
      'Canceladas',
    ];
    return SizedBox(
      height: 56,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        scrollDirection: Axis.horizontal,
        itemCount: filtros.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, indice) {
          final filtro = filtros[indice];
          return ChoiceChip(
            label: Text(filtro),
            selected: _filtroSeleccionado == filtro,
            onSelected: (_) => setState(() => _filtroSeleccionado = filtro),
          );
        },
      ),
    );
  }
}
