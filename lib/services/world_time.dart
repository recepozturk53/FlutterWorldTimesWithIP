import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';


 class WorldTime{
   String location; // location name for the uı
   late String time; // the time in that location
   String flag; // url to an asset flag icon
   String url; // location url for api endpoint
   late bool isDaytime; // true or false if daytime or not

  WorldTime({required this.location,required this.flag,required this.url});
  //WorldTime.empty();

  /*Future<void> getTime() async {

    try{
      //make the request
      Response response= await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data=jsonDecode(response.body);

      //get properties from data
      String datetime=data['datetime'];
      String offset=data['utc_offset'].substring(1,3);


      //create DateTime object
      DateTime now =DateTime.parse(datetime);
      now=now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDaytime=now.hour>6 && now.hour<19 ? true : false;
      time = DateFormat.jm().format(now);
    }catch(e){
      print('caught error :$e');
      time='could not get time data';
    }


  }*/
   Future<void> getTimeByIp() async {

     try {
       Response response = await get(Uri.parse('http://worldtimeapi.org/api/ip'));
       _parseData(response);

     } catch (error) {
       print('error: $error');
       time = "Service down...";
     }

   }

   Future<String> getTimeByCity() async {

     try {
       Response response= await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
       _parseData(response);
     } catch (error) {
       print('error: $error');
       time = "Service down...";
     }

     return time;
   }

   void _parseData(Response response) {

     Map data = jsonDecode(response.body);

     //print(data);

     // find the location for initial loading
     if (location == null || location == "") {
       String timezone = data['timezone'];
       location = timezone.substring(timezone.lastIndexOf('/') + 1);
     }

     String datetime = data['utc_datetime'];
     int offset = int.parse(data['utc_offset'].substring(0, 3));

     DateTime now = DateTime.parse(datetime);
     now = now.add(Duration(hours: offset));

     isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
     time = DateFormat.jm().format(now);

   }

}

