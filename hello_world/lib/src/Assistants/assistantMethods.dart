import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hello_world/src/Assistants/requestAssistant.dart';
import 'package:hello_world/src/DataHandler/appData.dart';
import 'package:hello_world/src/model/address.dart';
import 'package:hello_world/src/model/directDetails.dart';
import 'package:provider/provider.dart';


class AssistantMethods{
  static int distance;
  static Future<String> searchCoordinateAddress(Position position, context)async{
    String placeAddress="";
    String url ="https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=AIzaSyD_C8wAXgGf5ir9Gw6nkN_A387I6lpRXeU";

    var response = await RequestAssistant.getRequest(url);

    if(response != "fail, No Response"){
      placeAddress = response["results"][0]["formatted_address"];
    Address userPickupAddress = new Address();
    userPickupAddress.longitude=position.longitude;
    userPickupAddress.latitude=position.latitude;
    userPickupAddress.placeName= placeAddress;

    Provider.of<AppData>(context, listen:false).updatePickUpLocationAddress(userPickupAddress);
    }
    return placeAddress;
  }
  static Future<DirectionDetails> obtainPlaceDirectionDetails(LatLng initialPosition, LatLng finalPosition) async{
    String directionUrl ="https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=AIzaSyD_C8wAXgGf5ir9Gw6nkN_A387I6lpRXeU";
    var res = await RequestAssistant.getRequest(directionUrl);
    if(res=="failed"){
      print("failed");
      return null;
    }

    DirectionDetails directionDetails = DirectionDetails();

    directionDetails.encodedPoints = res["route"][0]["overview_polyline"]["points"];
    directionDetails.distanceText = res["route"][0]["legs"][0]["distance"]["text"];
    directionDetails.distanceValue =res["route"][0]["legs"][0]["distance"]["value"];
    directionDetails.durationText = res["route"][0]["legs"][0]["duration"]["text"];
    directionDetails.durationValue =res["route"][0]["legs"][0]["duration"]["value"];
    distance = directionDetails.distanceValue;
    print(directionDetails.durationValue);
    return directionDetails;
  }
}