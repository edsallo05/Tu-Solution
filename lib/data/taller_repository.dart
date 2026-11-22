import 'package:drift/drift.dart';

import 'database.dart';

class TallerRepository {
  TallerRepository(this._database);

  final AppDatabase _database;

  // Observa los clientes registrados y mantiene la lista actualizada.
  Stream<List<Cliente>> observarClientes() =>
      _database.select(_database.clientes).watch();

  // Observa los dispositivos junto con el nombre de su propietario.
  Stream<List<DispositivoConCliente>> observarDispositivos() {
    final consulta = _database.select(_database.dispositivos).join([
      innerJoin(
        _database.clientes,
        _database.clientes.id.equalsExp(_database.dispositivos.clienteId),
      ),
    ]);
    return consulta.watch().map((filas) => filas.map((fila) {
          return DispositivoConCliente(
            fila.readTable(_database.dispositivos),
            fila.readTable(_database.clientes),
          );
        }).toList());
  }

  // Observa las órdenes con el dispositivo, cliente y técnico asignados.
  Stream<List<OrdenConDetalles>> observarOrdenes() {
    final consulta = _database.select(_database.ordenes).join([
      innerJoin(
        _database.dispositivos,
        _database.dispositivos.id.equalsExp(_database.ordenes.dispositivoId),
      ),
      innerJoin(
        _database.clientes,
        _database.clientes.id.equalsExp(_database.dispositivos.clienteId),
      ),
      innerJoin(
        _database.tecnicos,
        _database.tecnicos.id.equalsExp(_database.ordenes.tecnicoId),
      ),
    ])
      ..orderBy([OrderingTerm.desc(_database.ordenes.fechaRecepcion)]);
    return consulta.watch().map((filas) => filas.map((fila) {
          return OrdenConDetalles(
            fila.readTable(_database.ordenes),
            fila.readTable(_database.dispositivos),
            fila.readTable(_database.clientes),
            fila.readTable(_database.tecnicos),
          );
        }).toList());
  }

  // Observa las órdenes de un equipo para mostrar su historial.
  Stream<List<OrdenConDetalles>> observarHistorialDispositivo(
      int dispositivoId) {
    return observarOrdenes().map((ordenes) => ordenes
        .where((orden) => orden.orden.dispositivoId == dispositivoId)
        .toList());
  }

  // Observa el historial de todos los equipos de un cliente.
  Stream<List<OrdenConDetalles>> observarHistorialCliente(int clienteId) {
    return observarOrdenes().map((ordenes) =>
        ordenes.where((orden) => orden.cliente.id == clienteId).toList());
  }

  // Observa los tres técnicos del taller.
  Stream<List<Tecnico>> observarTecnicos() =>
      _database.select(_database.tecnicos).watch();

  // Cambia el nombre visible sin alterar las órdenes ya asignadas.
  Future<void> cambiarNombreTecnico(int tecnicoId, String nombre) async {
    final nombreLimpio = nombre.trim();
    if (nombreLimpio.length < 2 || nombreLimpio.length > 100) {
      throw StateError('El nombre debe tener entre 2 y 100 caracteres.');
    }
    if (!RegExp(r"^[A-Za-zÁÉÍÓÚÜÑáéíóúüñ .'-]+$").hasMatch(nombreLimpio)) {
      throw StateError('El nombre del técnico no puede incluir números.');
    }
    await (_database.update(_database.tecnicos)
          ..where((tecnico) => tecnico.id.equals(tecnicoId)))
        .write(TecnicosCompanion(nombre: Value(nombreLimpio)));
  }

  // Observa el inventario disponible y sus niveles mínimos.
  Stream<List<Repuesto>> observarRepuestos() =>
      _database.select(_database.repuestos).watch();

  // Observa los trabajos de mano de obra de una orden.
  Stream<List<Trabajo>> observarTrabajos(int ordenId) {
    return (_database.select(_database.trabajos)
          ..where((trabajo) => trabajo.ordenId.equals(ordenId)))
        .watch();
  }

  // Observa los repuestos cargados a una orden con su información actual.
  Stream<List<RepuestoConUso>> observarRepuestosDeOrden(int ordenId) {
    final consulta = _database.select(_database.repuestosOrden).join([
      innerJoin(
        _database.repuestos,
        _database.repuestos.id.equalsExp(_database.repuestosOrden.repuestoId),
      ),
    ])
      ..where(_database.repuestosOrden.ordenId.equals(ordenId));
    return consulta.watch().map((filas) => filas.map((fila) {
          return RepuestoConUso(
            fila.readTable(_database.repuestosOrden),
            fila.readTable(_database.repuestos),
          );
        }).toList());
  }

  // Registra un cliente y devuelve su identificador.
  Future<int> registrarCliente(String nombre, String telefono) {
    return _database.into(_database.clientes).insert(
          ClientesCompanion.insert(
              nombre: nombre.trim(), telefono: telefono.trim()),
        );
  }

  // Registra un dispositivo asociado a su propietario.
  Future<int> registrarDispositivo({
    required int clienteId,
    required String tipo,
    required String marca,
    required String modelo,
    required String numeroSerie,
  }) {
    return _database.into(_database.dispositivos).insert(
          DispositivosCompanion.insert(
            clienteId: clienteId,
            tipo: tipo.trim(),
            marca: marca.trim(),
            modelo: modelo.trim(),
            numeroSerie:
                Value(numeroSerie.trim().isEmpty ? null : numeroSerie.trim()),
          ),
        );
  }

  // Registra una visita como una orden nueva para el dispositivo.
  Future<int> registrarOrden({
    required int dispositivoId,
    required int tecnicoId,
    required String falla,
  }) {
    return _database.into(_database.ordenes).insert(
          OrdenesCompanion.insert(
            dispositivoId: dispositivoId,
            tecnicoId: tecnicoId,
            fallaReportada: falla.trim(),
          ),
        );
  }

  // Cambia el estado de la orden y repone sus piezas si se cancela.
  Future<void> cambiarEstadoOrden(int ordenId, String nuevoEstado) async {
    await _database.transaction(() async {
      final orden = await (_database.select(_database.ordenes)
            ..where((fila) => fila.id.equals(ordenId)))
          .getSingle();
      if (orden.estado == nuevoEstado) return;
      if (orden.estado == 'Entregada' || orden.estado == 'Cancelada') {
        throw StateError(
            'La orden ya está cerrada y no se puede cambiar de estado.');
      }

      final estadosPermitidos = switch (orden.estado) {
        'Recibida' => ['En reparación', 'Cancelada'],
        'En reparación' => ['Lista', 'Cancelada'],
        'Lista' => ['Entregada', 'Cancelada'],
        _ => <String>[],
      };
      if (!estadosPermitidos.contains(nuevoEstado)) {
        throw StateError('Ese cambio no corresponde al flujo de la orden.');
      }

      if (nuevoEstado == 'Cancelada' && orden.estado != 'Cancelada') {
        final usos = await (_database.select(_database.repuestosOrden)
              ..where((uso) => uso.ordenId.equals(ordenId)))
            .get();
        for (final uso in usos) {
          await (_database.update(_database.repuestos)
                ..where((repuesto) => repuesto.id.equals(uso.repuestoId)))
              .write(RepuestosCompanion.custom(
            existencias:
                _database.repuestos.existencias + Variable(uso.cantidad),
          ));
        }
      }

      final fechaEntrega = nuevoEstado == 'Entregada'
          ? Value<DateTime?>(DateTime.now())
          : const Value<DateTime?>.absent();
      await (_database.update(_database.ordenes)
            ..where((fila) => fila.id.equals(ordenId)))
          .write(OrdenesCompanion(
              estado: Value(nuevoEstado), fechaEntrega: fechaEntrega));
    });
  }

  // Asigna un técnico distinto a una orden existente.
  Future<void> asignarTecnico(int ordenId, int tecnicoId) async {
    await (_database.update(_database.ordenes)
          ..where((fila) => fila.id.equals(ordenId)))
        .write(OrdenesCompanion(tecnicoId: Value(tecnicoId)));
  }

  // Añade el coste de mano de obra a la orden.
  Future<void> agregarTrabajo({
    required int ordenId,
    required String descripcion,
    required int costeCentavos,
  }) async {
    await _database.transaction(() async {
      final orden = await (_database.select(_database.ordenes)
            ..where((fila) => fila.id.equals(ordenId)))
          .getSingle();
      if (orden.estado == 'Cancelada' || orden.estado == 'Entregada') {
        throw StateError('No se pueden agregar trabajos a una orden cerrada.');
      }
      await _database.into(_database.trabajos).insert(
            TrabajosCompanion.insert(
              ordenId: ordenId,
              descripcion: descripcion.trim(),
              costeCentavos: costeCentavos,
            ),
          );
    });
  }

  // Registra una pieza usada y descuenta sus existencias en una transacción.
  Future<void> agregarRepuestoAOrden({
    required int ordenId,
    required int repuestoId,
    required int cantidad,
  }) async {
    await _database.transaction(() async {
      final orden = await (_database.select(_database.ordenes)
            ..where((fila) => fila.id.equals(ordenId)))
          .getSingle();
      if (orden.estado == 'Cancelada' || orden.estado == 'Entregada') {
        throw StateError('No se pueden agregar piezas a una orden cerrada.');
      }

      final repuesto = await (_database.select(_database.repuestos)
            ..where((fila) => fila.id.equals(repuestoId)))
          .getSingle();
      if (cantidad <= 0 || repuesto.existencias < cantidad) {
        throw StateError('No hay existencias suficientes para esa cantidad.');
      }

      await (_database.update(_database.repuestos)
            ..where((fila) => fila.id.equals(repuestoId)))
          .write(RepuestosCompanion(
        existencias: Value(repuesto.existencias - cantidad),
      ));

      final usoExistente = await (_database.select(_database.repuestosOrden)
            ..where((fila) =>
                fila.ordenId.equals(ordenId) &
                fila.repuestoId.equals(repuestoId)))
          .getSingleOrNull();
      if (usoExistente == null) {
        await _database.into(_database.repuestosOrden).insert(
              RepuestosOrdenCompanion.insert(
                ordenId: ordenId,
                repuestoId: repuestoId,
                cantidad: cantidad,
                precioUnitarioCentavos: repuesto.precioCentavos,
              ),
            );
      } else {
        await (_database.update(_database.repuestosOrden)
              ..where((fila) => fila.id.equals(usoExistente.id)))
            .write(RepuestosOrdenCompanion(
          cantidad: Value(usoExistente.cantidad + cantidad),
        ));
      }
    });
  }

  // Registra un repuesto con precio, existencias y nivel de aviso.
  Future<int> registrarRepuesto({
    required String nombre,
    required String codigo,
    required int precioCentavos,
    required int existencias,
    required int nivelMinimo,
  }) {
    return _database.into(_database.repuestos).insert(
          RepuestosCompanion.insert(
            nombre: nombre.trim(),
            codigo: codigo.trim(),
            precioCentavos: precioCentavos,
            existencias: existencias,
            nivelMinimo: Value(nivelMinimo),
          ),
        );
  }

  // Actualiza el precio y el inventario de un repuesto.
  Future<void> actualizarRepuesto({
    required int repuestoId,
    required int precioCentavos,
    required int existencias,
    required int nivelMinimo,
  }) async {
    if (existencias < 0 || precioCentavos < 0 || nivelMinimo < 0) {
      throw StateError(
          'El precio, las existencias y el mínimo no pueden ser negativos.');
    }
    await (_database.update(_database.repuestos)
          ..where((fila) => fila.id.equals(repuestoId)))
        .write(RepuestosCompanion(
      precioCentavos: Value(precioCentavos),
      existencias: Value(existencias),
      nivelMinimo: Value(nivelMinimo),
    ));
  }

  // Calcula el costo total a partir de los trabajos y piezas registradas.
  Future<int> calcularTotalOrden(int ordenId) async {
    final trabajos = await observarTrabajos(ordenId).first;
    final piezas = await observarRepuestosDeOrden(ordenId).first;
    final costeTrabajos =
        trabajos.fold<int>(0, (suma, trabajo) => suma + trabajo.costeCentavos);
    final costePiezas = piezas.fold<int>(
      0,
      (suma, pieza) =>
          suma + pieza.uso.cantidad * pieza.uso.precioUnitarioCentavos,
    );
    return costeTrabajos + costePiezas;
  }
}

class DispositivoConCliente {
  const DispositivoConCliente(this.dispositivo, this.cliente);

  final Dispositivo dispositivo;
  final Cliente cliente;
}

class OrdenConDetalles {
  const OrdenConDetalles(
      this.orden, this.dispositivo, this.cliente, this.tecnico);

  final Orden orden;
  final Dispositivo dispositivo;
  final Cliente cliente;
  final Tecnico tecnico;
}

class RepuestoConUso {
  const RepuestoConUso(this.uso, this.repuesto);

  final RepuestosOrdenData uso;
  final Repuesto repuesto;
}
