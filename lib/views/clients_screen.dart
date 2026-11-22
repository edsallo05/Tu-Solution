import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/providers.dart';
import '../widgets/shared_widgets.dart';
import 'workshop_actions.dart';

class ClientesScreen extends ConsumerWidget {
  const ClientesScreen({super.key});

  // Permite registrar clientes y consultar sus equipos e historial.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientes = ref.watch(clientesProvider);
    final dispositivos = ref.watch(dispositivosProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          title: const Text('Clientes y dispositivos'),
          backgroundColor: Colors.transparent),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => crearCliente(context, ref),
        icon: const Icon(Icons.person_add_alt_1),
        label: const Text('Nuevo cliente'),
      ),
      body: clientes.when(
        data: (listaClientes) => dispositivos.when(
          data: (listaDispositivos) {
            if (listaClientes.isEmpty) {
              return const EstadoVacio(
                  mensaje: 'Registra un cliente para comenzar.');
            }
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
              itemCount: listaClientes.length,
              itemBuilder: (context, indice) {
                final cliente = listaClientes[indice];
                final equipos = listaDispositivos
                    .where((dato) => dato.cliente.id == cliente.id)
                    .toList();
                return Card(
                  child: ExpansionTile(
                    leading:
                        const CircleAvatar(child: Icon(Icons.person_outline)),
                    title: Text(cliente.nombre,
                        style: const TextStyle(fontWeight: FontWeight.w600)),
                    subtitle: Text(cliente.telefono),
                    childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () =>
                              mostrarHistorialCliente(context, ref, cliente),
                          icon: const Icon(Icons.history),
                          label: const Text('Historial del cliente'),
                        ),
                      ),
                      ...equipos.map((dato) => ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: const Icon(Icons.devices_other),
                            title: Text(
                                '${dato.dispositivo.marca} ${dato.dispositivo.modelo}'),
                            subtitle: Text(
                                '${dato.dispositivo.tipo} · Serie: ${dato.dispositivo.numeroSerie ?? '—'}'),
                            trailing: IconButton(
                              tooltip: 'Historial del equipo',
                              icon: const Icon(Icons.history),
                              onPressed: () => mostrarHistorialDispositivo(
                                  context, ref, dato),
                            ),
                          )),
                      if (equipos.isEmpty)
                        const Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Aún no hay equipos.')),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () =>
                              crearDispositivo(context, ref, cliente),
                          icon: const Icon(Icons.add),
                          label: const Text('Agregar dispositivo'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => ErrorContenido(mensaje: error.toString()),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorContenido(mensaje: error.toString()),
      ),
    );
  }
}
