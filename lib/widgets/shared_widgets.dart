import 'package:flutter/material.dart';

import '../data/database.dart';
import '../data/taller_repository.dart';

class Encabezado extends StatelessWidget {
  const Encabezado({super.key, required this.titulo, required this.subtitulo});
  final String titulo;
  final String subtitulo;

  // Presenta el título y la descripción de una pantalla.
  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(titulo, style: Theme.of(context).textTheme.headlineMedium),
          const SizedBox(height: 4),
          Text(
            subtitulo,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      );
}

class TituloSeccion extends StatelessWidget {
  const TituloSeccion({super.key, required this.titulo});
  final String titulo;

  // Resalta el encabezado de una sección.
  @override
  Widget build(BuildContext context) => Text(titulo,
      style: Theme.of(context)
          .textTheme
          .titleMedium
          ?.copyWith(fontWeight: FontWeight.bold));
}

class TarjetaIndicador extends StatelessWidget {
  const TarjetaIndicador(
      {super.key,
      required this.titulo,
      required this.valor,
      required this.icono});
  final String titulo;
  final String valor;
  final IconData icono;

  // Muestra una cifra rápida de actividad del taller.
  @override
  Widget build(BuildContext context) => Card(
      child: Padding(
          padding: const EdgeInsets.all(14),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Icon(icono),
            const SizedBox(height: 8),
            Text(valor, style: Theme.of(context).textTheme.headlineSmall),
            Text(titulo)
          ])));
}

class EstadoIcono extends StatelessWidget {
  const EstadoIcono({super.key, required this.estado});
  final String estado;

  // Asocia un color al estado de la orden.
  @override
  Widget build(BuildContext context) {
    final color = switch (estado) {
      'Recibida' => Colors.blue,
      'En reparación' => Colors.orange,
      'Lista' => Colors.green,
      'Entregada' => Colors.grey,
      _ => Colors.red,
    };
    return CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.12),
        child: Icon(Icons.build_outlined, color: color));
  }
}

class FilaDato extends StatelessWidget {
  const FilaDato(
      {super.key,
      required this.etiqueta,
      required this.valor,
      this.destacado = false});
  final String etiqueta;
  final String valor;
  final bool destacado;

  // Muestra una etiqueta junto a su valor.
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(children: [
        Expanded(
            child: Text(etiqueta,
                style: TextStyle(
                    fontWeight:
                        destacado ? FontWeight.bold : FontWeight.normal))),
        Flexible(child: Text(valor, textAlign: TextAlign.end))
      ]));
}

class EstadoVacio extends StatelessWidget {
  const EstadoVacio({super.key, required this.mensaje});
  final String mensaje;

  // Explica que la lista todavía no tiene registros.
  @override
  Widget build(BuildContext context) => Center(
      child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(mensaje, textAlign: TextAlign.center)));
}

class ErrorContenido extends StatelessWidget {
  const ErrorContenido({super.key, required this.mensaje});
  final String mensaje;

  // Informa que no se pudo cargar el contenido.
  @override
  Widget build(BuildContext context) => Center(
      child: Padding(
          padding: const EdgeInsets.all(20),
          child: Text('No se pudo cargar la información.\n$mensaje',
              textAlign: TextAlign.center)));
}

class AvisoBajo extends StatelessWidget {
  const AvisoBajo({super.key, required this.repuesto});
  final Repuesto repuesto;

  // Señala un repuesto que alcanzó su nivel mínimo.
  @override
  Widget build(BuildContext context) => Card(
      color: const Color(0xFFFFF5E5),
      child: ListTile(
          leading:
              const Icon(Icons.warning_amber_rounded, color: Colors.deepOrange),
          title: Text(repuesto.nombre),
          subtitle: Text(
              'Quedan ${repuesto.existencias} · mínimo ${repuesto.nivelMinimo}')));
}

class OrdenResumen extends StatelessWidget {
  const OrdenResumen({super.key, required this.dato});
  final OrdenConDetalles dato;

  // Resume el equipo, cliente y responsable de una orden.
  @override
  Widget build(BuildContext context) => Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
          leading: EstadoIcono(estado: dato.orden.estado),
          title: Text('${dato.dispositivo.marca} ${dato.dispositivo.modelo}'),
          subtitle: Text(
              '${dato.cliente.nombre} · ${dato.tecnico.nombre} · ${dato.orden.estado}')));
}

// Indica si la orden sigue pendiente de entrega o cancelación.
bool ordenAbierta(Orden orden) =>
    !['Entregada', 'Cancelada'].contains(orden.estado);

// Indica la próxima fase normal del flujo de reparación.
String? siguienteEstadoOrden(String estado) {
  return switch (estado) {
    'Recibida' => 'En reparación',
    'En reparación' => 'Lista',
    'Lista' => 'Entregada',
    _ => null,
  };
}

class ProcesoOrden extends StatelessWidget {
  const ProcesoOrden({super.key, required this.estado});

  final String estado;

  // Muestra visualmente el avance de la orden por sus estados.
  @override
  Widget build(BuildContext context) {
    const estados = ['Recibida', 'En reparación', 'Lista', 'Entregada'];
    final indiceActual = estados.indexOf(estado);
    if (indiceActual < 0) {
      return Chip(
        avatar: const Icon(Icons.cancel_outlined, size: 18),
        label: Text(estado),
      );
    }

    return Wrap(
      spacing: 6,
      runSpacing: 4,
      children: [
        for (var indice = 0; indice < estados.length; indice++)
          Chip(
            visualDensity: VisualDensity.compact,
            backgroundColor: indice <= indiceActual
                ? Theme.of(context).colorScheme.secondaryContainer
                : Theme.of(context).colorScheme.surfaceContainerHighest,
            label: Text(
              estados[indice],
              style: TextStyle(
                fontSize: 11,
                fontWeight: indice == indiceActual
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          ),
      ],
    );
  }
}
