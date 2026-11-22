// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ClientesTable extends Clientes with TableInfo<$ClientesTable, Cliente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _telefonoMeta =
      const VerificationMeta('telefono');
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
      'telefono', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 30),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _fechaRegistroMeta =
      const VerificationMeta('fechaRegistro');
  @override
  late final GeneratedColumn<DateTime> fechaRegistro =
      GeneratedColumn<DateTime>('fecha_registro', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns => [id, nombre, telefono, fechaRegistro];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clientes';
  @override
  VerificationContext validateIntegrity(Insertable<Cliente> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(_telefonoMeta,
          telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta));
    } else if (isInserting) {
      context.missing(_telefonoMeta);
    }
    if (data.containsKey('fecha_registro')) {
      context.handle(
          _fechaRegistroMeta,
          fechaRegistro.isAcceptableOrUnknown(
              data['fecha_registro']!, _fechaRegistroMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cliente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cliente(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      telefono: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}telefono'])!,
      fechaRegistro: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_registro'])!,
    );
  }

  @override
  $ClientesTable createAlias(String alias) {
    return $ClientesTable(attachedDatabase, alias);
  }
}

class Cliente extends DataClass implements Insertable<Cliente> {
  final int id;
  final String nombre;
  final String telefono;
  final DateTime fechaRegistro;
  const Cliente(
      {required this.id,
      required this.nombre,
      required this.telefono,
      required this.fechaRegistro});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['telefono'] = Variable<String>(telefono);
    map['fecha_registro'] = Variable<DateTime>(fechaRegistro);
    return map;
  }

  ClientesCompanion toCompanion(bool nullToAbsent) {
    return ClientesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      telefono: Value(telefono),
      fechaRegistro: Value(fechaRegistro),
    );
  }

  factory Cliente.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cliente(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      telefono: serializer.fromJson<String>(json['telefono']),
      fechaRegistro: serializer.fromJson<DateTime>(json['fechaRegistro']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'telefono': serializer.toJson<String>(telefono),
      'fechaRegistro': serializer.toJson<DateTime>(fechaRegistro),
    };
  }

  Cliente copyWith(
          {int? id,
          String? nombre,
          String? telefono,
          DateTime? fechaRegistro}) =>
      Cliente(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        telefono: telefono ?? this.telefono,
        fechaRegistro: fechaRegistro ?? this.fechaRegistro,
      );
  Cliente copyWithCompanion(ClientesCompanion data) {
    return Cliente(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      fechaRegistro: data.fechaRegistro.present
          ? data.fechaRegistro.value
          : this.fechaRegistro,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cliente(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono, ')
          ..write('fechaRegistro: $fechaRegistro')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, telefono, fechaRegistro);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cliente &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.telefono == this.telefono &&
          other.fechaRegistro == this.fechaRegistro);
}

class ClientesCompanion extends UpdateCompanion<Cliente> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> telefono;
  final Value<DateTime> fechaRegistro;
  const ClientesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.telefono = const Value.absent(),
    this.fechaRegistro = const Value.absent(),
  });
  ClientesCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String telefono,
    this.fechaRegistro = const Value.absent(),
  })  : nombre = Value(nombre),
        telefono = Value(telefono);
  static Insertable<Cliente> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? telefono,
    Expression<DateTime>? fechaRegistro,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (telefono != null) 'telefono': telefono,
      if (fechaRegistro != null) 'fecha_registro': fechaRegistro,
    });
  }

  ClientesCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<String>? telefono,
      Value<DateTime>? fechaRegistro}) {
    return ClientesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
      fechaRegistro: fechaRegistro ?? this.fechaRegistro,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (fechaRegistro.present) {
      map['fecha_registro'] = Variable<DateTime>(fechaRegistro.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono, ')
          ..write('fechaRegistro: $fechaRegistro')
          ..write(')'))
        .toString();
  }
}

class $DispositivosTable extends Dispositivos
    with TableInfo<$DispositivosTable, Dispositivo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DispositivosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _clienteIdMeta =
      const VerificationMeta('clienteId');
  @override
  late final GeneratedColumn<int> clienteId = GeneratedColumn<int>(
      'cliente_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES clientes (id)'));
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
      'tipo', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 40),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _marcaMeta = const VerificationMeta('marca');
  @override
  late final GeneratedColumn<String> marca = GeneratedColumn<String>(
      'marca', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 60),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _modeloMeta = const VerificationMeta('modelo');
  @override
  late final GeneratedColumn<String> modelo = GeneratedColumn<String>(
      'modelo', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 80),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _numeroSerieMeta =
      const VerificationMeta('numeroSerie');
  @override
  late final GeneratedColumn<String> numeroSerie = GeneratedColumn<String>(
      'numero_serie', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, clienteId, tipo, marca, modelo, numeroSerie];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'dispositivos';
  @override
  VerificationContext validateIntegrity(Insertable<Dispositivo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cliente_id')) {
      context.handle(_clienteIdMeta,
          clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta));
    } else if (isInserting) {
      context.missing(_clienteIdMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
          _tipoMeta, tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta));
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('marca')) {
      context.handle(
          _marcaMeta, marca.isAcceptableOrUnknown(data['marca']!, _marcaMeta));
    } else if (isInserting) {
      context.missing(_marcaMeta);
    }
    if (data.containsKey('modelo')) {
      context.handle(_modeloMeta,
          modelo.isAcceptableOrUnknown(data['modelo']!, _modeloMeta));
    } else if (isInserting) {
      context.missing(_modeloMeta);
    }
    if (data.containsKey('numero_serie')) {
      context.handle(
          _numeroSerieMeta,
          numeroSerie.isAcceptableOrUnknown(
              data['numero_serie']!, _numeroSerieMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Dispositivo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Dispositivo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      clienteId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cliente_id'])!,
      tipo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tipo'])!,
      marca: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}marca'])!,
      modelo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}modelo'])!,
      numeroSerie: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}numero_serie']),
    );
  }

  @override
  $DispositivosTable createAlias(String alias) {
    return $DispositivosTable(attachedDatabase, alias);
  }
}

class Dispositivo extends DataClass implements Insertable<Dispositivo> {
  final int id;
  final int clienteId;
  final String tipo;
  final String marca;
  final String modelo;
  final String? numeroSerie;
  const Dispositivo(
      {required this.id,
      required this.clienteId,
      required this.tipo,
      required this.marca,
      required this.modelo,
      this.numeroSerie});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cliente_id'] = Variable<int>(clienteId);
    map['tipo'] = Variable<String>(tipo);
    map['marca'] = Variable<String>(marca);
    map['modelo'] = Variable<String>(modelo);
    if (!nullToAbsent || numeroSerie != null) {
      map['numero_serie'] = Variable<String>(numeroSerie);
    }
    return map;
  }

  DispositivosCompanion toCompanion(bool nullToAbsent) {
    return DispositivosCompanion(
      id: Value(id),
      clienteId: Value(clienteId),
      tipo: Value(tipo),
      marca: Value(marca),
      modelo: Value(modelo),
      numeroSerie: numeroSerie == null && nullToAbsent
          ? const Value.absent()
          : Value(numeroSerie),
    );
  }

  factory Dispositivo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Dispositivo(
      id: serializer.fromJson<int>(json['id']),
      clienteId: serializer.fromJson<int>(json['clienteId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      marca: serializer.fromJson<String>(json['marca']),
      modelo: serializer.fromJson<String>(json['modelo']),
      numeroSerie: serializer.fromJson<String?>(json['numeroSerie']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clienteId': serializer.toJson<int>(clienteId),
      'tipo': serializer.toJson<String>(tipo),
      'marca': serializer.toJson<String>(marca),
      'modelo': serializer.toJson<String>(modelo),
      'numeroSerie': serializer.toJson<String?>(numeroSerie),
    };
  }

  Dispositivo copyWith(
          {int? id,
          int? clienteId,
          String? tipo,
          String? marca,
          String? modelo,
          Value<String?> numeroSerie = const Value.absent()}) =>
      Dispositivo(
        id: id ?? this.id,
        clienteId: clienteId ?? this.clienteId,
        tipo: tipo ?? this.tipo,
        marca: marca ?? this.marca,
        modelo: modelo ?? this.modelo,
        numeroSerie: numeroSerie.present ? numeroSerie.value : this.numeroSerie,
      );
  Dispositivo copyWithCompanion(DispositivosCompanion data) {
    return Dispositivo(
      id: data.id.present ? data.id.value : this.id,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      marca: data.marca.present ? data.marca.value : this.marca,
      modelo: data.modelo.present ? data.modelo.value : this.modelo,
      numeroSerie:
          data.numeroSerie.present ? data.numeroSerie.value : this.numeroSerie,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Dispositivo(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('tipo: $tipo, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('numeroSerie: $numeroSerie')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, clienteId, tipo, marca, modelo, numeroSerie);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Dispositivo &&
          other.id == this.id &&
          other.clienteId == this.clienteId &&
          other.tipo == this.tipo &&
          other.marca == this.marca &&
          other.modelo == this.modelo &&
          other.numeroSerie == this.numeroSerie);
}

class DispositivosCompanion extends UpdateCompanion<Dispositivo> {
  final Value<int> id;
  final Value<int> clienteId;
  final Value<String> tipo;
  final Value<String> marca;
  final Value<String> modelo;
  final Value<String?> numeroSerie;
  const DispositivosCompanion({
    this.id = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.marca = const Value.absent(),
    this.modelo = const Value.absent(),
    this.numeroSerie = const Value.absent(),
  });
  DispositivosCompanion.insert({
    this.id = const Value.absent(),
    required int clienteId,
    required String tipo,
    required String marca,
    required String modelo,
    this.numeroSerie = const Value.absent(),
  })  : clienteId = Value(clienteId),
        tipo = Value(tipo),
        marca = Value(marca),
        modelo = Value(modelo);
  static Insertable<Dispositivo> custom({
    Expression<int>? id,
    Expression<int>? clienteId,
    Expression<String>? tipo,
    Expression<String>? marca,
    Expression<String>? modelo,
    Expression<String>? numeroSerie,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clienteId != null) 'cliente_id': clienteId,
      if (tipo != null) 'tipo': tipo,
      if (marca != null) 'marca': marca,
      if (modelo != null) 'modelo': modelo,
      if (numeroSerie != null) 'numero_serie': numeroSerie,
    });
  }

  DispositivosCompanion copyWith(
      {Value<int>? id,
      Value<int>? clienteId,
      Value<String>? tipo,
      Value<String>? marca,
      Value<String>? modelo,
      Value<String?>? numeroSerie}) {
    return DispositivosCompanion(
      id: id ?? this.id,
      clienteId: clienteId ?? this.clienteId,
      tipo: tipo ?? this.tipo,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      numeroSerie: numeroSerie ?? this.numeroSerie,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<int>(clienteId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (marca.present) {
      map['marca'] = Variable<String>(marca.value);
    }
    if (modelo.present) {
      map['modelo'] = Variable<String>(modelo.value);
    }
    if (numeroSerie.present) {
      map['numero_serie'] = Variable<String>(numeroSerie.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DispositivosCompanion(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('tipo: $tipo, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('numeroSerie: $numeroSerie')
          ..write(')'))
        .toString();
  }
}

class $TecnicosTable extends Tecnicos with TableInfo<$TecnicosTable, Tecnico> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TecnicosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  @override
  List<GeneratedColumn> get $columns => [id, nombre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tecnicos';
  @override
  VerificationContext validateIntegrity(Insertable<Tecnico> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tecnico map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tecnico(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
    );
  }

  @override
  $TecnicosTable createAlias(String alias) {
    return $TecnicosTable(attachedDatabase, alias);
  }
}

class Tecnico extends DataClass implements Insertable<Tecnico> {
  final int id;
  final String nombre;
  const Tecnico({required this.id, required this.nombre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    return map;
  }

  TecnicosCompanion toCompanion(bool nullToAbsent) {
    return TecnicosCompanion(
      id: Value(id),
      nombre: Value(nombre),
    );
  }

  factory Tecnico.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tecnico(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
    };
  }

  Tecnico copyWith({int? id, String? nombre}) => Tecnico(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
      );
  Tecnico copyWithCompanion(TecnicosCompanion data) {
    return Tecnico(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tecnico(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tecnico && other.id == this.id && other.nombre == this.nombre);
}

class TecnicosCompanion extends UpdateCompanion<Tecnico> {
  final Value<int> id;
  final Value<String> nombre;
  const TecnicosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
  });
  TecnicosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
  }) : nombre = Value(nombre);
  static Insertable<Tecnico> custom({
    Expression<int>? id,
    Expression<String>? nombre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
    });
  }

  TecnicosCompanion copyWith({Value<int>? id, Value<String>? nombre}) {
    return TecnicosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TecnicosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }
}

class $OrdenesTable extends Ordenes with TableInfo<$OrdenesTable, Orden> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdenesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _dispositivoIdMeta =
      const VerificationMeta('dispositivoId');
  @override
  late final GeneratedColumn<int> dispositivoId = GeneratedColumn<int>(
      'dispositivo_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES dispositivos (id)'));
  static const VerificationMeta _tecnicoIdMeta =
      const VerificationMeta('tecnicoId');
  @override
  late final GeneratedColumn<int> tecnicoId = GeneratedColumn<int>(
      'tecnico_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES tecnicos (id)'));
  static const VerificationMeta _fallaReportadaMeta =
      const VerificationMeta('fallaReportada');
  @override
  late final GeneratedColumn<String> fallaReportada = GeneratedColumn<String>(
      'falla_reportada', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1, maxTextLength: 1000),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
      'estado', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('Recibida'));
  static const VerificationMeta _fechaRecepcionMeta =
      const VerificationMeta('fechaRecepcion');
  @override
  late final GeneratedColumn<DateTime> fechaRecepcion =
      GeneratedColumn<DateTime>('fecha_recepcion', aliasedName, false,
          type: DriftSqlType.dateTime,
          requiredDuringInsert: false,
          defaultValue: currentDateAndTime);
  static const VerificationMeta _fechaEntregaMeta =
      const VerificationMeta('fechaEntrega');
  @override
  late final GeneratedColumn<DateTime> fechaEntrega = GeneratedColumn<DateTime>(
      'fecha_entrega', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        dispositivoId,
        tecnicoId,
        fallaReportada,
        estado,
        fechaRecepcion,
        fechaEntrega
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ordenes';
  @override
  VerificationContext validateIntegrity(Insertable<Orden> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('dispositivo_id')) {
      context.handle(
          _dispositivoIdMeta,
          dispositivoId.isAcceptableOrUnknown(
              data['dispositivo_id']!, _dispositivoIdMeta));
    } else if (isInserting) {
      context.missing(_dispositivoIdMeta);
    }
    if (data.containsKey('tecnico_id')) {
      context.handle(_tecnicoIdMeta,
          tecnicoId.isAcceptableOrUnknown(data['tecnico_id']!, _tecnicoIdMeta));
    } else if (isInserting) {
      context.missing(_tecnicoIdMeta);
    }
    if (data.containsKey('falla_reportada')) {
      context.handle(
          _fallaReportadaMeta,
          fallaReportada.isAcceptableOrUnknown(
              data['falla_reportada']!, _fallaReportadaMeta));
    } else if (isInserting) {
      context.missing(_fallaReportadaMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(_estadoMeta,
          estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta));
    }
    if (data.containsKey('fecha_recepcion')) {
      context.handle(
          _fechaRecepcionMeta,
          fechaRecepcion.isAcceptableOrUnknown(
              data['fecha_recepcion']!, _fechaRecepcionMeta));
    }
    if (data.containsKey('fecha_entrega')) {
      context.handle(
          _fechaEntregaMeta,
          fechaEntrega.isAcceptableOrUnknown(
              data['fecha_entrega']!, _fechaEntregaMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Orden map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Orden(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      dispositivoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}dispositivo_id'])!,
      tecnicoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}tecnico_id'])!,
      fallaReportada: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}falla_reportada'])!,
      estado: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}estado'])!,
      fechaRecepcion: attachedDatabase.typeMapping.read(
          DriftSqlType.dateTime, data['${effectivePrefix}fecha_recepcion'])!,
      fechaEntrega: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}fecha_entrega']),
    );
  }

  @override
  $OrdenesTable createAlias(String alias) {
    return $OrdenesTable(attachedDatabase, alias);
  }
}

class Orden extends DataClass implements Insertable<Orden> {
  final int id;
  final int dispositivoId;
  final int tecnicoId;
  final String fallaReportada;
  final String estado;
  final DateTime fechaRecepcion;
  final DateTime? fechaEntrega;
  const Orden(
      {required this.id,
      required this.dispositivoId,
      required this.tecnicoId,
      required this.fallaReportada,
      required this.estado,
      required this.fechaRecepcion,
      this.fechaEntrega});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['dispositivo_id'] = Variable<int>(dispositivoId);
    map['tecnico_id'] = Variable<int>(tecnicoId);
    map['falla_reportada'] = Variable<String>(fallaReportada);
    map['estado'] = Variable<String>(estado);
    map['fecha_recepcion'] = Variable<DateTime>(fechaRecepcion);
    if (!nullToAbsent || fechaEntrega != null) {
      map['fecha_entrega'] = Variable<DateTime>(fechaEntrega);
    }
    return map;
  }

  OrdenesCompanion toCompanion(bool nullToAbsent) {
    return OrdenesCompanion(
      id: Value(id),
      dispositivoId: Value(dispositivoId),
      tecnicoId: Value(tecnicoId),
      fallaReportada: Value(fallaReportada),
      estado: Value(estado),
      fechaRecepcion: Value(fechaRecepcion),
      fechaEntrega: fechaEntrega == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaEntrega),
    );
  }

  factory Orden.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Orden(
      id: serializer.fromJson<int>(json['id']),
      dispositivoId: serializer.fromJson<int>(json['dispositivoId']),
      tecnicoId: serializer.fromJson<int>(json['tecnicoId']),
      fallaReportada: serializer.fromJson<String>(json['fallaReportada']),
      estado: serializer.fromJson<String>(json['estado']),
      fechaRecepcion: serializer.fromJson<DateTime>(json['fechaRecepcion']),
      fechaEntrega: serializer.fromJson<DateTime?>(json['fechaEntrega']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'dispositivoId': serializer.toJson<int>(dispositivoId),
      'tecnicoId': serializer.toJson<int>(tecnicoId),
      'fallaReportada': serializer.toJson<String>(fallaReportada),
      'estado': serializer.toJson<String>(estado),
      'fechaRecepcion': serializer.toJson<DateTime>(fechaRecepcion),
      'fechaEntrega': serializer.toJson<DateTime?>(fechaEntrega),
    };
  }

  Orden copyWith(
          {int? id,
          int? dispositivoId,
          int? tecnicoId,
          String? fallaReportada,
          String? estado,
          DateTime? fechaRecepcion,
          Value<DateTime?> fechaEntrega = const Value.absent()}) =>
      Orden(
        id: id ?? this.id,
        dispositivoId: dispositivoId ?? this.dispositivoId,
        tecnicoId: tecnicoId ?? this.tecnicoId,
        fallaReportada: fallaReportada ?? this.fallaReportada,
        estado: estado ?? this.estado,
        fechaRecepcion: fechaRecepcion ?? this.fechaRecepcion,
        fechaEntrega:
            fechaEntrega.present ? fechaEntrega.value : this.fechaEntrega,
      );
  Orden copyWithCompanion(OrdenesCompanion data) {
    return Orden(
      id: data.id.present ? data.id.value : this.id,
      dispositivoId: data.dispositivoId.present
          ? data.dispositivoId.value
          : this.dispositivoId,
      tecnicoId: data.tecnicoId.present ? data.tecnicoId.value : this.tecnicoId,
      fallaReportada: data.fallaReportada.present
          ? data.fallaReportada.value
          : this.fallaReportada,
      estado: data.estado.present ? data.estado.value : this.estado,
      fechaRecepcion: data.fechaRecepcion.present
          ? data.fechaRecepcion.value
          : this.fechaRecepcion,
      fechaEntrega: data.fechaEntrega.present
          ? data.fechaEntrega.value
          : this.fechaEntrega,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Orden(')
          ..write('id: $id, ')
          ..write('dispositivoId: $dispositivoId, ')
          ..write('tecnicoId: $tecnicoId, ')
          ..write('fallaReportada: $fallaReportada, ')
          ..write('estado: $estado, ')
          ..write('fechaRecepcion: $fechaRecepcion, ')
          ..write('fechaEntrega: $fechaEntrega')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, dispositivoId, tecnicoId, fallaReportada,
      estado, fechaRecepcion, fechaEntrega);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Orden &&
          other.id == this.id &&
          other.dispositivoId == this.dispositivoId &&
          other.tecnicoId == this.tecnicoId &&
          other.fallaReportada == this.fallaReportada &&
          other.estado == this.estado &&
          other.fechaRecepcion == this.fechaRecepcion &&
          other.fechaEntrega == this.fechaEntrega);
}

class OrdenesCompanion extends UpdateCompanion<Orden> {
  final Value<int> id;
  final Value<int> dispositivoId;
  final Value<int> tecnicoId;
  final Value<String> fallaReportada;
  final Value<String> estado;
  final Value<DateTime> fechaRecepcion;
  final Value<DateTime?> fechaEntrega;
  const OrdenesCompanion({
    this.id = const Value.absent(),
    this.dispositivoId = const Value.absent(),
    this.tecnicoId = const Value.absent(),
    this.fallaReportada = const Value.absent(),
    this.estado = const Value.absent(),
    this.fechaRecepcion = const Value.absent(),
    this.fechaEntrega = const Value.absent(),
  });
  OrdenesCompanion.insert({
    this.id = const Value.absent(),
    required int dispositivoId,
    required int tecnicoId,
    required String fallaReportada,
    this.estado = const Value.absent(),
    this.fechaRecepcion = const Value.absent(),
    this.fechaEntrega = const Value.absent(),
  })  : dispositivoId = Value(dispositivoId),
        tecnicoId = Value(tecnicoId),
        fallaReportada = Value(fallaReportada);
  static Insertable<Orden> custom({
    Expression<int>? id,
    Expression<int>? dispositivoId,
    Expression<int>? tecnicoId,
    Expression<String>? fallaReportada,
    Expression<String>? estado,
    Expression<DateTime>? fechaRecepcion,
    Expression<DateTime>? fechaEntrega,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dispositivoId != null) 'dispositivo_id': dispositivoId,
      if (tecnicoId != null) 'tecnico_id': tecnicoId,
      if (fallaReportada != null) 'falla_reportada': fallaReportada,
      if (estado != null) 'estado': estado,
      if (fechaRecepcion != null) 'fecha_recepcion': fechaRecepcion,
      if (fechaEntrega != null) 'fecha_entrega': fechaEntrega,
    });
  }

  OrdenesCompanion copyWith(
      {Value<int>? id,
      Value<int>? dispositivoId,
      Value<int>? tecnicoId,
      Value<String>? fallaReportada,
      Value<String>? estado,
      Value<DateTime>? fechaRecepcion,
      Value<DateTime?>? fechaEntrega}) {
    return OrdenesCompanion(
      id: id ?? this.id,
      dispositivoId: dispositivoId ?? this.dispositivoId,
      tecnicoId: tecnicoId ?? this.tecnicoId,
      fallaReportada: fallaReportada ?? this.fallaReportada,
      estado: estado ?? this.estado,
      fechaRecepcion: fechaRecepcion ?? this.fechaRecepcion,
      fechaEntrega: fechaEntrega ?? this.fechaEntrega,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (dispositivoId.present) {
      map['dispositivo_id'] = Variable<int>(dispositivoId.value);
    }
    if (tecnicoId.present) {
      map['tecnico_id'] = Variable<int>(tecnicoId.value);
    }
    if (fallaReportada.present) {
      map['falla_reportada'] = Variable<String>(fallaReportada.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (fechaRecepcion.present) {
      map['fecha_recepcion'] = Variable<DateTime>(fechaRecepcion.value);
    }
    if (fechaEntrega.present) {
      map['fecha_entrega'] = Variable<DateTime>(fechaEntrega.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdenesCompanion(')
          ..write('id: $id, ')
          ..write('dispositivoId: $dispositivoId, ')
          ..write('tecnicoId: $tecnicoId, ')
          ..write('fallaReportada: $fallaReportada, ')
          ..write('estado: $estado, ')
          ..write('fechaRecepcion: $fechaRecepcion, ')
          ..write('fechaEntrega: $fechaEntrega')
          ..write(')'))
        .toString();
  }
}

class $TrabajosTable extends Trabajos with TableInfo<$TrabajosTable, Trabajo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrabajosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ordenIdMeta =
      const VerificationMeta('ordenId');
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
      'orden_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES ordenes (id)'));
  static const VerificationMeta _descripcionMeta =
      const VerificationMeta('descripcion');
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
      'descripcion', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 500),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _costeCentavosMeta =
      const VerificationMeta('costeCentavos');
  @override
  late final GeneratedColumn<int> costeCentavos = GeneratedColumn<int>(
      'coste_centavos', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ordenId, descripcion, costeCentavos];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trabajos';
  @override
  VerificationContext validateIntegrity(Insertable<Trabajo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('orden_id')) {
      context.handle(_ordenIdMeta,
          ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta));
    } else if (isInserting) {
      context.missing(_ordenIdMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
          _descripcionMeta,
          descripcion.isAcceptableOrUnknown(
              data['descripcion']!, _descripcionMeta));
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('coste_centavos')) {
      context.handle(
          _costeCentavosMeta,
          costeCentavos.isAcceptableOrUnknown(
              data['coste_centavos']!, _costeCentavosMeta));
    } else if (isInserting) {
      context.missing(_costeCentavosMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trabajo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trabajo(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ordenId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}orden_id'])!,
      descripcion: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}descripcion'])!,
      costeCentavos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}coste_centavos'])!,
    );
  }

  @override
  $TrabajosTable createAlias(String alias) {
    return $TrabajosTable(attachedDatabase, alias);
  }
}

class Trabajo extends DataClass implements Insertable<Trabajo> {
  final int id;
  final int ordenId;
  final String descripcion;
  final int costeCentavos;
  const Trabajo(
      {required this.id,
      required this.ordenId,
      required this.descripcion,
      required this.costeCentavos});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['orden_id'] = Variable<int>(ordenId);
    map['descripcion'] = Variable<String>(descripcion);
    map['coste_centavos'] = Variable<int>(costeCentavos);
    return map;
  }

  TrabajosCompanion toCompanion(bool nullToAbsent) {
    return TrabajosCompanion(
      id: Value(id),
      ordenId: Value(ordenId),
      descripcion: Value(descripcion),
      costeCentavos: Value(costeCentavos),
    );
  }

  factory Trabajo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trabajo(
      id: serializer.fromJson<int>(json['id']),
      ordenId: serializer.fromJson<int>(json['ordenId']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      costeCentavos: serializer.fromJson<int>(json['costeCentavos']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordenId': serializer.toJson<int>(ordenId),
      'descripcion': serializer.toJson<String>(descripcion),
      'costeCentavos': serializer.toJson<int>(costeCentavos),
    };
  }

  Trabajo copyWith(
          {int? id, int? ordenId, String? descripcion, int? costeCentavos}) =>
      Trabajo(
        id: id ?? this.id,
        ordenId: ordenId ?? this.ordenId,
        descripcion: descripcion ?? this.descripcion,
        costeCentavos: costeCentavos ?? this.costeCentavos,
      );
  Trabajo copyWithCompanion(TrabajosCompanion data) {
    return Trabajo(
      id: data.id.present ? data.id.value : this.id,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      descripcion:
          data.descripcion.present ? data.descripcion.value : this.descripcion,
      costeCentavos: data.costeCentavos.present
          ? data.costeCentavos.value
          : this.costeCentavos,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trabajo(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('descripcion: $descripcion, ')
          ..write('costeCentavos: $costeCentavos')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ordenId, descripcion, costeCentavos);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trabajo &&
          other.id == this.id &&
          other.ordenId == this.ordenId &&
          other.descripcion == this.descripcion &&
          other.costeCentavos == this.costeCentavos);
}

class TrabajosCompanion extends UpdateCompanion<Trabajo> {
  final Value<int> id;
  final Value<int> ordenId;
  final Value<String> descripcion;
  final Value<int> costeCentavos;
  const TrabajosCompanion({
    this.id = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.costeCentavos = const Value.absent(),
  });
  TrabajosCompanion.insert({
    this.id = const Value.absent(),
    required int ordenId,
    required String descripcion,
    required int costeCentavos,
  })  : ordenId = Value(ordenId),
        descripcion = Value(descripcion),
        costeCentavos = Value(costeCentavos);
  static Insertable<Trabajo> custom({
    Expression<int>? id,
    Expression<int>? ordenId,
    Expression<String>? descripcion,
    Expression<int>? costeCentavos,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordenId != null) 'orden_id': ordenId,
      if (descripcion != null) 'descripcion': descripcion,
      if (costeCentavos != null) 'coste_centavos': costeCentavos,
    });
  }

  TrabajosCompanion copyWith(
      {Value<int>? id,
      Value<int>? ordenId,
      Value<String>? descripcion,
      Value<int>? costeCentavos}) {
    return TrabajosCompanion(
      id: id ?? this.id,
      ordenId: ordenId ?? this.ordenId,
      descripcion: descripcion ?? this.descripcion,
      costeCentavos: costeCentavos ?? this.costeCentavos,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (costeCentavos.present) {
      map['coste_centavos'] = Variable<int>(costeCentavos.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrabajosCompanion(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('descripcion: $descripcion, ')
          ..write('costeCentavos: $costeCentavos')
          ..write(')'))
        .toString();
  }
}

class $RepuestosTable extends Repuestos
    with TableInfo<$RepuestosTable, Repuesto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepuestosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
      'nombre', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
      'codigo', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _precioCentavosMeta =
      const VerificationMeta('precioCentavos');
  @override
  late final GeneratedColumn<int> precioCentavos = GeneratedColumn<int>(
      'precio_centavos', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _existenciasMeta =
      const VerificationMeta('existencias');
  @override
  late final GeneratedColumn<int> existencias = GeneratedColumn<int>(
      'existencias', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _nivelMinimoMeta =
      const VerificationMeta('nivelMinimo');
  @override
  late final GeneratedColumn<int> nivelMinimo = GeneratedColumn<int>(
      'nivel_minimo', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(3));
  @override
  List<GeneratedColumn> get $columns =>
      [id, nombre, codigo, precioCentavos, existencias, nivelMinimo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repuestos';
  @override
  VerificationContext validateIntegrity(Insertable<Repuesto> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(_nombreMeta,
          nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta));
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('precio_centavos')) {
      context.handle(
          _precioCentavosMeta,
          precioCentavos.isAcceptableOrUnknown(
              data['precio_centavos']!, _precioCentavosMeta));
    } else if (isInserting) {
      context.missing(_precioCentavosMeta);
    }
    if (data.containsKey('existencias')) {
      context.handle(
          _existenciasMeta,
          existencias.isAcceptableOrUnknown(
              data['existencias']!, _existenciasMeta));
    } else if (isInserting) {
      context.missing(_existenciasMeta);
    }
    if (data.containsKey('nivel_minimo')) {
      context.handle(
          _nivelMinimoMeta,
          nivelMinimo.isAcceptableOrUnknown(
              data['nivel_minimo']!, _nivelMinimoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Repuesto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Repuesto(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      nombre: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}nombre'])!,
      codigo: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}codigo'])!,
      precioCentavos: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}precio_centavos'])!,
      existencias: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}existencias'])!,
      nivelMinimo: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}nivel_minimo'])!,
    );
  }

  @override
  $RepuestosTable createAlias(String alias) {
    return $RepuestosTable(attachedDatabase, alias);
  }
}

class Repuesto extends DataClass implements Insertable<Repuesto> {
  final int id;
  final String nombre;
  final String codigo;
  final int precioCentavos;
  final int existencias;
  final int nivelMinimo;
  const Repuesto(
      {required this.id,
      required this.nombre,
      required this.codigo,
      required this.precioCentavos,
      required this.existencias,
      required this.nivelMinimo});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['codigo'] = Variable<String>(codigo);
    map['precio_centavos'] = Variable<int>(precioCentavos);
    map['existencias'] = Variable<int>(existencias);
    map['nivel_minimo'] = Variable<int>(nivelMinimo);
    return map;
  }

  RepuestosCompanion toCompanion(bool nullToAbsent) {
    return RepuestosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      codigo: Value(codigo),
      precioCentavos: Value(precioCentavos),
      existencias: Value(existencias),
      nivelMinimo: Value(nivelMinimo),
    );
  }

  factory Repuesto.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Repuesto(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      codigo: serializer.fromJson<String>(json['codigo']),
      precioCentavos: serializer.fromJson<int>(json['precioCentavos']),
      existencias: serializer.fromJson<int>(json['existencias']),
      nivelMinimo: serializer.fromJson<int>(json['nivelMinimo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'codigo': serializer.toJson<String>(codigo),
      'precioCentavos': serializer.toJson<int>(precioCentavos),
      'existencias': serializer.toJson<int>(existencias),
      'nivelMinimo': serializer.toJson<int>(nivelMinimo),
    };
  }

  Repuesto copyWith(
          {int? id,
          String? nombre,
          String? codigo,
          int? precioCentavos,
          int? existencias,
          int? nivelMinimo}) =>
      Repuesto(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        codigo: codigo ?? this.codigo,
        precioCentavos: precioCentavos ?? this.precioCentavos,
        existencias: existencias ?? this.existencias,
        nivelMinimo: nivelMinimo ?? this.nivelMinimo,
      );
  Repuesto copyWithCompanion(RepuestosCompanion data) {
    return Repuesto(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      precioCentavos: data.precioCentavos.present
          ? data.precioCentavos.value
          : this.precioCentavos,
      existencias:
          data.existencias.present ? data.existencias.value : this.existencias,
      nivelMinimo:
          data.nivelMinimo.present ? data.nivelMinimo.value : this.nivelMinimo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Repuesto(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('codigo: $codigo, ')
          ..write('precioCentavos: $precioCentavos, ')
          ..write('existencias: $existencias, ')
          ..write('nivelMinimo: $nivelMinimo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, nombre, codigo, precioCentavos, existencias, nivelMinimo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Repuesto &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.codigo == this.codigo &&
          other.precioCentavos == this.precioCentavos &&
          other.existencias == this.existencias &&
          other.nivelMinimo == this.nivelMinimo);
}

class RepuestosCompanion extends UpdateCompanion<Repuesto> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> codigo;
  final Value<int> precioCentavos;
  final Value<int> existencias;
  final Value<int> nivelMinimo;
  const RepuestosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.codigo = const Value.absent(),
    this.precioCentavos = const Value.absent(),
    this.existencias = const Value.absent(),
    this.nivelMinimo = const Value.absent(),
  });
  RepuestosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String codigo,
    required int precioCentavos,
    required int existencias,
    this.nivelMinimo = const Value.absent(),
  })  : nombre = Value(nombre),
        codigo = Value(codigo),
        precioCentavos = Value(precioCentavos),
        existencias = Value(existencias);
  static Insertable<Repuesto> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? codigo,
    Expression<int>? precioCentavos,
    Expression<int>? existencias,
    Expression<int>? nivelMinimo,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (codigo != null) 'codigo': codigo,
      if (precioCentavos != null) 'precio_centavos': precioCentavos,
      if (existencias != null) 'existencias': existencias,
      if (nivelMinimo != null) 'nivel_minimo': nivelMinimo,
    });
  }

  RepuestosCompanion copyWith(
      {Value<int>? id,
      Value<String>? nombre,
      Value<String>? codigo,
      Value<int>? precioCentavos,
      Value<int>? existencias,
      Value<int>? nivelMinimo}) {
    return RepuestosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      codigo: codigo ?? this.codigo,
      precioCentavos: precioCentavos ?? this.precioCentavos,
      existencias: existencias ?? this.existencias,
      nivelMinimo: nivelMinimo ?? this.nivelMinimo,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (precioCentavos.present) {
      map['precio_centavos'] = Variable<int>(precioCentavos.value);
    }
    if (existencias.present) {
      map['existencias'] = Variable<int>(existencias.value);
    }
    if (nivelMinimo.present) {
      map['nivel_minimo'] = Variable<int>(nivelMinimo.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepuestosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('codigo: $codigo, ')
          ..write('precioCentavos: $precioCentavos, ')
          ..write('existencias: $existencias, ')
          ..write('nivelMinimo: $nivelMinimo')
          ..write(')'))
        .toString();
  }
}

class $RepuestosOrdenTable extends RepuestosOrden
    with TableInfo<$RepuestosOrdenTable, RepuestosOrdenData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepuestosOrdenTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _ordenIdMeta =
      const VerificationMeta('ordenId');
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
      'orden_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES ordenes (id)'));
  static const VerificationMeta _repuestoIdMeta =
      const VerificationMeta('repuestoId');
  @override
  late final GeneratedColumn<int> repuestoId = GeneratedColumn<int>(
      'repuesto_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES repuestos (id)'));
  static const VerificationMeta _cantidadMeta =
      const VerificationMeta('cantidad');
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
      'cantidad', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _precioUnitarioCentavosMeta =
      const VerificationMeta('precioUnitarioCentavos');
  @override
  late final GeneratedColumn<int> precioUnitarioCentavos = GeneratedColumn<int>(
      'precio_unitario_centavos', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, ordenId, repuestoId, cantidad, precioUnitarioCentavos];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repuestos_orden';
  @override
  VerificationContext validateIntegrity(Insertable<RepuestosOrdenData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('orden_id')) {
      context.handle(_ordenIdMeta,
          ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta));
    } else if (isInserting) {
      context.missing(_ordenIdMeta);
    }
    if (data.containsKey('repuesto_id')) {
      context.handle(
          _repuestoIdMeta,
          repuestoId.isAcceptableOrUnknown(
              data['repuesto_id']!, _repuestoIdMeta));
    } else if (isInserting) {
      context.missing(_repuestoIdMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(_cantidadMeta,
          cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta));
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('precio_unitario_centavos')) {
      context.handle(
          _precioUnitarioCentavosMeta,
          precioUnitarioCentavos.isAcceptableOrUnknown(
              data['precio_unitario_centavos']!, _precioUnitarioCentavosMeta));
    } else if (isInserting) {
      context.missing(_precioUnitarioCentavosMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {ordenId, repuestoId},
      ];
  @override
  RepuestosOrdenData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepuestosOrdenData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      ordenId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}orden_id'])!,
      repuestoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}repuesto_id'])!,
      cantidad: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}cantidad'])!,
      precioUnitarioCentavos: attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}precio_unitario_centavos'])!,
    );
  }

  @override
  $RepuestosOrdenTable createAlias(String alias) {
    return $RepuestosOrdenTable(attachedDatabase, alias);
  }
}

class RepuestosOrdenData extends DataClass
    implements Insertable<RepuestosOrdenData> {
  final int id;
  final int ordenId;
  final int repuestoId;
  final int cantidad;
  final int precioUnitarioCentavos;
  const RepuestosOrdenData(
      {required this.id,
      required this.ordenId,
      required this.repuestoId,
      required this.cantidad,
      required this.precioUnitarioCentavos});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['orden_id'] = Variable<int>(ordenId);
    map['repuesto_id'] = Variable<int>(repuestoId);
    map['cantidad'] = Variable<int>(cantidad);
    map['precio_unitario_centavos'] = Variable<int>(precioUnitarioCentavos);
    return map;
  }

  RepuestosOrdenCompanion toCompanion(bool nullToAbsent) {
    return RepuestosOrdenCompanion(
      id: Value(id),
      ordenId: Value(ordenId),
      repuestoId: Value(repuestoId),
      cantidad: Value(cantidad),
      precioUnitarioCentavos: Value(precioUnitarioCentavos),
    );
  }

  factory RepuestosOrdenData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepuestosOrdenData(
      id: serializer.fromJson<int>(json['id']),
      ordenId: serializer.fromJson<int>(json['ordenId']),
      repuestoId: serializer.fromJson<int>(json['repuestoId']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
      precioUnitarioCentavos:
          serializer.fromJson<int>(json['precioUnitarioCentavos']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordenId': serializer.toJson<int>(ordenId),
      'repuestoId': serializer.toJson<int>(repuestoId),
      'cantidad': serializer.toJson<int>(cantidad),
      'precioUnitarioCentavos': serializer.toJson<int>(precioUnitarioCentavos),
    };
  }

  RepuestosOrdenData copyWith(
          {int? id,
          int? ordenId,
          int? repuestoId,
          int? cantidad,
          int? precioUnitarioCentavos}) =>
      RepuestosOrdenData(
        id: id ?? this.id,
        ordenId: ordenId ?? this.ordenId,
        repuestoId: repuestoId ?? this.repuestoId,
        cantidad: cantidad ?? this.cantidad,
        precioUnitarioCentavos:
            precioUnitarioCentavos ?? this.precioUnitarioCentavos,
      );
  RepuestosOrdenData copyWithCompanion(RepuestosOrdenCompanion data) {
    return RepuestosOrdenData(
      id: data.id.present ? data.id.value : this.id,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      repuestoId:
          data.repuestoId.present ? data.repuestoId.value : this.repuestoId,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      precioUnitarioCentavos: data.precioUnitarioCentavos.present
          ? data.precioUnitarioCentavos.value
          : this.precioUnitarioCentavos,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepuestosOrdenData(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('repuestoId: $repuestoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitarioCentavos: $precioUnitarioCentavos')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ordenId, repuestoId, cantidad, precioUnitarioCentavos);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepuestosOrdenData &&
          other.id == this.id &&
          other.ordenId == this.ordenId &&
          other.repuestoId == this.repuestoId &&
          other.cantidad == this.cantidad &&
          other.precioUnitarioCentavos == this.precioUnitarioCentavos);
}

class RepuestosOrdenCompanion extends UpdateCompanion<RepuestosOrdenData> {
  final Value<int> id;
  final Value<int> ordenId;
  final Value<int> repuestoId;
  final Value<int> cantidad;
  final Value<int> precioUnitarioCentavos;
  const RepuestosOrdenCompanion({
    this.id = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.repuestoId = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.precioUnitarioCentavos = const Value.absent(),
  });
  RepuestosOrdenCompanion.insert({
    this.id = const Value.absent(),
    required int ordenId,
    required int repuestoId,
    required int cantidad,
    required int precioUnitarioCentavos,
  })  : ordenId = Value(ordenId),
        repuestoId = Value(repuestoId),
        cantidad = Value(cantidad),
        precioUnitarioCentavos = Value(precioUnitarioCentavos);
  static Insertable<RepuestosOrdenData> custom({
    Expression<int>? id,
    Expression<int>? ordenId,
    Expression<int>? repuestoId,
    Expression<int>? cantidad,
    Expression<int>? precioUnitarioCentavos,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordenId != null) 'orden_id': ordenId,
      if (repuestoId != null) 'repuesto_id': repuestoId,
      if (cantidad != null) 'cantidad': cantidad,
      if (precioUnitarioCentavos != null)
        'precio_unitario_centavos': precioUnitarioCentavos,
    });
  }

  RepuestosOrdenCompanion copyWith(
      {Value<int>? id,
      Value<int>? ordenId,
      Value<int>? repuestoId,
      Value<int>? cantidad,
      Value<int>? precioUnitarioCentavos}) {
    return RepuestosOrdenCompanion(
      id: id ?? this.id,
      ordenId: ordenId ?? this.ordenId,
      repuestoId: repuestoId ?? this.repuestoId,
      cantidad: cantidad ?? this.cantidad,
      precioUnitarioCentavos:
          precioUnitarioCentavos ?? this.precioUnitarioCentavos,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (repuestoId.present) {
      map['repuesto_id'] = Variable<int>(repuestoId.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (precioUnitarioCentavos.present) {
      map['precio_unitario_centavos'] =
          Variable<int>(precioUnitarioCentavos.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepuestosOrdenCompanion(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('repuestoId: $repuestoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitarioCentavos: $precioUnitarioCentavos')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientesTable clientes = $ClientesTable(this);
  late final $DispositivosTable dispositivos = $DispositivosTable(this);
  late final $TecnicosTable tecnicos = $TecnicosTable(this);
  late final $OrdenesTable ordenes = $OrdenesTable(this);
  late final $TrabajosTable trabajos = $TrabajosTable(this);
  late final $RepuestosTable repuestos = $RepuestosTable(this);
  late final $RepuestosOrdenTable repuestosOrden = $RepuestosOrdenTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        clientes,
        dispositivos,
        tecnicos,
        ordenes,
        trabajos,
        repuestos,
        repuestosOrden
      ];
}

typedef $$ClientesTableCreateCompanionBuilder = ClientesCompanion Function({
  Value<int> id,
  required String nombre,
  required String telefono,
  Value<DateTime> fechaRegistro,
});
typedef $$ClientesTableUpdateCompanionBuilder = ClientesCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String> telefono,
  Value<DateTime> fechaRegistro,
});

final class $$ClientesTableReferences
    extends BaseReferences<_$AppDatabase, $ClientesTable, Cliente> {
  $$ClientesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$DispositivosTable, List<Dispositivo>>
      _dispositivosRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.dispositivos,
              aliasName: 'clientes__id__dispositivos__cliente_id');

  $$DispositivosTableProcessedTableManager get dispositivosRefs {
    final manager = $$DispositivosTableTableManager($_db, $_db.dispositivos)
        .filter((f) => f.clienteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_dispositivosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ClientesTableFilterComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaRegistro => $composableBuilder(
      column: $table.fechaRegistro, builder: (column) => ColumnFilters(column));

  Expression<bool> dispositivosRefs(
      Expression<bool> Function($$DispositivosTableFilterComposer f) f) {
    final $$DispositivosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dispositivos,
        getReferencedColumn: (t) => t.clienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DispositivosTableFilterComposer(
              $db: $db,
              $table: $db.dispositivos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClientesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get telefono => $composableBuilder(
      column: $table.telefono, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaRegistro => $composableBuilder(
      column: $table.fechaRegistro,
      builder: (column) => ColumnOrderings(column));
}

class $$ClientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaRegistro => $composableBuilder(
      column: $table.fechaRegistro, builder: (column) => column);

  Expression<T> dispositivosRefs<T extends Object>(
      Expression<T> Function($$DispositivosTableAnnotationComposer a) f) {
    final $$DispositivosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.dispositivos,
        getReferencedColumn: (t) => t.clienteId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DispositivosTableAnnotationComposer(
              $db: $db,
              $table: $db.dispositivos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ClientesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ClientesTable,
    Cliente,
    $$ClientesTableFilterComposer,
    $$ClientesTableOrderingComposer,
    $$ClientesTableAnnotationComposer,
    $$ClientesTableCreateCompanionBuilder,
    $$ClientesTableUpdateCompanionBuilder,
    (Cliente, $$ClientesTableReferences),
    Cliente,
    PrefetchHooks Function({bool dispositivosRefs})> {
  $$ClientesTableTableManager(_$AppDatabase db, $ClientesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String> telefono = const Value.absent(),
            Value<DateTime> fechaRegistro = const Value.absent(),
          }) =>
              ClientesCompanion(
            id: id,
            nombre: nombre,
            telefono: telefono,
            fechaRegistro: fechaRegistro,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            required String telefono,
            Value<DateTime> fechaRegistro = const Value.absent(),
          }) =>
              ClientesCompanion.insert(
            id: id,
            nombre: nombre,
            telefono: telefono,
            fechaRegistro: fechaRegistro,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$ClientesTable, Cliente>(table),
                    $$ClientesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({dispositivosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (dispositivosRefs) db.dispositivos],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (dispositivosRefs)
                    await $_getPrefetchedDataByColumns<Cliente, $ClientesTable,
                            Dispositivo, $DispositivosTable>(
                        currentTable: table,
                        referencedTable: $$ClientesTableReferences
                            ._dispositivosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ClientesTableReferences(db, table, p0)
                                .dispositivosRefs,
                        currentColumn: 'id',
                        referencedColumn: 'cliente_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ClientesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ClientesTable,
    Cliente,
    $$ClientesTableFilterComposer,
    $$ClientesTableOrderingComposer,
    $$ClientesTableAnnotationComposer,
    $$ClientesTableCreateCompanionBuilder,
    $$ClientesTableUpdateCompanionBuilder,
    (Cliente, $$ClientesTableReferences),
    Cliente,
    PrefetchHooks Function({bool dispositivosRefs})>;
typedef $$DispositivosTableCreateCompanionBuilder = DispositivosCompanion
    Function({
  Value<int> id,
  required int clienteId,
  required String tipo,
  required String marca,
  required String modelo,
  Value<String?> numeroSerie,
});
typedef $$DispositivosTableUpdateCompanionBuilder = DispositivosCompanion
    Function({
  Value<int> id,
  Value<int> clienteId,
  Value<String> tipo,
  Value<String> marca,
  Value<String> modelo,
  Value<String?> numeroSerie,
});

final class $$DispositivosTableReferences
    extends BaseReferences<_$AppDatabase, $DispositivosTable, Dispositivo> {
  $$DispositivosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientesTable _clienteIdTable(_$AppDatabase db) =>
      db.clientes.createAlias('dispositivos__cliente_id__clientes__id');

  $$ClientesTableProcessedTableManager get clienteId {
    final $_column = $_itemColumn<int>('cliente_id')!;

    final manager = $$ClientesTableTableManager($_db, $_db.clientes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clienteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$OrdenesTable, List<Orden>> _ordenesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.ordenes,
          aliasName: 'dispositivos__id__ordenes__dispositivo_id');

  $$OrdenesTableProcessedTableManager get ordenesRefs {
    final manager = $$OrdenesTableTableManager($_db, $_db.ordenes)
        .filter((f) => f.dispositivoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordenesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$DispositivosTableFilterComposer
    extends Composer<_$AppDatabase, $DispositivosTable> {
  $$DispositivosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get marca => $composableBuilder(
      column: $table.marca, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get modelo => $composableBuilder(
      column: $table.modelo, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get numeroSerie => $composableBuilder(
      column: $table.numeroSerie, builder: (column) => ColumnFilters(column));

  $$ClientesTableFilterComposer get clienteId {
    final $$ClientesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableFilterComposer(
              $db: $db,
              $table: $db.clientes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> ordenesRefs(
      Expression<bool> Function($$OrdenesTableFilterComposer f) f) {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ordenes,
        getReferencedColumn: (t) => t.dispositivoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdenesTableFilterComposer(
              $db: $db,
              $table: $db.ordenes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DispositivosTableOrderingComposer
    extends Composer<_$AppDatabase, $DispositivosTable> {
  $$DispositivosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tipo => $composableBuilder(
      column: $table.tipo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get marca => $composableBuilder(
      column: $table.marca, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get modelo => $composableBuilder(
      column: $table.modelo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get numeroSerie => $composableBuilder(
      column: $table.numeroSerie, builder: (column) => ColumnOrderings(column));

  $$ClientesTableOrderingComposer get clienteId {
    final $$ClientesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableOrderingComposer(
              $db: $db,
              $table: $db.clientes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$DispositivosTableAnnotationComposer
    extends Composer<_$AppDatabase, $DispositivosTable> {
  $$DispositivosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get marca =>
      $composableBuilder(column: $table.marca, builder: (column) => column);

  GeneratedColumn<String> get modelo =>
      $composableBuilder(column: $table.modelo, builder: (column) => column);

  GeneratedColumn<String> get numeroSerie => $composableBuilder(
      column: $table.numeroSerie, builder: (column) => column);

  $$ClientesTableAnnotationComposer get clienteId {
    final $$ClientesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.clienteId,
        referencedTable: $db.clientes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ClientesTableAnnotationComposer(
              $db: $db,
              $table: $db.clientes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> ordenesRefs<T extends Object>(
      Expression<T> Function($$OrdenesTableAnnotationComposer a) f) {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ordenes,
        getReferencedColumn: (t) => t.dispositivoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdenesTableAnnotationComposer(
              $db: $db,
              $table: $db.ordenes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$DispositivosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $DispositivosTable,
    Dispositivo,
    $$DispositivosTableFilterComposer,
    $$DispositivosTableOrderingComposer,
    $$DispositivosTableAnnotationComposer,
    $$DispositivosTableCreateCompanionBuilder,
    $$DispositivosTableUpdateCompanionBuilder,
    (Dispositivo, $$DispositivosTableReferences),
    Dispositivo,
    PrefetchHooks Function({bool clienteId, bool ordenesRefs})> {
  $$DispositivosTableTableManager(_$AppDatabase db, $DispositivosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DispositivosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DispositivosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DispositivosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> clienteId = const Value.absent(),
            Value<String> tipo = const Value.absent(),
            Value<String> marca = const Value.absent(),
            Value<String> modelo = const Value.absent(),
            Value<String?> numeroSerie = const Value.absent(),
          }) =>
              DispositivosCompanion(
            id: id,
            clienteId: clienteId,
            tipo: tipo,
            marca: marca,
            modelo: modelo,
            numeroSerie: numeroSerie,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int clienteId,
            required String tipo,
            required String marca,
            required String modelo,
            Value<String?> numeroSerie = const Value.absent(),
          }) =>
              DispositivosCompanion.insert(
            id: id,
            clienteId: clienteId,
            tipo: tipo,
            marca: marca,
            modelo: modelo,
            numeroSerie: numeroSerie,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$DispositivosTable, Dispositivo>(table),
                    $$DispositivosTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({clienteId = false, ordenesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ordenesRefs) db.ordenes],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (clienteId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.clienteId,
                    referencedTable:
                        $$DispositivosTableReferences._clienteIdTable(db),
                    referencedColumn:
                        $$DispositivosTableReferences._clienteIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordenesRefs)
                    await $_getPrefetchedDataByColumns<Dispositivo,
                            $DispositivosTable, Orden, $OrdenesTable>(
                        currentTable: table,
                        referencedTable:
                            $$DispositivosTableReferences._ordenesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$DispositivosTableReferences(db, table, p0)
                                .ordenesRefs,
                        currentColumn: 'id',
                        referencedColumn: 'dispositivo_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$DispositivosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $DispositivosTable,
    Dispositivo,
    $$DispositivosTableFilterComposer,
    $$DispositivosTableOrderingComposer,
    $$DispositivosTableAnnotationComposer,
    $$DispositivosTableCreateCompanionBuilder,
    $$DispositivosTableUpdateCompanionBuilder,
    (Dispositivo, $$DispositivosTableReferences),
    Dispositivo,
    PrefetchHooks Function({bool clienteId, bool ordenesRefs})>;
typedef $$TecnicosTableCreateCompanionBuilder = TecnicosCompanion Function({
  Value<int> id,
  required String nombre,
});
typedef $$TecnicosTableUpdateCompanionBuilder = TecnicosCompanion Function({
  Value<int> id,
  Value<String> nombre,
});

final class $$TecnicosTableReferences
    extends BaseReferences<_$AppDatabase, $TecnicosTable, Tecnico> {
  $$TecnicosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrdenesTable, List<Orden>> _ordenesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.ordenes,
          aliasName: 'tecnicos__id__ordenes__tecnico_id');

  $$OrdenesTableProcessedTableManager get ordenesRefs {
    final manager = $$OrdenesTableTableManager($_db, $_db.ordenes)
        .filter((f) => f.tecnicoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordenesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$TecnicosTableFilterComposer
    extends Composer<_$AppDatabase, $TecnicosTable> {
  $$TecnicosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  Expression<bool> ordenesRefs(
      Expression<bool> Function($$OrdenesTableFilterComposer f) f) {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ordenes,
        getReferencedColumn: (t) => t.tecnicoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdenesTableFilterComposer(
              $db: $db,
              $table: $db.ordenes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TecnicosTableOrderingComposer
    extends Composer<_$AppDatabase, $TecnicosTable> {
  $$TecnicosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));
}

class $$TecnicosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TecnicosTable> {
  $$TecnicosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  Expression<T> ordenesRefs<T extends Object>(
      Expression<T> Function($$OrdenesTableAnnotationComposer a) f) {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.ordenes,
        getReferencedColumn: (t) => t.tecnicoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdenesTableAnnotationComposer(
              $db: $db,
              $table: $db.ordenes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$TecnicosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TecnicosTable,
    Tecnico,
    $$TecnicosTableFilterComposer,
    $$TecnicosTableOrderingComposer,
    $$TecnicosTableAnnotationComposer,
    $$TecnicosTableCreateCompanionBuilder,
    $$TecnicosTableUpdateCompanionBuilder,
    (Tecnico, $$TecnicosTableReferences),
    Tecnico,
    PrefetchHooks Function({bool ordenesRefs})> {
  $$TecnicosTableTableManager(_$AppDatabase db, $TecnicosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TecnicosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TecnicosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TecnicosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
          }) =>
              TecnicosCompanion(
            id: id,
            nombre: nombre,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
          }) =>
              TecnicosCompanion.insert(
            id: id,
            nombre: nombre,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$TecnicosTable, Tecnico>(table),
                    $$TecnicosTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({ordenesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ordenesRefs) db.ordenes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordenesRefs)
                    await $_getPrefetchedDataByColumns<Tecnico, $TecnicosTable,
                            Orden, $OrdenesTable>(
                        currentTable: table,
                        referencedTable:
                            $$TecnicosTableReferences._ordenesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$TecnicosTableReferences(db, table, p0)
                                .ordenesRefs,
                        currentColumn: 'id',
                        referencedColumn: 'tecnico_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$TecnicosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TecnicosTable,
    Tecnico,
    $$TecnicosTableFilterComposer,
    $$TecnicosTableOrderingComposer,
    $$TecnicosTableAnnotationComposer,
    $$TecnicosTableCreateCompanionBuilder,
    $$TecnicosTableUpdateCompanionBuilder,
    (Tecnico, $$TecnicosTableReferences),
    Tecnico,
    PrefetchHooks Function({bool ordenesRefs})>;
typedef $$OrdenesTableCreateCompanionBuilder = OrdenesCompanion Function({
  Value<int> id,
  required int dispositivoId,
  required int tecnicoId,
  required String fallaReportada,
  Value<String> estado,
  Value<DateTime> fechaRecepcion,
  Value<DateTime?> fechaEntrega,
});
typedef $$OrdenesTableUpdateCompanionBuilder = OrdenesCompanion Function({
  Value<int> id,
  Value<int> dispositivoId,
  Value<int> tecnicoId,
  Value<String> fallaReportada,
  Value<String> estado,
  Value<DateTime> fechaRecepcion,
  Value<DateTime?> fechaEntrega,
});

final class $$OrdenesTableReferences
    extends BaseReferences<_$AppDatabase, $OrdenesTable, Orden> {
  $$OrdenesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $DispositivosTable _dispositivoIdTable(_$AppDatabase db) =>
      db.dispositivos.createAlias('ordenes__dispositivo_id__dispositivos__id');

  $$DispositivosTableProcessedTableManager get dispositivoId {
    final $_column = $_itemColumn<int>('dispositivo_id')!;

    final manager = $$DispositivosTableTableManager($_db, $_db.dispositivos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_dispositivoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $TecnicosTable _tecnicoIdTable(_$AppDatabase db) =>
      db.tecnicos.createAlias('ordenes__tecnico_id__tecnicos__id');

  $$TecnicosTableProcessedTableManager get tecnicoId {
    final $_column = $_itemColumn<int>('tecnico_id')!;

    final manager = $$TecnicosTableTableManager($_db, $_db.tecnicos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tecnicoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$TrabajosTable, List<Trabajo>> _trabajosRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.trabajos,
          aliasName: 'ordenes__id__trabajos__orden_id');

  $$TrabajosTableProcessedTableManager get trabajosRefs {
    final manager = $$TrabajosTableTableManager($_db, $_db.trabajos)
        .filter((f) => f.ordenId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_trabajosRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$RepuestosOrdenTable, List<RepuestosOrdenData>>
      _repuestosOrdenRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.repuestosOrden,
              aliasName: 'ordenes__id__repuestos_orden__orden_id');

  $$RepuestosOrdenTableProcessedTableManager get repuestosOrdenRefs {
    final manager = $$RepuestosOrdenTableTableManager($_db, $_db.repuestosOrden)
        .filter((f) => f.ordenId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_repuestosOrdenRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$OrdenesTableFilterComposer
    extends Composer<_$AppDatabase, $OrdenesTable> {
  $$OrdenesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get fallaReportada => $composableBuilder(
      column: $table.fallaReportada,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaRecepcion => $composableBuilder(
      column: $table.fechaRecepcion,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get fechaEntrega => $composableBuilder(
      column: $table.fechaEntrega, builder: (column) => ColumnFilters(column));

  $$DispositivosTableFilterComposer get dispositivoId {
    final $$DispositivosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dispositivoId,
        referencedTable: $db.dispositivos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DispositivosTableFilterComposer(
              $db: $db,
              $table: $db.dispositivos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TecnicosTableFilterComposer get tecnicoId {
    final $$TecnicosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tecnicoId,
        referencedTable: $db.tecnicos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TecnicosTableFilterComposer(
              $db: $db,
              $table: $db.tecnicos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> trabajosRefs(
      Expression<bool> Function($$TrabajosTableFilterComposer f) f) {
    final $$TrabajosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.trabajos,
        getReferencedColumn: (t) => t.ordenId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrabajosTableFilterComposer(
              $db: $db,
              $table: $db.trabajos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> repuestosOrdenRefs(
      Expression<bool> Function($$RepuestosOrdenTableFilterComposer f) f) {
    final $$RepuestosOrdenTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.repuestosOrden,
        getReferencedColumn: (t) => t.ordenId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RepuestosOrdenTableFilterComposer(
              $db: $db,
              $table: $db.repuestosOrden,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrdenesTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdenesTable> {
  $$OrdenesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get fallaReportada => $composableBuilder(
      column: $table.fallaReportada,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get estado => $composableBuilder(
      column: $table.estado, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaRecepcion => $composableBuilder(
      column: $table.fechaRecepcion,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get fechaEntrega => $composableBuilder(
      column: $table.fechaEntrega,
      builder: (column) => ColumnOrderings(column));

  $$DispositivosTableOrderingComposer get dispositivoId {
    final $$DispositivosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dispositivoId,
        referencedTable: $db.dispositivos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DispositivosTableOrderingComposer(
              $db: $db,
              $table: $db.dispositivos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TecnicosTableOrderingComposer get tecnicoId {
    final $$TecnicosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tecnicoId,
        referencedTable: $db.tecnicos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TecnicosTableOrderingComposer(
              $db: $db,
              $table: $db.tecnicos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$OrdenesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdenesTable> {
  $$OrdenesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fallaReportada => $composableBuilder(
      column: $table.fallaReportada, builder: (column) => column);

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaRecepcion => $composableBuilder(
      column: $table.fechaRecepcion, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaEntrega => $composableBuilder(
      column: $table.fechaEntrega, builder: (column) => column);

  $$DispositivosTableAnnotationComposer get dispositivoId {
    final $$DispositivosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.dispositivoId,
        referencedTable: $db.dispositivos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$DispositivosTableAnnotationComposer(
              $db: $db,
              $table: $db.dispositivos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$TecnicosTableAnnotationComposer get tecnicoId {
    final $$TecnicosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.tecnicoId,
        referencedTable: $db.tecnicos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TecnicosTableAnnotationComposer(
              $db: $db,
              $table: $db.tecnicos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> trabajosRefs<T extends Object>(
      Expression<T> Function($$TrabajosTableAnnotationComposer a) f) {
    final $$TrabajosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.trabajos,
        getReferencedColumn: (t) => t.ordenId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$TrabajosTableAnnotationComposer(
              $db: $db,
              $table: $db.trabajos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> repuestosOrdenRefs<T extends Object>(
      Expression<T> Function($$RepuestosOrdenTableAnnotationComposer a) f) {
    final $$RepuestosOrdenTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.repuestosOrden,
        getReferencedColumn: (t) => t.ordenId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RepuestosOrdenTableAnnotationComposer(
              $db: $db,
              $table: $db.repuestosOrden,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$OrdenesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $OrdenesTable,
    Orden,
    $$OrdenesTableFilterComposer,
    $$OrdenesTableOrderingComposer,
    $$OrdenesTableAnnotationComposer,
    $$OrdenesTableCreateCompanionBuilder,
    $$OrdenesTableUpdateCompanionBuilder,
    (Orden, $$OrdenesTableReferences),
    Orden,
    PrefetchHooks Function(
        {bool dispositivoId,
        bool tecnicoId,
        bool trabajosRefs,
        bool repuestosOrdenRefs})> {
  $$OrdenesTableTableManager(_$AppDatabase db, $OrdenesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdenesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdenesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdenesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> dispositivoId = const Value.absent(),
            Value<int> tecnicoId = const Value.absent(),
            Value<String> fallaReportada = const Value.absent(),
            Value<String> estado = const Value.absent(),
            Value<DateTime> fechaRecepcion = const Value.absent(),
            Value<DateTime?> fechaEntrega = const Value.absent(),
          }) =>
              OrdenesCompanion(
            id: id,
            dispositivoId: dispositivoId,
            tecnicoId: tecnicoId,
            fallaReportada: fallaReportada,
            estado: estado,
            fechaRecepcion: fechaRecepcion,
            fechaEntrega: fechaEntrega,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int dispositivoId,
            required int tecnicoId,
            required String fallaReportada,
            Value<String> estado = const Value.absent(),
            Value<DateTime> fechaRecepcion = const Value.absent(),
            Value<DateTime?> fechaEntrega = const Value.absent(),
          }) =>
              OrdenesCompanion.insert(
            id: id,
            dispositivoId: dispositivoId,
            tecnicoId: tecnicoId,
            fallaReportada: fallaReportada,
            estado: estado,
            fechaRecepcion: fechaRecepcion,
            fechaEntrega: fechaEntrega,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$OrdenesTable, Orden>(table),
                    $$OrdenesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: (
              {dispositivoId = false,
              tecnicoId = false,
              trabajosRefs = false,
              repuestosOrdenRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (trabajosRefs) db.trabajos,
                if (repuestosOrdenRefs) db.repuestosOrden
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (dispositivoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.dispositivoId,
                    referencedTable:
                        $$OrdenesTableReferences._dispositivoIdTable(db),
                    referencedColumn:
                        $$OrdenesTableReferences._dispositivoIdTable(db).id,
                  ) as T;
                }
                if (tecnicoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.tecnicoId,
                    referencedTable:
                        $$OrdenesTableReferences._tecnicoIdTable(db),
                    referencedColumn:
                        $$OrdenesTableReferences._tecnicoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (trabajosRefs)
                    await $_getPrefetchedDataByColumns<Orden, $OrdenesTable,
                            Trabajo, $TrabajosTable>(
                        currentTable: table,
                        referencedTable:
                            $$OrdenesTableReferences._trabajosRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$OrdenesTableReferences(db, table, p0)
                                .trabajosRefs,
                        currentColumn: 'id',
                        referencedColumn: 'orden_id',
                        typedResults: items),
                  if (repuestosOrdenRefs)
                    await $_getPrefetchedDataByColumns<Orden, $OrdenesTable,
                            RepuestosOrdenData, $RepuestosOrdenTable>(
                        currentTable: table,
                        referencedTable: $$OrdenesTableReferences
                            ._repuestosOrdenRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$OrdenesTableReferences(db, table, p0)
                                .repuestosOrdenRefs,
                        currentColumn: 'id',
                        referencedColumn: 'orden_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$OrdenesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $OrdenesTable,
    Orden,
    $$OrdenesTableFilterComposer,
    $$OrdenesTableOrderingComposer,
    $$OrdenesTableAnnotationComposer,
    $$OrdenesTableCreateCompanionBuilder,
    $$OrdenesTableUpdateCompanionBuilder,
    (Orden, $$OrdenesTableReferences),
    Orden,
    PrefetchHooks Function(
        {bool dispositivoId,
        bool tecnicoId,
        bool trabajosRefs,
        bool repuestosOrdenRefs})>;
typedef $$TrabajosTableCreateCompanionBuilder = TrabajosCompanion Function({
  Value<int> id,
  required int ordenId,
  required String descripcion,
  required int costeCentavos,
});
typedef $$TrabajosTableUpdateCompanionBuilder = TrabajosCompanion Function({
  Value<int> id,
  Value<int> ordenId,
  Value<String> descripcion,
  Value<int> costeCentavos,
});

final class $$TrabajosTableReferences
    extends BaseReferences<_$AppDatabase, $TrabajosTable, Trabajo> {
  $$TrabajosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdenesTable _ordenIdTable(_$AppDatabase db) =>
      db.ordenes.createAlias('trabajos__orden_id__ordenes__id');

  $$OrdenesTableProcessedTableManager get ordenId {
    final $_column = $_itemColumn<int>('orden_id')!;

    final manager = $$OrdenesTableTableManager($_db, $_db.ordenes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ordenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$TrabajosTableFilterComposer
    extends Composer<_$AppDatabase, $TrabajosTable> {
  $$TrabajosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get costeCentavos => $composableBuilder(
      column: $table.costeCentavos, builder: (column) => ColumnFilters(column));

  $$OrdenesTableFilterComposer get ordenId {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ordenId,
        referencedTable: $db.ordenes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdenesTableFilterComposer(
              $db: $db,
              $table: $db.ordenes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TrabajosTableOrderingComposer
    extends Composer<_$AppDatabase, $TrabajosTable> {
  $$TrabajosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get costeCentavos => $composableBuilder(
      column: $table.costeCentavos,
      builder: (column) => ColumnOrderings(column));

  $$OrdenesTableOrderingComposer get ordenId {
    final $$OrdenesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ordenId,
        referencedTable: $db.ordenes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdenesTableOrderingComposer(
              $db: $db,
              $table: $db.ordenes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TrabajosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrabajosTable> {
  $$TrabajosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
      column: $table.descripcion, builder: (column) => column);

  GeneratedColumn<int> get costeCentavos => $composableBuilder(
      column: $table.costeCentavos, builder: (column) => column);

  $$OrdenesTableAnnotationComposer get ordenId {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ordenId,
        referencedTable: $db.ordenes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdenesTableAnnotationComposer(
              $db: $db,
              $table: $db.ordenes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$TrabajosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $TrabajosTable,
    Trabajo,
    $$TrabajosTableFilterComposer,
    $$TrabajosTableOrderingComposer,
    $$TrabajosTableAnnotationComposer,
    $$TrabajosTableCreateCompanionBuilder,
    $$TrabajosTableUpdateCompanionBuilder,
    (Trabajo, $$TrabajosTableReferences),
    Trabajo,
    PrefetchHooks Function({bool ordenId})> {
  $$TrabajosTableTableManager(_$AppDatabase db, $TrabajosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrabajosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrabajosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrabajosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ordenId = const Value.absent(),
            Value<String> descripcion = const Value.absent(),
            Value<int> costeCentavos = const Value.absent(),
          }) =>
              TrabajosCompanion(
            id: id,
            ordenId: ordenId,
            descripcion: descripcion,
            costeCentavos: costeCentavos,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ordenId,
            required String descripcion,
            required int costeCentavos,
          }) =>
              TrabajosCompanion.insert(
            id: id,
            ordenId: ordenId,
            descripcion: descripcion,
            costeCentavos: costeCentavos,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$TrabajosTable, Trabajo>(table),
                    $$TrabajosTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({ordenId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (ordenId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ordenId,
                    referencedTable:
                        $$TrabajosTableReferences._ordenIdTable(db),
                    referencedColumn:
                        $$TrabajosTableReferences._ordenIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$TrabajosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $TrabajosTable,
    Trabajo,
    $$TrabajosTableFilterComposer,
    $$TrabajosTableOrderingComposer,
    $$TrabajosTableAnnotationComposer,
    $$TrabajosTableCreateCompanionBuilder,
    $$TrabajosTableUpdateCompanionBuilder,
    (Trabajo, $$TrabajosTableReferences),
    Trabajo,
    PrefetchHooks Function({bool ordenId})>;
typedef $$RepuestosTableCreateCompanionBuilder = RepuestosCompanion Function({
  Value<int> id,
  required String nombre,
  required String codigo,
  required int precioCentavos,
  required int existencias,
  Value<int> nivelMinimo,
});
typedef $$RepuestosTableUpdateCompanionBuilder = RepuestosCompanion Function({
  Value<int> id,
  Value<String> nombre,
  Value<String> codigo,
  Value<int> precioCentavos,
  Value<int> existencias,
  Value<int> nivelMinimo,
});

final class $$RepuestosTableReferences
    extends BaseReferences<_$AppDatabase, $RepuestosTable, Repuesto> {
  $$RepuestosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RepuestosOrdenTable, List<RepuestosOrdenData>>
      _repuestosOrdenRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.repuestosOrden,
              aliasName: 'repuestos__id__repuestos_orden__repuesto_id');

  $$RepuestosOrdenTableProcessedTableManager get repuestosOrdenRefs {
    final manager = $$RepuestosOrdenTableTableManager($_db, $_db.repuestosOrden)
        .filter((f) => f.repuestoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_repuestosOrdenRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$RepuestosTableFilterComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get precioCentavos => $composableBuilder(
      column: $table.precioCentavos,
      builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get existencias => $composableBuilder(
      column: $table.existencias, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get nivelMinimo => $composableBuilder(
      column: $table.nivelMinimo, builder: (column) => ColumnFilters(column));

  Expression<bool> repuestosOrdenRefs(
      Expression<bool> Function($$RepuestosOrdenTableFilterComposer f) f) {
    final $$RepuestosOrdenTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.repuestosOrden,
        getReferencedColumn: (t) => t.repuestoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RepuestosOrdenTableFilterComposer(
              $db: $db,
              $table: $db.repuestosOrden,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RepuestosTableOrderingComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get nombre => $composableBuilder(
      column: $table.nombre, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get codigo => $composableBuilder(
      column: $table.codigo, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get precioCentavos => $composableBuilder(
      column: $table.precioCentavos,
      builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get existencias => $composableBuilder(
      column: $table.existencias, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get nivelMinimo => $composableBuilder(
      column: $table.nivelMinimo, builder: (column) => ColumnOrderings(column));
}

class $$RepuestosTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<int> get precioCentavos => $composableBuilder(
      column: $table.precioCentavos, builder: (column) => column);

  GeneratedColumn<int> get existencias => $composableBuilder(
      column: $table.existencias, builder: (column) => column);

  GeneratedColumn<int> get nivelMinimo => $composableBuilder(
      column: $table.nivelMinimo, builder: (column) => column);

  Expression<T> repuestosOrdenRefs<T extends Object>(
      Expression<T> Function($$RepuestosOrdenTableAnnotationComposer a) f) {
    final $$RepuestosOrdenTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.repuestosOrden,
        getReferencedColumn: (t) => t.repuestoId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RepuestosOrdenTableAnnotationComposer(
              $db: $db,
              $table: $db.repuestosOrden,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$RepuestosTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RepuestosTable,
    Repuesto,
    $$RepuestosTableFilterComposer,
    $$RepuestosTableOrderingComposer,
    $$RepuestosTableAnnotationComposer,
    $$RepuestosTableCreateCompanionBuilder,
    $$RepuestosTableUpdateCompanionBuilder,
    (Repuesto, $$RepuestosTableReferences),
    Repuesto,
    PrefetchHooks Function({bool repuestosOrdenRefs})> {
  $$RepuestosTableTableManager(_$AppDatabase db, $RepuestosTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepuestosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepuestosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepuestosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> nombre = const Value.absent(),
            Value<String> codigo = const Value.absent(),
            Value<int> precioCentavos = const Value.absent(),
            Value<int> existencias = const Value.absent(),
            Value<int> nivelMinimo = const Value.absent(),
          }) =>
              RepuestosCompanion(
            id: id,
            nombre: nombre,
            codigo: codigo,
            precioCentavos: precioCentavos,
            existencias: existencias,
            nivelMinimo: nivelMinimo,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String nombre,
            required String codigo,
            required int precioCentavos,
            required int existencias,
            Value<int> nivelMinimo = const Value.absent(),
          }) =>
              RepuestosCompanion.insert(
            id: id,
            nombre: nombre,
            codigo: codigo,
            precioCentavos: precioCentavos,
            existencias: existencias,
            nivelMinimo: nivelMinimo,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$RepuestosTable, Repuesto>(table),
                    $$RepuestosTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({repuestosOrdenRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (repuestosOrdenRefs) db.repuestosOrden
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (repuestosOrdenRefs)
                    await $_getPrefetchedDataByColumns<
                            Repuesto,
                            $RepuestosTable,
                            RepuestosOrdenData,
                            $RepuestosOrdenTable>(
                        currentTable: table,
                        referencedTable: $$RepuestosTableReferences
                            ._repuestosOrdenRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$RepuestosTableReferences(db, table, p0)
                                .repuestosOrdenRefs,
                        currentColumn: 'id',
                        referencedColumn: 'repuesto_id',
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$RepuestosTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RepuestosTable,
    Repuesto,
    $$RepuestosTableFilterComposer,
    $$RepuestosTableOrderingComposer,
    $$RepuestosTableAnnotationComposer,
    $$RepuestosTableCreateCompanionBuilder,
    $$RepuestosTableUpdateCompanionBuilder,
    (Repuesto, $$RepuestosTableReferences),
    Repuesto,
    PrefetchHooks Function({bool repuestosOrdenRefs})>;
typedef $$RepuestosOrdenTableCreateCompanionBuilder = RepuestosOrdenCompanion
    Function({
  Value<int> id,
  required int ordenId,
  required int repuestoId,
  required int cantidad,
  required int precioUnitarioCentavos,
});
typedef $$RepuestosOrdenTableUpdateCompanionBuilder = RepuestosOrdenCompanion
    Function({
  Value<int> id,
  Value<int> ordenId,
  Value<int> repuestoId,
  Value<int> cantidad,
  Value<int> precioUnitarioCentavos,
});

final class $$RepuestosOrdenTableReferences extends BaseReferences<
    _$AppDatabase, $RepuestosOrdenTable, RepuestosOrdenData> {
  $$RepuestosOrdenTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $OrdenesTable _ordenIdTable(_$AppDatabase db) =>
      db.ordenes.createAlias('repuestos_orden__orden_id__ordenes__id');

  $$OrdenesTableProcessedTableManager get ordenId {
    final $_column = $_itemColumn<int>('orden_id')!;

    final manager = $$OrdenesTableTableManager($_db, $_db.ordenes)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ordenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $RepuestosTable _repuestoIdTable(_$AppDatabase db) =>
      db.repuestos.createAlias('repuestos_orden__repuesto_id__repuestos__id');

  $$RepuestosTableProcessedTableManager get repuestoId {
    final $_column = $_itemColumn<int>('repuesto_id')!;

    final manager = $$RepuestosTableTableManager($_db, $_db.repuestos)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_repuestoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$RepuestosOrdenTableFilterComposer
    extends Composer<_$AppDatabase, $RepuestosOrdenTable> {
  $$RepuestosOrdenTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnFilters(column));

  ColumnFilters<int> get precioUnitarioCentavos => $composableBuilder(
      column: $table.precioUnitarioCentavos,
      builder: (column) => ColumnFilters(column));

  $$OrdenesTableFilterComposer get ordenId {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ordenId,
        referencedTable: $db.ordenes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdenesTableFilterComposer(
              $db: $db,
              $table: $db.ordenes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RepuestosTableFilterComposer get repuestoId {
    final $$RepuestosTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.repuestoId,
        referencedTable: $db.repuestos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RepuestosTableFilterComposer(
              $db: $db,
              $table: $db.repuestos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RepuestosOrdenTableOrderingComposer
    extends Composer<_$AppDatabase, $RepuestosOrdenTable> {
  $$RepuestosOrdenTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get cantidad => $composableBuilder(
      column: $table.cantidad, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<int> get precioUnitarioCentavos => $composableBuilder(
      column: $table.precioUnitarioCentavos,
      builder: (column) => ColumnOrderings(column));

  $$OrdenesTableOrderingComposer get ordenId {
    final $$OrdenesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ordenId,
        referencedTable: $db.ordenes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdenesTableOrderingComposer(
              $db: $db,
              $table: $db.ordenes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RepuestosTableOrderingComposer get repuestoId {
    final $$RepuestosTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.repuestoId,
        referencedTable: $db.repuestos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RepuestosTableOrderingComposer(
              $db: $db,
              $table: $db.repuestos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RepuestosOrdenTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepuestosOrdenTable> {
  $$RepuestosOrdenTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<int> get precioUnitarioCentavos => $composableBuilder(
      column: $table.precioUnitarioCentavos, builder: (column) => column);

  $$OrdenesTableAnnotationComposer get ordenId {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.ordenId,
        referencedTable: $db.ordenes,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$OrdenesTableAnnotationComposer(
              $db: $db,
              $table: $db.ordenes,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$RepuestosTableAnnotationComposer get repuestoId {
    final $$RepuestosTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.repuestoId,
        referencedTable: $db.repuestos,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$RepuestosTableAnnotationComposer(
              $db: $db,
              $table: $db.repuestos,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$RepuestosOrdenTableTableManager extends RootTableManager<
    _$AppDatabase,
    $RepuestosOrdenTable,
    RepuestosOrdenData,
    $$RepuestosOrdenTableFilterComposer,
    $$RepuestosOrdenTableOrderingComposer,
    $$RepuestosOrdenTableAnnotationComposer,
    $$RepuestosOrdenTableCreateCompanionBuilder,
    $$RepuestosOrdenTableUpdateCompanionBuilder,
    (RepuestosOrdenData, $$RepuestosOrdenTableReferences),
    RepuestosOrdenData,
    PrefetchHooks Function({bool ordenId, bool repuestoId})> {
  $$RepuestosOrdenTableTableManager(
      _$AppDatabase db, $RepuestosOrdenTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepuestosOrdenTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepuestosOrdenTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepuestosOrdenTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> ordenId = const Value.absent(),
            Value<int> repuestoId = const Value.absent(),
            Value<int> cantidad = const Value.absent(),
            Value<int> precioUnitarioCentavos = const Value.absent(),
          }) =>
              RepuestosOrdenCompanion(
            id: id,
            ordenId: ordenId,
            repuestoId: repuestoId,
            cantidad: cantidad,
            precioUnitarioCentavos: precioUnitarioCentavos,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int ordenId,
            required int repuestoId,
            required int cantidad,
            required int precioUnitarioCentavos,
          }) =>
              RepuestosOrdenCompanion.insert(
            id: id,
            ordenId: ordenId,
            repuestoId: repuestoId,
            cantidad: cantidad,
            precioUnitarioCentavos: precioUnitarioCentavos,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable<$RepuestosOrdenTable, RepuestosOrdenData>(
                        table),
                    $$RepuestosOrdenTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({ordenId = false, repuestoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (ordenId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.ordenId,
                    referencedTable:
                        $$RepuestosOrdenTableReferences._ordenIdTable(db),
                    referencedColumn:
                        $$RepuestosOrdenTableReferences._ordenIdTable(db).id,
                  ) as T;
                }
                if (repuestoId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.repuestoId,
                    referencedTable:
                        $$RepuestosOrdenTableReferences._repuestoIdTable(db),
                    referencedColumn:
                        $$RepuestosOrdenTableReferences._repuestoIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$RepuestosOrdenTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $RepuestosOrdenTable,
    RepuestosOrdenData,
    $$RepuestosOrdenTableFilterComposer,
    $$RepuestosOrdenTableOrderingComposer,
    $$RepuestosOrdenTableAnnotationComposer,
    $$RepuestosOrdenTableCreateCompanionBuilder,
    $$RepuestosOrdenTableUpdateCompanionBuilder,
    (RepuestosOrdenData, $$RepuestosOrdenTableReferences),
    RepuestosOrdenData,
    PrefetchHooks Function({bool ordenId, bool repuestoId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientesTableTableManager get clientes =>
      $$ClientesTableTableManager(_db, _db.clientes);
  $$DispositivosTableTableManager get dispositivos =>
      $$DispositivosTableTableManager(_db, _db.dispositivos);
  $$TecnicosTableTableManager get tecnicos =>
      $$TecnicosTableTableManager(_db, _db.tecnicos);
  $$OrdenesTableTableManager get ordenes =>
      $$OrdenesTableTableManager(_db, _db.ordenes);
  $$TrabajosTableTableManager get trabajos =>
      $$TrabajosTableTableManager(_db, _db.trabajos);
  $$RepuestosTableTableManager get repuestos =>
      $$RepuestosTableTableManager(_db, _db.repuestos);
  $$RepuestosOrdenTableTableManager get repuestosOrden =>
      $$RepuestosOrdenTableTableManager(_db, _db.repuestosOrden);
}
