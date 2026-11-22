import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app/providers.dart';

final tecnicosViewModelProvider =
    NotifierProvider<TecnicosViewModel, void>(TecnicosViewModel.new);

class TecnicosViewModel extends Notifier<void> {
  @override
  void build() {}

  // Renombra un técnico conservando sus órdenes asignadas.
  Future<void> cambiarNombre(int tecnicoId, String nombre) {
    if (!RegExp(r"^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ][A-Za-zÁÉÍÓÚÜÑáéíóúüñ .'-]{1,99}$")
        .hasMatch(nombre.trim())) {
      throw StateError('Escribe un nombre válido sin números.');
    }
    return ref
        .read(tallerRepositoryProvider)
        .cambiarNombreTecnico(tecnicoId, nombre);
  }
}
