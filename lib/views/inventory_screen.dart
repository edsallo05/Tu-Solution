import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../app/providers.dart';
import '../widgets/shared_widgets.dart';
import '../widgets/widget_formatters.dart';
import 'workshop_actions.dart';

class InventarioScreen extends ConsumerWidget {
  const InventarioScreen({super.key});

  // Muestra existencias y facilita registrar o ajustar repuestos.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repuestos = ref.watch(repuestosProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          title: const Text('Inventario'), backgroundColor: Colors.transparent),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => crearRepuesto(context, ref),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo repuesto'),
      ),
      body: repuestos.when(
        data: (lista) {
          if (lista.isEmpty) {
            return const EstadoVacio(
                mensaje: 'Agrega los repuestos disponibles en el taller.');
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 96),
            itemCount: lista.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, indice) {
              final repuesto = lista[indice];
              final bajo = repuesto.existencias <= repuesto.nivelMinimo;
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: bajo
                        ? const Color(0xFFFFE8E5)
                        : const Color(0xFFE6F4EA),
                    child: Icon(Icons.memory,
                        color:
                            bajo ? Colors.red.shade700 : Colors.green.shade700),
                  ),
                  title: Text(repuesto.nombre,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  subtitle: Text(
                      'Código ${repuesto.codigo} · ${formatoDinero(repuesto.precioCentavos)}${bajo ? ' · Existencias bajas' : ''}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${repuesto.existencias}',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: bajo ? Colors.red.shade700 : null)),
                      Text('mín. ${repuesto.nivelMinimo}',
                          style: const TextStyle(fontSize: 11)),
                    ],
                  ),
                  onTap: () => editarRepuesto(context, ref, repuesto),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => ErrorContenido(mensaje: error.toString()),
      ),
    );
  }
}
