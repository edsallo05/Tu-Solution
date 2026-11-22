import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';

import '../data/database.dart';
import '../data/taller_repository.dart';
import '../app/providers.dart';
import '../viewmodels/clientes_view_model.dart';
import '../viewmodels/inventario_view_model.dart';
import '../viewmodels/ordenes_view_model.dart';
import '../viewmodels/tecnicos_view_model.dart';
import '../widgets/history_order_card.dart';

// Muestra campos sencillos y devuelve sus valores al confirmar.
Future<List<String>?> formulario(BuildContext context,
    {required String titulo, required List<String> etiquetas}) async {
  final controles = etiquetas.map((_) => TextEditingController()).toList();
  final claveFormulario = GlobalKey<FormState>();
  final resultado = await showDialog<List<String>>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      icon: const Icon(Icons.edit_note_outlined),
      title: Text(titulo),
      content: SizedBox(
        width: 440,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.58,
          ),
          child: Form(
            key: claveFormulario,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  for (var indice = 0; indice < etiquetas.length; indice++) ...[
                    if (indice > 0) const SizedBox(height: 16),
                    TextFormField(
                      controller: controles[indice],
                      validator: (valor) => validarCampoFormulario(
                        etiquetas[indice],
                        valor,
                      ),
                      keyboardType: tecladoCampo(etiquetas[indice]),
                      inputFormatters: formatoCampo(etiquetas[indice]),
                      textCapitalization:
                          capitalizacionCampo(etiquetas[indice]),
                      maxLength: longitudMaxima(etiquetas[indice]),
                      maxLines:
                          etiquetaEsDescripcion(etiquetas[indice]) ? 3 : 1,
                      decoration: InputDecoration(
                        labelText: etiquetas[indice],
                        prefixIcon: Icon(iconoCampo(etiquetas[indice])),
                        helperText: ayudaCampo(etiquetas[indice]),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 18,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        counterText:
                            etiquetas[indice].toLowerCase().contains('teléfono')
                                ? null
                                : '',
                        alignLabelWithHint:
                            etiquetaEsDescripcion(etiquetas[indice]),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
      actionsPadding: const EdgeInsets.fromLTRB(24, 0, 24, 20),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cancelar'),
        ),
        FilledButton.icon(
          onPressed: () {
            if (claveFormulario.currentState!.validate()) {
              Navigator.pop(
                dialogContext,
                controles.map((control) => control.text.trim()).toList(),
              );
            }
          },
          icon: const Icon(Icons.save_outlined),
          label: const Text('Guardar'),
        ),
      ],
    ),
  );
  for (final control in controles) {
    control.dispose();
  }
  return resultado;
}

// Valida que cada campo cumpla reglas acordes con el dato solicitado.
String? validarCampoFormulario(String etiqueta, String? valor) {
  final texto = etiqueta.toLowerCase();
  final contenido = valor?.trim() ?? '';
  final opcional = texto.contains('opcional');
  if (contenido.isEmpty) {
    if (opcional) return null;
    return 'Este campo es obligatorio.';
  }
  if (texto.contains('teléfono')) {
    return RegExp(r'^\d{8}$').hasMatch(contenido)
        ? null
        : 'El teléfono debe tener exactamente 8 dígitos.';
  }
  if (texto.contains('nombre completo')) {
    return RegExp(r"^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ][A-Za-zÁÉÍÓÚÜÑáéíóúüñ .'-]{1,59}$")
            .hasMatch(contenido)
        ? null
        : 'Escribe un nombre válido, sin números.';
  }
  if (texto.contains('nombre')) {
    return RegExp(r"^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ][A-Za-zÁÉÍÓÚÜÑáéíóúüñ .'-]{1,99}$")
            .hasMatch(contenido)
        ? null
        : 'Escribe un nombre válido, sin números.';
  }
  if (texto.contains('tipo (')) {
    return RegExp(r"^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ][A-Za-zÁÉÍÓÚÜÑáéíóúüñ -]{1,39}$")
            .hasMatch(contenido)
        ? null
        : 'Escribe un tipo de dispositivo válido.';
  }
  if (texto.contains('serie')) {
    return RegExp(r'^[A-Za-z0-9-]{2,40}$').hasMatch(contenido)
        ? null
        : 'Usa de 2 a 40 letras, números o guiones.';
  }
  if (texto.contains('precio') || texto.contains('costo')) {
    final cantidad = double.tryParse(contenido.replaceAll(',', '.'));
    if (cantidad == null || !cantidad.isFinite || cantidad <= 0) {
      return 'Escribe un importe numérico mayor que cero.';
    }
    return null;
  }
  if (texto.contains('existencias') ||
      texto.contains('mínimo') ||
      texto.contains('aviso') ||
      texto.contains('avisar')) {
    final cantidad = int.tryParse(contenido);
    if (cantidad == null || cantidad < 0) {
      return 'Escribe una cantidad entera igual o mayor que cero.';
    }
    return null;
  }
  if (texto.contains('descripción') || texto.contains('falla')) {
    return contenido.length >= 5
        ? null
        : 'Describe el trabajo o la falla con al menos 5 caracteres.';
  }
  if (texto.contains('marca')) {
    return RegExp(r'^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ0-9 .&-]{2,60}$').hasMatch(contenido)
        ? null
        : 'Escribe una marca válida.';
  }
  if (texto.contains('modelo')) {
    return RegExp(r'^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ0-9 ._-]{1,80}$').hasMatch(contenido)
        ? null
        : 'Escribe un modelo válido de hasta 80 caracteres.';
  }
  if (contenido.length < 2 || contenido.length > 100) {
    return 'Escribe entre 2 y 100 caracteres.';
  }
  return null;
}

// Selecciona un teclado apropiado para números, importes o texto.
TextInputType tecladoCampo(String etiqueta) {
  final texto = etiqueta.toLowerCase();
  if (texto.contains('teléfono') ||
      texto.contains('existencias') ||
      texto.contains('mínimo') ||
      texto.contains('aviso') ||
      texto.contains('avisar')) {
    return TextInputType.number;
  }
  if (texto.contains('precio') || texto.contains('costo')) {
    return const TextInputType.numberWithOptions(decimal: true);
  }
  return etiquetaEsDescripcion(etiqueta)
      ? TextInputType.multiline
      : TextInputType.text;
}

// Limita desde el teclado los dígitos y decimales que acepta cada campo.
List<TextInputFormatter> formatoCampo(String etiqueta) {
  final texto = etiqueta.toLowerCase();
  if (texto.contains('teléfono')) {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(8)
    ];
  }
  if (texto.contains('existencias') ||
      texto.contains('mínimo') ||
      texto.contains('aviso') ||
      texto.contains('avisar')) {
    return [
      FilteringTextInputFormatter.digitsOnly,
      LengthLimitingTextInputFormatter(7)
    ];
  }
  if (texto.contains('precio') || texto.contains('costo')) {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'^\d*[,.]?\d{0,2}')),
      LengthLimitingTextInputFormatter(12)
    ];
  }
  return const [];
}

// Capitaliza nombres y títulos para facilitar la escritura.
TextCapitalization capitalizacionCampo(String etiqueta) {
  if (etiqueta.toLowerCase().contains('descripción') ||
      etiqueta.toLowerCase().contains('falla')) {
    return TextCapitalization.sentences;
  }
  return TextCapitalization.words;
}

// Reconoce campos de texto que admiten una descripción en varias líneas.
bool etiquetaEsDescripcion(String etiqueta) {
  final texto = etiqueta.toLowerCase();
  return texto.contains('descripción') || texto.contains('falla');
}

// Mantiene la longitud del campo dentro de los límites de SQLite.
int longitudMaxima(String etiqueta) {
  final texto = etiqueta.toLowerCase();
  if (texto.contains('teléfono')) return 8;
  if (texto.contains('descripción')) return 500;
  if (texto.contains('falla')) return 1000;
  if (texto.contains('marca')) return 60;
  if (texto.contains('modelo')) return 80;
  if (texto.contains('tipo')) return 40;
  if (texto.contains('serie')) return 40;
  return 100;
}

// Da una pista de formato junto a los campos que la necesitan.
String? ayudaCampo(String etiqueta) {
  final texto = etiqueta.toLowerCase();
  if (texto.contains('teléfono')) return '8 dígitos';
  if (texto.contains('serie')) return 'Opcional · letras, números y guiones';
  if (texto.contains('precio') || texto.contains('costo')) {
    return 'Usa punto o coma para los decimales';
  }
  if (texto.contains('existencias') ||
      texto.contains('mínimo') ||
      texto.contains('aviso') ||
      texto.contains('avisar')) {
    return 'Número entero, puede ser cero';
  }
  return null;
}

// Asocia un icono reconocible con el tipo de dato del campo.
IconData iconoCampo(String etiqueta) {
  final texto = etiqueta.toLowerCase();
  if (texto.contains('teléfono')) return Icons.phone_outlined;
  if (texto.contains('nombre')) return Icons.person_outline;
  if (texto.contains('tipo') ||
      texto.contains('marca') ||
      texto.contains('modelo') ||
      texto.contains('serie')) {
    return Icons.devices_other_outlined;
  }
  if (texto.contains('código')) return Icons.qr_code_2_outlined;
  if (texto.contains('precio') || texto.contains('costo')) {
    return Icons.payments_outlined;
  }
  if (texto.contains('existencias') || texto.contains('mínimo')) {
    return Icons.inventory_2_outlined;
  }
  if (texto.contains('descripción') || texto.contains('falla')) {
    return Icons.notes_outlined;
  }
  return Icons.edit_outlined;
}

// Ejecuta una operación y comunica el resultado en la pantalla.
Future<void> ejecutarAccion(
    BuildContext context, Future<void> Function() accion) async {
  try {
    await accion();
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Cambios guardados.')));
    }
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.toString().replaceFirst('Bad state: ', ''))));
    }
  }
}

// Registra un cliente con nombre y teléfono.
Future<void> crearCliente(BuildContext context, WidgetRef ref) async {
  final datos = await formulario(context,
      titulo: 'Nuevo cliente',
      etiquetas: const ['Nombre completo', 'Teléfono']);
  if (datos == null || !context.mounted) return;
  await ejecutarAccion(
      context,
      () => ref
          .read(clientesViewModelProvider.notifier)
          .registrarCliente(datos[0], datos[1]));
}

// Registra un equipo relacionado con el cliente seleccionado.
Future<void> crearDispositivo(
    BuildContext context, WidgetRef ref, Cliente cliente) async {
  final datos = await formulario(context,
      titulo: 'Dispositivo de ${cliente.nombre}',
      etiquetas: const [
        'Tipo (celular, tablet...)',
        'Marca',
        'Modelo',
        'Número de serie (opcional)'
      ]);
  if (datos == null || !context.mounted) return;
  await ejecutarAccion(
      context,
      () => ref.read(clientesViewModelProvider.notifier).registrarDispositivo(
          clienteId: cliente.id,
          tipo: datos[0],
          marca: datos[1],
          modelo: datos[2],
          numeroSerie: datos[3]));
}

// Registra una orden para un equipo y asigna un técnico responsable.
Future<void> crearOrden(BuildContext context, WidgetRef ref) async {
  final dispositivos = await ref.read(dispositivosProvider.future);
  final tecnicos = await ref.read(tecnicosProvider.future);
  if (!context.mounted) return;
  if (dispositivos.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registra primero un cliente y su dispositivo.')));
    return;
  }
  var equipoSeleccionado = dispositivos.first;
  var tecnicoSeleccionado = tecnicos.first;
  final falla = TextEditingController();
  final claveFormulario = GlobalKey<FormState>();
  final confirmado = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => StatefulBuilder(
        builder: (context, actualizar) => AlertDialog(
              icon: const Icon(Icons.assignment_add),
              title: const Text('Nueva orden'),
              content: SizedBox(
                  width: 440,
                  child: Form(
                      key: claveFormulario,
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        DropdownButtonFormField<DispositivoConCliente>(
                            initialValue: equipoSeleccionado,
                            decoration: const InputDecoration(
                                labelText: 'Equipo y cliente'),
                            items: dispositivos
                                .map((dato) => DropdownMenuItem(
                                    value: dato,
                                    child: Text(
                                        '${dato.dispositivo.marca} ${dato.dispositivo.modelo} · ${dato.cliente.nombre}',
                                        overflow: TextOverflow.ellipsis)))
                                .toList(),
                            validator: (valor) =>
                                valor == null ? 'Selecciona un equipo.' : null,
                            onChanged: (valor) {
                              if (valor != null) {
                                actualizar(() => equipoSeleccionado = valor);
                              }
                            }),
                        const SizedBox(height: 12),
                        DropdownButtonFormField<Tecnico>(
                            initialValue: tecnicoSeleccionado,
                            decoration: const InputDecoration(
                                labelText: 'Técnico responsable'),
                            items: tecnicos
                                .map((tecnico) => DropdownMenuItem(
                                    value: tecnico,
                                    child: Text(tecnico.nombre)))
                                .toList(),
                            validator: (valor) => valor == null
                                ? 'Selecciona al técnico responsable.'
                                : null,
                            onChanged: (valor) {
                              if (valor != null) {
                                actualizar(() => tecnicoSeleccionado = valor);
                              }
                            }),
                        const SizedBox(height: 12),
                        TextFormField(
                            controller: falla,
                            maxLines: 3,
                            textCapitalization: TextCapitalization.sentences,
                            validator: (valor) => validarCampoFormulario(
                                'Falla reportada', valor),
                            decoration: const InputDecoration(
                                labelText: 'Falla reportada',
                                prefixIcon: Icon(Icons.notes_outlined),
                                alignLabelWithHint: true)),
                      ]))),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(dialogContext, false),
                    child: const Text('Cancelar')),
                FilledButton(
                    onPressed: () {
                      if (claveFormulario.currentState!.validate()) {
                        Navigator.pop(dialogContext, true);
                      }
                    },
                    child: const Text('Crear orden'))
              ],
            )),
  );
  if (confirmado == true && context.mounted) {
    await ejecutarAccion(
        context,
        () => ref.read(ordenesViewModelProvider.notifier).registrarOrden(
            dispositivoId: equipoSeleccionado.dispositivo.id,
            tecnicoId: tecnicoSeleccionado.id,
            falla: falla.text));
  }
  falla.dispose();
}

// Añade un trabajo y su costo de mano de obra a una orden.
Future<void> crearTrabajo(
    BuildContext context, WidgetRef ref, int ordenId) async {
  final datos = await formulario(context,
      titulo: 'Registrar trabajo',
      etiquetas: const ['Descripción', 'Costo de mano de obra']);
  if (datos == null || !context.mounted) return;
  final costo = double.tryParse(datos[1].replaceAll(',', '.'));
  if (costo == null) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Escribe un costo válido.')));
    return;
  }
  await ejecutarAccion(
      context,
      () => ref.read(ordenesViewModelProvider.notifier).agregarTrabajo(
          ordenId: ordenId,
          descripcion: datos[0],
          costeCentavos: (costo * 100).round()));
}

// Descuenta una pieza del inventario y la vincula con la orden.
Future<void> usarRepuesto(
    BuildContext context, WidgetRef ref, int ordenId) async {
  final repuestos = await ref.read(repuestosProvider.future);
  if (!context.mounted) return;
  if (repuestos.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Registra primero los repuestos del taller.')));
    return;
  }
  var seleccionado = repuestos.first;
  final cantidad = TextEditingController(text: '1');
  final claveFormulario = GlobalKey<FormState>();
  final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
          builder: (context, actualizar) => AlertDialog(
                icon: const Icon(Icons.inventory_2_outlined),
                title: const Text('Usar repuesto'),
                content: SizedBox(
                    width: 420,
                    child: Form(
                        key: claveFormulario,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          DropdownButtonFormField<Repuesto>(
                              initialValue: seleccionado,
                              decoration:
                                  const InputDecoration(labelText: 'Repuesto'),
                              items: repuestos
                                  .map((repuesto) => DropdownMenuItem(
                                      value: repuesto,
                                      child: Text(
                                          '${repuesto.nombre} · ${repuesto.existencias} disponibles',
                                          overflow: TextOverflow.ellipsis)))
                                  .toList(),
                              validator: (valor) => valor == null
                                  ? 'Selecciona un repuesto.'
                                  : null,
                              onChanged: (valor) {
                                if (valor != null) {
                                  actualizar(() => seleccionado = valor);
                                }
                              }),
                          const SizedBox(height: 12),
                          TextFormField(
                              controller: cantidad,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(7)
                              ],
                              validator: (valor) {
                                final numero = int.tryParse(valor ?? '');
                                if (numero == null || numero <= 0) {
                                  return 'La cantidad debe ser un entero mayor que cero.';
                                }
                                if (numero > seleccionado.existencias) {
                                  return 'Solo hay ${seleccionado.existencias} unidades disponibles.';
                                }
                                return null;
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Cantidad',
                                  prefixIcon: Icon(Icons.numbers),
                                  helperText:
                                      'No puede superar las existencias disponibles')),
                        ]))),
                actions: [
                  TextButton(
                      onPressed: () => Navigator.pop(dialogContext, false),
                      child: const Text('Cancelar')),
                  FilledButton(
                      onPressed: () {
                        if (claveFormulario.currentState!.validate()) {
                          Navigator.pop(dialogContext, true);
                        }
                      },
                      child: const Text('Descontar'))
                ],
              )));
  final numero = int.tryParse(cantidad.text) ?? 0;
  if (confirmado == true && context.mounted) {
    await ejecutarAccion(
        context,
        () => ref.read(ordenesViewModelProvider.notifier).agregarRepuesto(
            ordenId: ordenId, repuestoId: seleccionado.id, cantidad: numero));
  }
  cantidad.dispose();
}

// Confirma la cancelación antes de cerrar la orden y reponer sus piezas.
Future<void> cancelarOrden(
    BuildContext context, WidgetRef ref, int ordenId) async {
  final confirmar = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      icon: const Icon(Icons.cancel_outlined),
      title: const Text('Cancelar orden'),
      content: const Text(
        'La orden quedará cancelada y sus repuestos volverán al inventario.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext, false),
          child: const Text('Volver'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(dialogContext, true),
          child: const Text('Confirmar cancelación'),
        ),
      ],
    ),
  );
  if (confirmar != true || !context.mounted) return;
  await ejecutarAccion(
    context,
    () => ref
        .read(ordenesViewModelProvider.notifier)
        .cambiarEstado(ordenId, 'Cancelada'),
  );
}

// Registra una pieza con precio, existencias y umbral de aviso.
Future<void> crearRepuesto(BuildContext context, WidgetRef ref) async {
  final datos = await formulario(context,
      titulo: 'Nuevo repuesto',
      etiquetas: const [
        'Nombre',
        'Código',
        'Precio',
        'Existencias iniciales',
        'Avisar cuando queden'
      ]);
  if (datos == null || !context.mounted) return;
  final precio = double.tryParse(datos[2].replaceAll(',', '.'));
  final cantidad = int.tryParse(datos[3]);
  final minimo = int.tryParse(datos[4]);
  if (precio == null || cantidad == null || minimo == null) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comprueba el precio y las cantidades.')));
    return;
  }
  await ejecutarAccion(
      context,
      () => ref.read(inventarioViewModelProvider.notifier).registrarRepuesto(
          nombre: datos[0],
          codigo: datos[1],
          precioCentavos: (precio * 100).round(),
          existencias: cantidad,
          nivelMinimo: minimo));
}

// Ajusta el precio, existencias y mínimo de aviso de una pieza.
Future<void> editarRepuesto(
    BuildContext context, WidgetRef ref, Repuesto repuesto) async {
  final datos = await formulario(context,
      titulo: 'Ajustar ${repuesto.nombre}',
      etiquetas: const ['Nuevo precio', 'Existencias', 'Aviso de mínimo']);
  if (datos == null || !context.mounted) return;
  final precio = double.tryParse(datos[0].replaceAll(',', '.'));
  final cantidad = int.tryParse(datos[1]);
  final minimo = int.tryParse(datos[2]);
  if (precio == null || cantidad == null || minimo == null) {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Comprueba el precio y las cantidades.')));
    return;
  }
  await ejecutarAccion(
      context,
      () => ref.read(inventarioViewModelProvider.notifier).ajustarRepuesto(
          repuestoId: repuesto.id,
          precioCentavos: (precio * 100).round(),
          existencias: cantidad,
          nivelMinimo: minimo));
}

// Permite cambiar el responsable de una orden abierta.
Future<void> elegirTecnico(BuildContext context, WidgetRef ref,
    List<Tecnico> tecnicos, int ordenId) async {
  final tecnico = await showDialog<Tecnico>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
          title: const Text('Asignar responsable'),
          children: tecnicos
              .map((dato) => SimpleDialogOption(
                  onPressed: () => Navigator.pop(dialogContext, dato),
                  child: Text(dato.nombre)))
              .toList()));
  if (tecnico == null || !context.mounted) return;
  await ejecutarAccion(
      context,
      () => ref
          .read(ordenesViewModelProvider.notifier)
          .asignarTecnico(ordenId, tecnico.id));
}

// Consulta el historial de reparaciones de un cliente.
Future<void> mostrarHistorialCliente(
    BuildContext context, WidgetRef ref, Cliente cliente) async {
  await showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text('Historial de ${cliente.nombre}'),
      content: SizedBox(
        width: double.maxFinite,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.55,
          ),
          child: Consumer(
            builder: (context, ref, _) {
              final historial = ref.watch(
                historialClienteProvider(cliente.id),
              );
              return historial.when(
                data: (ordenes) => ordenes.isEmpty
                    ? const Text('Este cliente todavía no tiene reparaciones.')
                    : ListView(
                        shrinkWrap: true,
                        children: ordenes
                            .map((dato) => HistorialOrdenCard(dato: dato))
                            .toList(),
                      ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, _) => Text(
                  'No se pudo cargar el historial: $error',
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}

// Consulta las órdenes anteriores de un dispositivo.
Future<void> mostrarHistorialDispositivo(
    BuildContext context, WidgetRef ref, DispositivoConCliente equipo) async {
  await showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text('Historial · ${equipo.dispositivo.modelo}'),
      content: SizedBox(
        width: double.maxFinite,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.sizeOf(context).height * 0.55,
          ),
          child: Consumer(
            builder: (context, ref, _) {
              final historial = ref.watch(
                historialDispositivoProvider(equipo.dispositivo.id),
              );
              return historial.when(
                data: (ordenes) => ordenes.isEmpty
                    ? const Text('Este equipo todavía no tiene reparaciones.')
                    : ListView(
                        shrinkWrap: true,
                        children: ordenes
                            .map((dato) => HistorialOrdenCard(dato: dato))
                            .toList(),
                      ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, _) => Text(
                  'No se pudo cargar el historial: $error',
                ),
              );
            },
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(dialogContext),
          child: const Text('Cerrar'),
        ),
      ],
    ),
  );
}

// Muestra las órdenes abiertas asignadas a un técnico.
Future<void> mostrarCargaTecnico(BuildContext context, Tecnico tecnico,
    List<OrdenConDetalles> ordenes) async {
  await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
              title: Text('Órdenes de ${tecnico.nombre}'),
              content: SizedBox(
                  width: double.maxFinite,
                  child: ordenes.isEmpty
                      ? const Text('No tiene órdenes abiertas asignadas.')
                      : ListView(
                          shrinkWrap: true,
                          children: ordenes
                              .map((dato) => ListTile(
                                  title: Text(
                                      '${dato.dispositivo.marca} ${dato.dispositivo.modelo}'),
                                  subtitle: Text(
                                      'Orden #${dato.orden.id} · ${dato.orden.estado}')))
                              .toList())),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('Cerrar'))
              ]));
}

// Permite guardar el nombre real sin reasignar las órdenes del técnico.
Future<void> editarNombreTecnico(
    BuildContext context, WidgetRef ref, Tecnico tecnico) async {
  final datos = await formulario(
    context,
    titulo: 'Nombre del técnico',
    etiquetas: const ['Nombre completo'],
  );
  if (datos == null || !context.mounted) return;
  await ejecutarAccion(
    context,
    () => ref
        .read(tecnicosViewModelProvider.notifier)
        .cambiarNombre(tecnico.id, datos.first),
  );
}
