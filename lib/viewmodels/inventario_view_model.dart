import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/providers.dart';

final inventarioViewModelProvider =
    NotifierProvider<InventarioViewModel, void>(InventarioViewModel.new);

class InventarioViewModel extends Notifier<void> {
  @override
  void build() {}

  // Registra un repuesto con sus datos de inventario.
  Future<void> registrarRepuesto({
    required String nombre,
    required String codigo,
    required int precioCentavos,
    required int existencias,
    required int nivelMinimo,
  }) async {
    if (nombre.trim().isEmpty || codigo.trim().isEmpty) {
      throw StateError('Escribe el nombre y el código del repuesto.');
    }
    if (precioCentavos < 0 || existencias < 0 || nivelMinimo < 0) {
      throw StateError('Precio, existencias y mínimo deben ser cero o más.');
    }
    await ref.read(tallerRepositoryProvider).registrarRepuesto(
          nombre: nombre,
          codigo: codigo,
          precioCentavos: precioCentavos,
          existencias: existencias,
          nivelMinimo: nivelMinimo,
        );
  }

  // Ajusta el inventario sin permitir valores negativos.
  Future<void> ajustarRepuesto({
    required int repuestoId,
    required int precioCentavos,
    required int existencias,
    required int nivelMinimo,
  }) {
    return ref.read(tallerRepositoryProvider).actualizarRepuesto(
          repuestoId: repuestoId,
          precioCentavos: precioCentavos,
          existencias: existencias,
          nivelMinimo: nivelMinimo,
        );
  }
}
