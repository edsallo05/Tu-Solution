import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/providers.dart';

final ordenesViewModelProvider =
    NotifierProvider<OrdenesViewModel, void>(OrdenesViewModel.new);

class OrdenesViewModel extends Notifier<void> {
  @override
  void build() {}

  // Abre una orden nueva con su equipo, falla y técnico responsable.
  Future<void> registrarOrden({
    required int dispositivoId,
    required int tecnicoId,
    required String falla,
  }) async {
    if (falla.trim().isEmpty) {
      throw StateError('Describe la falla reportada.');
    }
    await ref.read(tallerRepositoryProvider).registrarOrden(
          dispositivoId: dispositivoId,
          tecnicoId: tecnicoId,
          falla: falla,
        );
  }

  // Cambia el estado de una reparación mediante el repositorio.
  Future<void> cambiarEstado(int ordenId, String estado) {
    return ref
        .read(tallerRepositoryProvider)
        .cambiarEstadoOrden(ordenId, estado);
  }

  // Cambia el técnico responsable de una reparación.
  Future<void> asignarTecnico(int ordenId, int tecnicoId) {
    return ref
        .read(tallerRepositoryProvider)
        .asignarTecnico(ordenId, tecnicoId);
  }

  // Registra un trabajo con su costo expresado en centavos.
  Future<void> agregarTrabajo({
    required int ordenId,
    required String descripcion,
    required int costeCentavos,
  }) async {
    if (descripcion.trim().isEmpty || costeCentavos < 0) {
      throw StateError('Comprueba la descripción y el costo del trabajo.');
    }
    await ref.read(tallerRepositoryProvider).agregarTrabajo(
          ordenId: ordenId,
          descripcion: descripcion,
          costeCentavos: costeCentavos,
        );
  }

  // Añade piezas a una reparación y controla las existencias.
  Future<void> agregarRepuesto({
    required int ordenId,
    required int repuestoId,
    required int cantidad,
  }) {
    return ref.read(tallerRepositoryProvider).agregarRepuestoAOrden(
          ordenId: ordenId,
          repuestoId: repuestoId,
          cantidad: cantidad,
        );
  }
}
