import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  @override
  State<MyMap> createState() => MyMapSampleState();
}

class MyMapSampleState extends State<MyMap> {
  final Map<String, Marker> _markers = {};
  final textcontroller1 = TextEditingController();
  final textcontroller2 = TextEditingController();
  GoogleMapController mapController;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text("Maps Navigation"),
        backgroundColor: Colors.red,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Container(
              height: 400,
              width: 500,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(40.688841, -74.044015),
                  zoom: 11,
                ),
                onMapCreated: (GoogleMapController controller) {
                  mapController = controller;
                },
                markers: _markers.values.toSet(),
              ),
            ),
            Form(
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: RaisedButton(
                          color: Colors.greenAccent,
                          onPressed: () {
                            mapController.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                target: LatLng(
                                    double.parse(textcontroller1.text),
                                    double.parse(textcontroller2.text)),
                                zoom: 125.0,
                              )),
                            );
                            setState(() {
                              _markers.clear();
                              final marker = Marker(
                                markerId: MarkerId("desired_loc"),
                                position: LatLng(
                                    double.parse(textcontroller1.text),
                                    double.parse(textcontroller2.text)),
                                infoWindow: InfoWindow(title: 'Your Location'),
                              );
                              _markers["Desired Location"] = marker;
                            });
                          },
                          child: Text("Navigate!"),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: RaisedButton(
                          color: Colors.deepOrange,
                          onPressed: _getLocation,
                          child: Text("Back to your location!"),
                        ),
                      )
                    ],
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter latitude',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.red,
                        ))),
                    controller: textcontroller1,
                  ),
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Enter longitude',
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.red,
                        ))),
                    controller: textcontroller2,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _getLocation() async {
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

    mapController.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        zoom: 125.0,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
      ),
    ));

    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId("curr_loc"),
        position: LatLng(currentLocation.latitude, currentLocation.longitude),
        infoWindow: InfoWindow(title: 'Your Location'),
      );
      _markers["Current Location"] = marker;
    });
  }
}
