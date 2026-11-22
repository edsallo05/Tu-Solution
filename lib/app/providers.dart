import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../data/taller_repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(database.close);
  return database;
});

final tallerRepositoryProvider = Provider<TallerRepository>((ref) {
  return TallerRepository(ref.watch(databaseProvider));
});

final clientesProvider = StreamProvider((ref) {
  return ref.watch(tallerRepositoryProvider).observarClientes();
});

final dispositivosProvider = StreamProvider((ref) {
  return ref.watch(tallerRepositoryProvider).observarDispositivos();
});

final ordenesProvider = StreamProvider((ref) {
  return ref.watch(tallerRepositoryProvider).observarOrdenes();
});

final tecnicosProvider = StreamProvider((ref) {
  return ref.watch(tallerRepositoryProvider).observarTecnicos();
});

final repuestosProvider = StreamProvider((ref) {
  return ref.watch(tallerRepositoryProvider).observarRepuestos();
});

final trabajosOrdenProvider = StreamProvider.family((ref, int ordenId) {
  return ref.watch(tallerRepositoryProvider).observarTrabajos(ordenId);
});

final piezasOrdenProvider = StreamProvider.family((ref, int ordenId) {
  return ref.watch(tallerRepositoryProvider).observarRepuestosDeOrden(ordenId);
});

final historialClienteProvider = StreamProvider.family((ref, int clienteId) {
  return ref
      .watch(tallerRepositoryProvider)
      .observarHistorialCliente(clienteId);
});

final historialDispositivoProvider =
    StreamProvider.family((ref, int dispositivoId) {
  return ref
      .watch(tallerRepositoryProvider)
      .observarHistorialDispositivo(dispositivoId);
});
