// Convierte centavos en una cantidad legible con dos decimales.
String formatoDinero(int centavos) =>
    '\$${(centavos / 100).toStringAsFixed(2)}';
