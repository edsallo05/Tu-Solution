import 'dart:io';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tu_solution/data/database.dart';
import 'package:tu_solution/data/taller_repository.dart';

void main() {
  // Comprueba el descuento, la reversión y la persistencia del inventario.
  test('el inventario es transaccional y conserva el historial', () async {
    final directorio =
        await Directory.systemTemp.createTemp('tu_solution_test_');
    final archivoBase =
        File('${directorio.path}${Platform.pathSeparator}taller.sqlite');
    var database = AppDatabase.forTesting(NativeDatabase(archivoBase));
    var repository = TallerRepository(database);

    final clienteId =
        await repository.registrarCliente('Ana Pérez', '55512345');
    final dispositivoId = await repository.registrarDispositivo(
      clienteId: clienteId,
      tipo: 'Celular',
      marca: 'Samsung',
      modelo: 'A54',
      numeroSerie: 'SERIE-01',
    );
    final tecnicoId = (await repository.observarTecnicos().first).first.id;
    await repository.cambiarNombreTecnico(tecnicoId, 'Juan Pérez');
    expect(
        (await repository.observarTecnicos().first).first.nombre, 'Juan Pérez');
    final ordenId = await repository.registrarOrden(
      dispositivoId: dispositivoId,
      tecnicoId: tecnicoId,
      falla: 'No carga',
    );
    final repuestoId = await repository.registrarRepuesto(
      nombre: 'Conector USB-C',
      codigo: 'USB-C-01',
      precioCentavos: 1500,
      existencias: 5,
      nivelMinimo: 1,
    );

    await repository.agregarRepuestoAOrden(
      ordenId: ordenId,
      repuestoId: repuestoId,
      cantidad: 2,
    );
    await repository.agregarTrabajo(
      ordenId: ordenId,
      descripcion: 'Cambio de conector',
      costeCentavos: 4000,
    );

    expect((await repository.observarRepuestos().first).single.existencias, 3);
    await expectLater(
      repository.cambiarEstadoOrden(ordenId, 'Entregada'),
      throwsA(isA<StateError>()),
    );
    expect(await repository.calcularTotalOrden(ordenId), 7000);
    await expectLater(
      repository.agregarRepuestoAOrden(
          ordenId: ordenId, repuestoId: repuestoId, cantidad: 4),
      throwsA(isA<StateError>()),
    );
    expect((await repository.observarRepuestos().first).single.existencias, 3);

    await repository.cambiarEstadoOrden(ordenId, 'Cancelada');
    await repository.cambiarEstadoOrden(ordenId, 'Cancelada');
    expect((await repository.observarRepuestos().first).single.existencias, 5);
    await database.close();

    database = AppDatabase.forTesting(NativeDatabase(archivoBase));
    repository = TallerRepository(database);
    expect((await repository.observarRepuestos().first).single.existencias, 5);
    final historial =
        await repository.observarHistorialCliente(clienteId).first;
    expect(historial, hasLength(1));
    expect(historial.single.orden.estado, 'Cancelada');

    await database.close();
    await directorio.delete(recursive: true);
  });
}
