import 'dart:async';
import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'signin.dart';
import 'package:http/http.dart' as http;


final String url1 = "https://nec-hn.herokuapp.com/user";
final String url2 = "https://nec-hn.herokuapp.com/driver";

 Future<dynamic> userLocation() async {
  String id = await signInWithGoogle();
  double latitude,longitude;
  void _premiumLocation() async  {
    Position position;

    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
     
      // print(latitude);
      // print(longitude);
    } on Exception {
      position = null;
    }
  
  }
           

 
_premiumLocation();
print(id);
print(latitude);
print(longitude);

  var response = await http.post(Uri.encodeFull(url1),
      body: json.encode({"token": id, "latitude": latitude, "longitude": longitude}),
      headers: {
        "content-type": "application/json",
        "Accept": "application/json"
      });
  print(response.body);
  final int statusCode = response.statusCode;
  if (statusCode == 201) {
    print("Please login again");
  }
}



Future<dynamic> driverLocation() async {
  String id = await signInWithGoogle();
  // print("HELOO");
  // print(id);
  double latitude, longitude;
  void _currentLocation() async {
    Position position;

    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      latitude = position.latitude;
      longitude = position.longitude;
      
    } on Exception {
      position = null;
    }
  }

  _currentLocation();
  print(id);
      print(latitude);
      print(longitude);

  var response = await http.post(Uri.encodeFull(url2),
      body: json
          .encode({"token": id, "latitude": latitude, "longitude": longitude}),
      headers: {
        "content-type": "application/json",
        "Accept": "application/json"
      });
  print(response.body);
  final int statusCode = response.statusCode;
  if (statusCode == 201) {
    print("Please login again");
  }
}
