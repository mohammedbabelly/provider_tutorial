import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_sample/API/dummyData.dart';
import 'package:provider_sample/Provider/fontSize.dart';
import 'package:provider_sample/Provider/rate.dart';

void main() {
  runApp(MaterialApp(
    home: MainPage(),
    theme: ThemeData(
      textTheme: TextTheme(
        bodyText1: TextStyle(),
        bodyText2: TextStyle(),
      ).apply(
        bodyColor: Colors.white30,
        displayColor: Colors.white30,
      ),
    ),
  ));
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => RateNotifier(),
        ),
        ChangeNotifierProvider(
          create: (BuildContext context) => FontSizeNotifier(),
        )
      ],
      child: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    var fontSizeProvider =
        Provider.of<FontSizeNotifier>(context, listen: false);
    var rateProvider = Provider.of<RateNotifier>(context, listen: false);
    print('the build tree has been rebuild!!');

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black38,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(top: 10, bottom: 5),
                child: Text('Data from API')),
            FutureBuilder(
                future: DummyData.getData(),
                builder: (context, snapshot) {
                  return Center(
                      child: snapshot.connectionState == ConnectionState.done
                          ? Text(
                              snapshot.data.toString(),
                              style: TextStyle(color: Colors.red),
                            )
                          : CircularProgressIndicator());
                }),
            SizedBox(
              height: 277,
            ),
            Selector<FontSizeNotifier, double>(
                selector: (context, fontize1) => fontize1.getFontize1,
                builder: (context, fontize, widget) {
                  print('Hi from font size 1 consumer!');
                  return Text(
                    'Text 1',
                    style: TextStyle(
                      fontSize: fontize,
                    ),
                  );
                }),
            SizedBox(
              height: 33,
            ),
            Selector<FontSizeNotifier, double>(
                selector: (context, fontiSize2) => fontiSize2.getFontize2,
                builder: (context, fontSize, widget) {
                  print('Hi from font size 2 consumer!');
                  return Text(
                    'Text 2',
                    style: TextStyle(
                      fontSize: fontSize,
                    ),
                  );
                }),
            SizedBox(
              height: 33,
            ),
            Expanded(child: Container()),
            Text('change the text1 size'),
            Consumer<FontSizeNotifier>(
                builder: (context, fontizeNotifier, widget) {
              return Slider(
                value: fontizeNotifier.fontSize1,
                onChanged: (newValue) {
                  fontizeNotifier.changeFontSize1(newValue);
                },
                max: 50,
                min: 20,
              );
            }),
            Text('change the text2 size'),
            Consumer<FontSizeNotifier>(
                builder: (context, fontizeNotifier, widget) {
              return Slider(
                value: fontizeNotifier.fontSize2,
                onChanged: (newValue) {
                  fontizeNotifier.changeFontSize2(newValue);
                },
                max: 50,
                min: 20,
              );
            }),
            SizedBox(
              height: 44,
            ),
          ],
        ),
      ),
    );
  }

  getFaces(int index) {
    switch (index) {
      case 0:
        return Icon(
          Icons.sentiment_very_dissatisfied,
          size: 60,
          color: Colors.red,
        );
      case 1:
        return Icon(
          Icons.sentiment_dissatisfied,
          size: 60,
          color: Colors.redAccent,
        );
      case 2:
        return Icon(
          Icons.sentiment_neutral,
          size: 60,
          color: Colors.amber,
        );
      case 3:
        return Icon(
          Icons.sentiment_satisfied,
          size: 60,
          color: Colors.lightGreen,
        );
      case 4:
        return Icon(
          Icons.sentiment_very_satisfied,
          size: 33,
          color: Colors.green,
        );
    }
  }
}
