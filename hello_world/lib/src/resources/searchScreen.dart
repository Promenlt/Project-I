import 'package:flutter/material.dart';
import 'package:hello_world/src/Assistants/requestAssistant.dart';
import 'package:hello_world/src/model/address.dart';
import 'package:hello_world/src/model/placePrediction.dart';
import 'package:hello_world/src/resources/widgets/Divider.dart';
import 'package:provider/provider.dart';
import 'package:hello_world/src/DataHandler/appData.dart';
 class SearchScreen extends StatefulWidget{
  @override
  _SearchScreenState createState() => _SearchScreenState();
 }
 class _SearchScreenState extends State<SearchScreen>{
  TextEditingController pickUpTextEditingController = TextEditingController();
  TextEditingController dropOffTextEditingController = TextEditingController();
  List<PlacePredictions> placePredictionList = [];

   @override
  Widget build(BuildContext context) {
    // TODO: implement build
     String placeAddress = Provider.of<AppData>(context).pickUpLocation.placeName??"";
     pickUpTextEditingController.text = placeAddress;
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 215.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color:  Colors.black,
                  blurRadius:  6.0,
                  spreadRadius:  0.5,
                  offset: Offset(0.7,0.7,),
                ),
              ],
            ),
            child:Padding(
                padding: EdgeInsets.only(left:25.0, top:40.0, right:25.0, bottom: 20.0),
              child:Column(
                children: [
                  SizedBox(height:  5.0,),
                  Stack(
                    children: [
                      GestureDetector(
                          onTap:(){
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back)
                      ),
                      Center(
                        child: Text("Choice Your Direction", style: TextStyle(fontSize: 20.0, fontFamily: "Brand-Bold"),),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),

                  Row(
                    children:[
                      Image.asset("assets/ic_location_black.png", height: 16.0, width: 16.0, ),
                      SizedBox(width: 10.0,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                              padding: EdgeInsets.all(3.0),
                              child: TextField(

                                controller: pickUpTextEditingController,
                                decoration: InputDecoration(
                                  hintText: "PickUp Location",
                                  fillColor: Colors. grey,
                                  filled: true,
                                  border: InputBorder.none,
                                  isDense: true,
                                  contentPadding: EdgeInsets.only(left:11.0,top:8.0, bottom:8.0),
                                ),
                              ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0),

                  Row(
                    children:[
                      Image.asset("assets/ic_location_black.png", height: 16.0, width: 16.0, ),
                      SizedBox(width: 10.0,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(3.0),
                            child: TextField(
                              onChanged: (val){
                                findPlace(val);
                              },
                              controller: dropOffTextEditingController,
                              decoration: InputDecoration(
                                hintText: "Where to?",
                                fillColor: Colors. grey,
                                filled: true,
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.only(left:11.0,top:8.0, bottom:8.0),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          //title for prediction

            (placePredictionList.length>0)
              ?Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0 ),
            child: ListView.separated(
                padding:  EdgeInsets.all(0.0),
                itemBuilder: (context, index){
                  return PredictionTile(placePredictions: placePredictionList[index],);
                },
                separatorBuilder: (BuildContext context, int index)=>DividerWidget(),
                itemCount: placePredictionList.length,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
            ),
          )
              : Container(),
        ],
      ),
    );
  }

 void findPlace(String placeName) async{
     if(placeName.length > 1)
       {
         String autoCompleteUrl ="https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$placeName&key=AIzaSyD_C8wAXgGf5ir9Gw6nkN_A387I6lpRXeU&sessiontoken=1234567890&components=country:VN";
         var res = await RequestAssistant.getRequest(autoCompleteUrl);
         if(res=="failed"){
           return;
         }
         if(res["status"]=="OK"){
           var predictions = res["predictions"];
           var placeList =(predictions as List).map((e) => PlacePredictions.fromJson(e)).toList();
           setState(() {
             placePredictionList = placeList;
           });

         }
       }
 }
 }
 class PredictionTile extends StatelessWidget{
  final PlacePredictions placePredictions;
   PredictionTile({Key key,this.placePredictions}) : super(key:key);
   @override
  Widget build(BuildContext context) {
    return FlatButton(
      padding: EdgeInsets.all(0.0),
      onPressed: (){
        getPlaceAddressDetails(placePredictions.place_id, context);
      },
      child: Container(
        child:Column(
          children:[
            SizedBox(width: 10.0,),
            Row(
            children:[
              Icon(Icons.add_location),
              SizedBox(width: 14.0,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(placePredictions.main_text,overflow: TextOverflow.ellipsis,style:TextStyle(fontSize: 16.0),),
                    SizedBox(height: 3.0,),
                    Text(placePredictions.secondary_text,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 12.0, color: Colors.grey),),

                  ],
                ),
              ),
            ],
          ),
            SizedBox(width: 10.0,),
        ],
        ),

      ),
    );
  }
  void getPlaceAddressDetails(String placeId, context) async{

     String placeDetailsUrl="https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&key=AIzaSyD_C8wAXgGf5ir9Gw6nkN_A387I6lpRXeU";
    var res = await RequestAssistant.getRequest(placeDetailsUrl);

    if(res == "failed"){
      return;
    }
    if(res["status"] == "OK"){
      Address address =Address();
      address.placeName = res["result"]["name"];
      address.placeId = placeId;
      address.latitude = res["result"]["geometry"]["location"]["lat"];
      address.longitude = res["result"]["geometry"]["location"]["lng"];

      Provider.of<AppData>(context, listen: false).updateDropOffLocationAddress(address);
      print("This is drop location"+address.placeName);

      Navigator.pop(context, "obtainDirection");
    }
   }
 }
