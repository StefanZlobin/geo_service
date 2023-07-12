import 'dart:developer';
import 'dart:math' as math;

int latToTileY({
  required double lat,
  required double zoom,
}) {
  const e = 0.0818191908426;

  final rho = math.pow(2, zoom + 8) / 2;
  final beta = lat * math.pi / 180;
  final phi = (1 - e * math.sin(beta)) / (1 + e * math.sin(beta));
  final theta = math.tan(math.pi / 4 + beta / 2) * math.pow(phi, e / 2);

  final int yTile = ((rho * (1 - math.log(theta) / math.pi)) / 256).floor();

  log('latToTileY - $yTile');
  return yTile;
}
