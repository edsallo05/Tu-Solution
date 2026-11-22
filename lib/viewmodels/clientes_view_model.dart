import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/providers.dart';

final clientesViewModelProvider =
    NotifierProvider<ClientesViewModel, void>(ClientesViewModel.new);

class ClientesViewModel extends Notifier<void> {
  @override
  void build() {}

  // Registra un cliente después de validar sus datos principales.
  Future<void> registrarCliente(String nombre, String telefono) async {
    if (nombre.trim().isEmpty || telefono.trim().isEmpty) {
      throw StateError('Escribe el nombre y el teléfono del cliente.');
    }
    await ref.read(tallerRepositoryProvider).registrarCliente(nombre, telefono);
  }

  // Registra un equipo y lo relaciona con un cliente existente.
  Future<void> registrarDispositivo({
    required int clienteId,
    required String tipo,
    required String marca,
    required String modelo,
    required String numeroSerie,
  }) async {
    if ([tipo, marca, modelo].any((dato) => dato.trim().isEmpty)) {
      throw StateError('Completa el tipo, la marca y el modelo del equipo.');
    }
    await ref.read(tallerRepositoryProvider).registrarDispositivo(
          clienteId: clienteId,
          tipo: tipo,
          marca: marca,
          modelo: modelo,
          numeroSerie: numeroSerie,
        );
  }
}
