import 'dart:developer';
import 'dart:math' as math;

int longToTileX({
  required double lon,
  required double zoom,
}) {
  final rho = math.pow(2, zoom + 8) / 2;

  final int xTile = ((rho * (1 + lon / 180)) / 256).floor();

  log('longToTileX - $xTile');
  return xTile;
}
