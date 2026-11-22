import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/providers.dart';
import '../widgets/shared_widgets.dart';
import 'workshop_actions.dart';

class TecnicosScreen extends ConsumerWidget {
  const TecnicosScreen({super.key});

  // Resume la carga de órdenes abiertas para cada técnico.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tecnicos = ref.watch(tecnicosProvider);
    final ordenes = ref.watch(ordenesProvider);
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
      children: [
        const Encabezado(
          titulo: 'Equipo técnico',
          subtitulo: 'Edita los nombres y revisa la carga asignada',
        ),
        const SizedBox(height: 16),
        tecnicos.when(
          data: (listaTecnicos) => ordenes.when(
            data: (listaOrdenes) => Column(
              children: listaTecnicos.map((tecnico) {
                final asignadas = listaOrdenes
                    .where((dato) =>
                        dato.tecnico.id == tecnico.id &&
                        ordenAbierta(dato.orden))
                    .toList();
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: const CircleAvatar(
                        child: Icon(Icons.engineering_outlined)),
                    title: Text(tecnico.nombre,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(
                        '${asignadas.length} ${asignadas.length == 1 ? 'orden abierta' : 'órdenes abiertas'}'),
                    trailing: IconButton(
                      tooltip: 'Cambiar nombre',
                      icon: const Icon(Icons.edit_outlined),
                      onPressed: () =>
                          editarNombreTecnico(context, ref, tecnico),
                    ),
                    onTap: () =>
                        mostrarCargaTecnico(context, tecnico, asignadas),
                  ),
                );
              }).toList(),
            ),
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, _) => ErrorContenido(mensaje: error.toString()),
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorContenido(mensaje: error.toString()),
        ),
      ],
    );
  }
}
