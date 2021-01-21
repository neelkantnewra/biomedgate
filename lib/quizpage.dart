import 'dart:async';

import 'package:biomedgate/result.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

import 'customadmob.dart';

class Getjson extends StatelessWidget {
  String testseries;
  Getjson(this.testseries);
  String assettoload;
  setasset() {
    if (testseries == "Series and Pattern") {
      assettoload = "assets/arithmetic/Series_and_Pattern.json";
    } else if (testseries == "Number System") {
      assettoload = "assets/arithmetic/Number_system.json";
    } else if (testseries == "Instrumentation") {
      assettoload = "assets/Biomedical_Instrumentation/test1.json";
    }
  }

  @override
  Widget build(BuildContext context) {
    setasset();
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(assettoload, cache: false),
      builder: (context, snapshot) {
        List mydata = json.decode(snapshot.data.toString());
        if (mydata == null) {
          return Scaffold(
            body: Center(
              child: Text("Loading..."),
            ),
          );
        } else {
          return Quiz(mydata: mydata);
        }
      },
    );
  }
}

class Quiz extends StatefulWidget {
  final mydata;

  Quiz({Key key, @required this.mydata}) : super(key: key);
  @override
  _QuizState createState() => _QuizState(mydata);
}

class _QuizState extends State<Quiz> {
  var mydata;
  _QuizState(this.mydata);
  int marks = 0;
  Color colortoshow = Colors.indigo;
  Color right = Colors.green;
  Color wrong = Colors.red[800];
  int i = 1;
  bool disableAnswer = false;
  int j = 1;

  CustomAdmob myCustomAdmob = CustomAdmob();
  // int timer = 30;
  // String showtimer = "30";
  Map<String, Color> btncolor = {
    "a": Colors.indigo,
    "b": Colors.indigo,
    "c": Colors.indigo,
    "d": Colors.indigo,
  };
  // bool canceltimer = false;

  //Timer

  // @override
  // void initState() {
  //   starttimer();
  //   super.initState();
  // }

  // void starttimer() async {
  //   const onesec = Duration(seconds: 1);
  //   Timer.periodic(onesec, (Timer t) {
  //     setState(() {
  //       if (timer < 1) {
  //         t.cancel();
  //         nextQuestion();
  //       } else if (canceltimer == true) {
  //         t.cancel();
  //       } else {
  //         timer = timer - 1;
  //       }
  //       showtimer = timer.toString();
  //     });
  //   });
  // }

  showinterstitialAd() {
    myCustomAdmob.interstitialAd()
      ..load()
      ..show(
        anchorOffset: 0.0,
        horizontalCenterOffset: 0.0,
      );
  }

  //Next Question

  void nextQuestion() {
    // canceltimer = false;
    // timer = 30;
    setState(() {
      if (i < 10) {
        i++;
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Result(marks: marks)));
      }
      btncolor["a"] = Colors.indigo;
      btncolor["b"] = Colors.indigo;
      btncolor["c"] = Colors.indigo;
      btncolor["d"] = Colors.indigo;
      disableAnswer = false;
    });
    // starttimer();
  }

  //Marks Alloted

  void checkAnswer(String k) {
    if (mydata[2][i.toString()] == mydata[1][i.toString()][k]) {
      marks = marks + 4;
      colortoshow = right;
    } else {
      marks = marks - 1;
      colortoshow = wrong;
    }
    setState(() {
      btncolor[k] = colortoshow;
      // canceltimer = true;
      disableAnswer = true;
    });
    Timer(Duration(seconds: 1), nextQuestion);
  }

  Widget choice(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      child: MaterialButton(
        onPressed: () => checkAnswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          style: TextStyle(color: Colors.white, fontSize: 16.0),
          maxLines: 2,
        ),
        splashColor: Colors.indigo[700],
        highlightColor: Colors.indigo[800],
        color: btncolor[k],
        minWidth: 300.0,
        height: 55.0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      ),
    );
  }

  //Back key alert warning

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Biomedical Quiz"),
                  content: Text("You can't go back during the Test"),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          showinterstitialAd();
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          "OK",
                        ))
                  ],
                ));
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15.0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  mydata[0][i.toString()],
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
              ),
              flex: 3,
            ),
            Expanded(
                child: AbsorbPointer(
                  absorbing: disableAnswer,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        choice('a'),
                        choice('b'),
                        choice('c'),
                        choice('d'),
                      ],
                    ),
                  ),
                ),
                flex: 6),
            Expanded(
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                    child: OutlineButton(
                  child: Text(
                    "Skip",
                    style: TextStyle(color: Colors.indigo, fontSize: 20.0),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                  borderSide: BorderSide(width: 1.0, color: Colors.indigo),
                  onPressed: () {
                    nextQuestion();
                  },
                )
                    // child: Text(
                    //   // showtimer,
                    //   style:
                    //       TextStyle(fontSize: 35.0, fontWeight: FontWeight.w700),
                    // ),
                    ),
              ),
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
