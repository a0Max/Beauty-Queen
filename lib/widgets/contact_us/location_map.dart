import 'dart:async';
import 'dart:developer';
import 'package:beauty_queen/const/extensions.dart';
import 'package:flutter_svg/svg.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'dart:ui' as ui;
import 'package:flutter/services.dart';

import '../../const/vars.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LocationMap();
  }
}

class _LocationMap extends State<LocationMap> {

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
    _markers.add(
      Marker(
        icon: markerIcon!=null
            ? BitmapDescriptor.fromBytes(markerIcon) :
        BitmapDescriptor.defaultMarker,
        markerId: MarkerId(const LatLng(LocationMapLatLng.lat, LocationMapLatLng.lng).toString()),
        position: const LatLng(LocationMapLatLng.lat, LocationMapLatLng.lng),
      ),
    );
    setState(() {
    });
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
                child: SvgPicture.asset(
                  AppImages.imagePin,
                  // height: 30,
                  // width: 30,
                )),
            10.pw,
            const Text(
              'موقعنا على خرائط قوقل',
              style: TextStyle(
                fontFamily: 'TheSans',
                fontSize: 18.74,
                color: AppColors.mainColor,
                fontWeight: FontWeight.w700,
              ),
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
            initialCameraPosition: const CameraPosition(
              target: LatLng(
                  LocationMapLatLng.lat, LocationMapLatLng.lng
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

              const url =
                  'https://www.google.com/maps/search/?api=1&query=${LocationMapLatLng.lat},${LocationMapLatLng.lng}';
              try {
                await launchUrl(Uri.parse(url),
                    mode: LaunchMode.externalApplication);
              } catch (e) {
                log('location-map:error:$e');
              }
            },
          ),
        ),
      ],
    );
  }
}
