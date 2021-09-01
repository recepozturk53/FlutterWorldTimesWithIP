import 'package:flutter/material.dart';
import 'package:worldtimeapp/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';



class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {




  void setupWorldTime() async {

     WorldTime instance=WorldTime(location:'',flag: '',url: '');

    await instance.getTimeByIp();
    await Future.delayed(Duration(seconds: 1), () {
      //print('Waited 1 seconds... done');
    });

      Navigator.pushReplacementNamed(context, '/home',arguments: {
        'location':instance.location,
        'flag':instance.flag,
        'time':instance.time,

        'isDaytime':instance.isDaytime,
      });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[900],
      body: Center(
        child: SpinKitCubeGrid(
          color:Colors.white,
          size:50.0,
      ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }
}
