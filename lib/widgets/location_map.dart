import 'dart:async';
import 'dart:developer';
import 'package:map_launcher/map_launcher.dart' as mapLauncher;
import 'package:beauty_queen/const/extensions.dart';
import '../const/app_images.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:ui' as ui;
import 'package:flutter/services.dart';

class LocationMap extends StatefulWidget {
  LocationMap({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LocationMap();
  }
}

class _LocationMap extends State<LocationMap> {
  double defaultLng = 30.05736217878459;
  double defaultLat = 31.243119488562105;
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? _gMapController;

  Future<Uint8List?> getBytesFromAsset() async {
    ByteData data = await rootBundle.load(AppImages.imageMarker);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: 124);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        ?.buffer
        .asUint8List();
  }

  @override
  void initState() {
    super.initState();
    addMarker();
  }

  final Set<Marker> _markers = <Marker>{};
  addMarker() async {
    final Uint8List? markerIcon = await getBytesFromAsset();
    print('markerIcon:${markerIcon}');
    print('_markers:${_markers.length}');
    _markers.add(
      Marker(
        icon: markerIcon!=null
            ? BitmapDescriptor.fromBytes(markerIcon) :
        BitmapDescriptor.defaultMarker,
        markerId: MarkerId(LatLng(defaultLat, defaultLng).toString()),
        position: LatLng(defaultLat, defaultLng),
      ),
    );
    setState(() {
    });
    print('_markers:${_markers.length}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Transform.flip(
                flipX: true,
                child: Image.asset(
                  AppImages.imagePin,
                  height: 30,
                  width: 30,
                )),
            10.pw,
            Text(
              'موقعنا على خرائط قوقل',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
            )
          ],
        ),
        10.ph,
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 400,
          child: GoogleMap(
            mapType: MapType.normal,
            myLocationEnabled: false,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: true,
            // zoomGesturesEnabled: true,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                defaultLat,
                defaultLng,
              ),
              zoom: 14.0,
            ),
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
              _gMapController = controller;
            },
            onTap: (argument) async {

              // const latitude =
              // 31.241809512813163; // Replace with the desired latitude
              // const longitude = 29.95926284901688;

              final url =
                  'https://www.google.com/maps/search/?api=1&query=$defaultLat,$defaultLng';
              try {
                await launchUrl(Uri.parse(url),
                    mode: LaunchMode.externalApplication);
              } catch (e) {
                log('error:$e');
              }
            },
          ),
        ),
      ],
    );
  }
}
