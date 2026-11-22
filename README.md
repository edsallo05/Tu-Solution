# Tu Solution

Aplicación Android para organizar el trabajo de un taller de reparación. Funciona sin conexión; los datos se guardan localmente en SQLite.

La apariencia sigue por defecto el tema del sistema. Desde el botón de la esquina superior derecha del resumen se puede elegir el tema claro u oscuro; la última elección explícita se guarda localmente y se restaura al abrir de nuevo la aplicación.

El taller mantiene las tres plazas técnicas del caso y permite cambiar sus nombres por los del personal. Las órdenes avanzan de «Recibida» a «En reparación», después a «Lista» y finalmente a «Entregada». Desde cada etapa se puede cancelar la orden; la acción repone en el inventario las piezas usadas. La lista de órdenes filtra abiertas, recibidas, en reparación, listas, entregadas y canceladas.

## Requisitos

- Flutter y Dart compatibles con las versiones indicadas en `pubspec.yaml`.
- Android Studio (Android SDK y herramientas de compilación) o Visual Studio Code con las extensiones de Flutter y Dart.
- Un emulador Android o un teléfono con depuración USB para ejecutar la aplicación.

## Abrir y ejecutar

1. Abre la carpeta del proyecto en Android Studio o VS Code.
2. Instala las dependencias:

   ```bash
   flutter pub get
   ```

3. Genera el código de Drift:

   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. Conecta un emulador o teléfono y ejecuta:

   ```bash
   flutter run
   ```

Para compilar un APK de lanzamiento:

```bash
flutter build apk --release
```

El APK se crea en `build/app/outputs/flutter-apk/app-release.apk`.

## Pruebas y análisis

```bash
dart format lib test
flutter analyze
flutter test
```

## Estructura

```text
lib/
  app/
    app.dart          Aplicación y navegación
    providers.dart    Fuentes de datos reactivas de Riverpod
  data/
    database.dart     Tablas, migración y conexión Drift
    database.g.dart   Código generado por build_runner
    taller_repository.dart
  models/
    taller_models.dart Modelos de dominio basados en filas Drift
  views/
    screens.dart      Archivo índice de las pantallas
    summary_screen.dart
    orders_screen.dart
    clients_screen.dart
    inventory_screen.dart
    technicians_screen.dart
    workshop_actions.dart
  widgets/
    order_components.dart Componentes propios de órdenes
    history_order_card.dart Detalle de órdenes en el historial
    widget_formatters.dart Formato visual de valores comunes
    shared_widgets.dart Widgets compartidos entre pantallas
    theme_mode_button.dart Control de apariencia de la pantalla principal
  viewmodels/
    clientes_view_model.dart
    ordenes_view_model.dart
    inventario_view_model.dart
test/
  taller_repository_test.dart
```

Los formularios muestran errores junto al campo y solo se guardan cuando todos los valores cumplen sus reglas. El teléfono requiere ocho dígitos; nombres no aceptan números; precios deben ser positivos; existencias y mínimos son enteros no negativos; la cantidad usada de un repuesto no puede superar el stock; los textos de falla y trabajo requieren una descripción mínima. La serie es opcional.

La aplicación está separada en MVVM: `views/` muestra datos y recoge acciones; `viewmodels/` valida acciones y coordina el repositorio; `models/` nombra las entidades que Drift genera desde sus tablas; `data/` contiene la base SQLite y el repositorio. `app/providers.dart` conecta las consultas reactivas con las vistas mediante Riverpod. La base crea los tres técnicos iniciales. Las órdenes conservan al cliente mediante su dispositivo y cada visita crea una orden nueva.

El dinero se almacena como centavos enteros para evitar errores de redondeo. Al usar piezas se descuenta inventario dentro de una transacción y se registra el precio unitario de ese momento. Cancelar una orden repone sus piezas una sola vez; las órdenes entregadas y canceladas quedan cerradas. El nivel mínimo de cada repuesto se configura al registrarlo.

## Capturas Android

Las capturas deben tomarse de la aplicación ejecutándose en un emulador o teléfono real. No se incluyen imágenes de ejemplo como si fueran capturas de ejecución. Guarda las capturas verificadas en `docs/capturas/` al disponer de un dispositivo Android en ejecución.
