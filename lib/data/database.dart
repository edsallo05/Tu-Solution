import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

class Clientes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100)();
  TextColumn get telefono => text().withLength(min: 1, max: 30)();
  DateTimeColumn get fechaRegistro =>
      dateTime().withDefault(currentDateAndTime)();
}

class Dispositivos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clienteId => integer().references(Clientes, #id)();
  TextColumn get tipo => text().withLength(min: 1, max: 40)();
  TextColumn get marca => text().withLength(min: 1, max: 60)();
  TextColumn get modelo => text().withLength(min: 1, max: 80)();
  TextColumn get numeroSerie => text().nullable()();
}

class Tecnicos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100).unique()();
}

@DataClassName('Orden')
class Ordenes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get dispositivoId => integer().references(Dispositivos, #id)();
  IntColumn get tecnicoId => integer().references(Tecnicos, #id)();
  TextColumn get fallaReportada => text().withLength(min: 1, max: 1000)();
  TextColumn get estado => text().withDefault(const Constant('Recibida'))();
  DateTimeColumn get fechaRecepcion =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get fechaEntrega => dateTime().nullable()();
}

class Trabajos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ordenId => integer().references(Ordenes, #id)();
  TextColumn get descripcion => text().withLength(min: 1, max: 500)();
  IntColumn get costeCentavos => integer()();
}

class Repuestos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 100)();
  TextColumn get codigo => text().unique()();
  IntColumn get precioCentavos => integer()();
  IntColumn get existencias => integer()();
  IntColumn get nivelMinimo => integer().withDefault(const Constant(3))();
}

class RepuestosOrden extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ordenId => integer().references(Ordenes, #id)();
  IntColumn get repuestoId => integer().references(Repuestos, #id)();
  IntColumn get cantidad => integer()();
  IntColumn get precioUnitarioCentavos => integer()();

  @override
  List<Set<Column>>? get uniqueKeys => [
        {ordenId, repuestoId},
      ];
}

@DriftDatabase(tables: [
  Clientes,
  Dispositivos,
  Tecnicos,
  Ordenes,
  Trabajos,
  Repuestos,
  RepuestosOrden,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_abrirConexion());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) async {
          await migrator.createAll();
          await batch((lote) {
            lote.insertAll(
              tecnicos,
              [
                TecnicosCompanion.insert(nombre: 'Técnico 1'),
                TecnicosCompanion.insert(nombre: 'Técnico 2'),
                TecnicosCompanion.insert(nombre: 'Técnico 3'),
              ],
            );
          });
        },
        beforeOpen: (_) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
      );
}

// Crea la conexión SQLite en el almacenamiento privado de la aplicación.
LazyDatabase _abrirConexion() {
  return LazyDatabase(() async {
    final directorio = await getApplicationDocumentsDirectory();
    final archivo = File(path.join(directorio.path, 'tu_solution.sqlite'));
    return NativeDatabase.createInBackground(archivo);
  });
}
