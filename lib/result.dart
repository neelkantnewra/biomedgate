import 'package:biomedgate/customadmob.dart';
import 'package:biomedgate/home.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_admob/firebase_admob.dart';

const String testdevices = 'Mobile_id';

class Result extends StatefulWidget {
  final int marks;
  Result({Key key, @required this.marks}) : super(key: key);
  @override
  _ResultState createState() => _ResultState(marks);
}

class _ResultState extends State<Result> {
  List<String> images = [
    "images/winner.png",
    "images/goodluck.jpeg",
    "images/workhard.jpeg",
  ];
  String message;
  String image;

  //ads
  CustomAdmob myCustomAdmob = CustomAdmob();
  @override
  void initState() {
    if (marks < 10) {
      image = images[2];
      message = "You should Work hard \n You have scored $marks marks";
    } else if (marks < 20) {
      image = images[1];
      message = "You can do better \n You have scored $marks marks";
    } else {
      image = images[0];
      message = "Excellent work \n You have scored $marks marks";
    }

    super.initState();
  }

  showinterstitialAd() {
    myCustomAdmob.interstitialAd()
      ..load()
      ..show(
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
  }

  // showBannerAd() {
  //   myCustomAdmob.bannerAd()
  //     // typically this happens well before the ad is shown
  //     ..load()
  //     ..show(
  //       // Positions the banner ad 60 pixels from the bottom of the screen
  //       // anchorOffset: 60.0,
  //       // Positions the banner ad 10 pixels from the center of the screen to the right
  //       horizontalCenterOffset: 10.0,
  //       // Banner Position
  //       anchorType: AnchorType.bottom,
  //     );
  // }

  int marks;
  _ResultState(this.marks);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Result",
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Material(
              elevation: 10.0,
              child: Container(
                  child: Column(
                children: <Widget>[
                  Material(
                    child: Container(
                      width: 300.0,
                      height: 300.0,
                      child: ClipRect(
                        child: Image(
                          image: AssetImage(image),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 5.0,
                      horizontal: 15.0,
                    ),
                    child: Center(
                      child: Text(
                        message,
                        style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                  )
                ],
              )),
            ),
          ),
          Expanded(
            flex: 4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                OutlineButton(
                  child: Text(
                    "Continue",
                    style: TextStyle(color: Colors.indigo, fontSize: 20.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  borderSide: BorderSide(width: 3.0, color: Colors.indigo),
                  onPressed: () {
                    showinterstitialAd();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Home(),
                    ));
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
