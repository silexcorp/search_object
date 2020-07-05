
import 'package:flutter/material.dart';
import 'package:search_object/model/glyph_model.dart';
import 'package:search_object/screen_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Search Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final items = <GlyphModel>[];

  GlyphModel glyph_one(){
    return GlyphModel(
      name: 'One',
      colors: "#808080,#FFFFFF,#000000",
      description: """The lowest cardinal number; half of two; 1.""",
    );
  }
  GlyphModel glyph_two(){
    return GlyphModel(
      name: 'Two',
      colors: "#808080,#FFFFFF,#000000",
      description: """Equivalent to the sum of one and one; one less than three; 2.""",
    );
  }
  GlyphModel glyph_three(){
    return GlyphModel(
      name: 'Three',
      colors: "#808080,#FFFFFF,#000000",
      description: """Equivalent to the sum of one and two; one more than two; 3.""",
    );
  }

  void _incrementCounter() {
    Navigator.push(context, MaterialPageRoute(builder: (context)=> ScreenSearch(glyphs: items,)));
  }


  @override
  Widget build(BuildContext context) {

    if(items.isEmpty){

      items.add(
          glyph_one()
      );
      items.add(
          glyph_two()
      );
      items.add(
          glyph_three()
      );

      for(int i = 0; i < items.length; i++) {
        final text = items[i].description
            + ' ' + items[i].name;
        var result = text.toLowerCase().replaceAll(new RegExp(r"[^\w+(áéíóúü)\s]+"), "");

        List<String> middle = result.split(" ");
        for(int x = 0; x < middle.length; x++){
          String ini = middle[x];
          for(int w = 1; w < ini.length; w++){
            result += ' ' + ini.substring(0,w);
          }
          result += ' ' + middle[x];
        }

        var distinctIds = result.split(" ").toSet().toList();
        items[i].nameLowercase = items[i].name.toLowerCase();
        items[i].tags = distinctIds;
      }
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: InkWell(
          onTap: () => _incrementCounter(),
          onLongPress: () {},
          child: Container(
            height: 250,
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(30)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 20.0,
                  offset: Offset(5.0, 10.0),
                ),
              ],
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage('assets/background.jpg',),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                  ),
                ),

                Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[

                      Icon(Icons.search, color: Colors.white, size: 60,),
                      SizedBox(height: 10.0,),
                      Text(
                        'Search',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
