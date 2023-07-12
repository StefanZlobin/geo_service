import 'package:flutter/material.dart';
import 'package:geo_service/func/lat_to_tile_y.dart';
import 'package:geo_service/func/long_to_tile_x.dart';
import 'package:geo_service/presentation/widgets/app_text_form_field.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final latController = TextEditingController();
    final lonController = TextEditingController();
    final zoomController = TextEditingController();

    final fromKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('geo service'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Form(
              key: fromKey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AppTextFormField(
                    labelText: 'Введите широту',
                    controller: latController,
                    hintText: '55.750626',
                    infoText: 'Широта должна лежать в пределах от -90 до 90',
                  ),
                  AppTextFormField(
                    labelText: 'Введите долготу',
                    controller: lonController,
                    hintText: '37.597664',
                    infoText: 'Долгота должна лежать в пределах от -180 до 180',
                  ),
                  AppTextFormField(
                    labelText: 'Введите зум',
                    controller: zoomController,
                    hintText: '19',
                    infoText: 'Зум должен быть больше или равен 19',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton(
              onPressed: () async {
                if (fromKey.currentState!.validate()) {
                  final lon = double.parse(lonController.text);
                  final lat = double.parse(latController.text);
                  final zoom =
                      double.parse(zoomController.text).roundToDouble();

                  // долгота lon
                  final x = longToTileX(lon: lon, zoom: zoom);

                  // широта lat
                  final y = latToTileY(lat: lat, zoom: zoom);

                  final url = Uri.parse(
                    'https://core-carparks-renderer-lots.maps.yandex.net/maps-rdr-carparks/tiles?l=carparks&x=$x&y=$y&z=$zoom&scale=1&lang=ru_RU',
                  );

                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                }
              },
              child: const Text('Рассчитать'),
            ),
          ],
        ),
      ),
    );
  }
}
