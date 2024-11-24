import 'package:beauty_queen/const/extensions.dart';
//import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/app_colors.dart';
import '../../const/app_images.dart';

import 'package:flutter/material.dart';

import '../../const/styles.dart';
import '../../const/vars.dart';

class LocationMap extends StatefulWidget {
  const LocationMap({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LocationMap();
  }
}

class _LocationMap extends State<LocationMap> {
  MapController mapController = MapController();
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
                fontFamily: kTheArabicSansBold,
                fontSize: 18.74,
                color: AppColors.mainColor,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
        10.ph,
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: FlutterMap(
              mapController: mapController,
              options: MapOptions(
                  center: const LatLng(
                      LocationMapLatLng.lat, LocationMapLatLng.lng),
                  initialRotation: 0,
                  interactionOptions:
                      const InteractionOptions(flags: InteractiveFlag.none),
                  initialCenter: const LatLng(
                      LocationMapLatLng.lat, LocationMapLatLng.lng),
                  initialZoom: 15,
                  onTap: (x, y) async {
                    const url =
                        'https://www.google.com/maps/search/?api=1&query=${LocationMapLatLng.lat},${LocationMapLatLng.lng}';
                    try {
                      await launchUrl(Uri.parse(url),
                          mode: LaunchMode.externalApplication);
                    } catch (e, s) {
                      // FirebaseCrashlytics.instance
                      //     .recordError('Api Crash $e', s);
                      // log('location-map:error:$e');
                    }
                  },
                  onPositionChanged: (x, y) {}),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      child: Image.asset(
                        AppImages.imageMarker,
                        height: 50,
                        width: 50,
                      ),
                      width: 50,
                      height: 50,
                      point: const LatLng(
                          LocationMapLatLng.lat, LocationMapLatLng.lng),
                    )
                  ],
                ),
              ],
            )

            // GoogleMap(
            //   mapType: MapType.normal,
            //   myLocationEnabled: false,
            //   myLocationButtonEnabled: false,
            //   zoomControlsEnabled: true,
            //   // zoomGesturesEnabled: true,
            //   initialCameraPosition: const CameraPosition(
            //     target: LatLng(
            //         LocationMapLatLng.lat, LocationMapLatLng.lng
            //     ),
            //     zoom: 14.0,
            //   ),
            //   markers: _markers,
            //   onMapCreated: (GoogleMapController controller) {
            //     _controller.complete(controller);
            //     _gMapController = controller;
            //   },
            //   onTap: (argument) async {
            //
            //     // const latitude =
            //     // 31.241809512813163; // Replace with the desired latitude
            //     // const longitude = 29.95926284901688;
            //
            //     const url =
            //         'https://www.google.com/maps/search/?api=1&query=${LocationMapLatLng.lat},${LocationMapLatLng.lng}';
            //     try {
            //       await launchUrl(Uri.parse(url),
            //           mode: LaunchMode.externalApplication);
            //     } catch (e) {
            //       log('location-map:error:$e');
            //     }
            //   },
            // ),
            ),
      ],
    );
  }
}
