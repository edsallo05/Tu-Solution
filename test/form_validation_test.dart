import 'package:flutter_test/flutter_test.dart';
import 'package:tu_solution/views/workshop_actions.dart';

void main() {
  // Comprueba las reglas comunes que protegen los formularios del taller.
  test('valida nombres, teléfonos, importes e inventario', () {
    expect(validarCampoFormulario('Nombre completo', 'Ana Pérez'), isNull);
    expect(validarCampoFormulario('Nombre completo', 'Ana Pérez 2'), isNotNull);
    expect(validarCampoFormulario('Nombre', 'Batería'), isNull);
    expect(validarCampoFormulario('Nombre', 'Batería 5'), isNotNull);
    expect(validarCampoFormulario('Teléfono', '12345678'), isNull);
    expect(longitudMaxima('Teléfono'), 8);
    expect(validarCampoFormulario('Teléfono', '1234567'), isNotNull);
    expect(validarCampoFormulario('Teléfono', '1234ABCD'), isNotNull);
    expect(validarCampoFormulario('Precio', '12,50'), isNull);
    expect(validarCampoFormulario('Precio', '-5'), isNotNull);
    expect(validarCampoFormulario('Existencias iniciales', '0'), isNull);
    expect(validarCampoFormulario('Existencias iniciales', '-1'), isNotNull);
    expect(validarCampoFormulario('Avisar cuando queden', '1'), isNull);
    expect(validarCampoFormulario('Avisar cuando queden', 'abc'), isNotNull);
    expect(validarCampoFormulario('Número de serie (opcional)', ''), isNull);
    expect(validarCampoFormulario('Código', 'A/B'), isNull);
  });
}
