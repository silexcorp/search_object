
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_object/input/field_search.dart';
import 'package:search_object/model/glyph_model.dart';
import 'package:search_object/widget/material_search.dart';

class ScreenSearch extends StatefulWidget {
  final List<GlyphModel> glyphs;
  const ScreenSearch({Key key, this.glyphs}) : super(key: key);
  @override
  _FragmentScreenTransactionState createState() => _FragmentScreenTransactionState();
}

class _FragmentScreenTransactionState extends State<ScreenSearch> with TickerProviderStateMixin {

  TabController _tabController;

  String search = ' ';
  int amountForms = 5;

  List<Widget> listViews = List<Widget>();
  var scrollController = ScrollController();
  double topBarOpacity = 0.0;

  final GlobalKey<FormState> _homeKey = new GlobalKey<FormState>();
  final TextEditingController _txtFormCodeCtrl = TextEditingController();


  @override
  void initState() {

    addAllListData();

    _txtFormCodeCtrl.addListener(() {
      try {
        if(this._homeKey.currentState != null){
          if(this._homeKey.currentState.validate()){
            _homeKey.currentState.save();
          }
          setState(() {
            if(_txtFormCodeCtrl.text != ''){
              search = _txtFormCodeCtrl.text.toLowerCase();
            }else{
              search = ' ';
            }
          });
        }
      } on Exception catch(e) { print('Err to valitate state key :(');}
    });


    _tabController = new TabController(vsync: this, length: amountForms, initialIndex: 0);

    scrollController.addListener(() {
      if (scrollController.offset >= 10) {
        if (topBarOpacity != 1.0) {
          setState(() {
            topBarOpacity = 1.0;
          });
        }
      } else if (scrollController.offset <= 10 &&
          scrollController.offset >= 0) {
        if (topBarOpacity != scrollController.offset / 10) {
          setState(() {
            topBarOpacity = scrollController.offset / 10;
          });
        }
      } else if (scrollController.offset <= 0) {
        if (topBarOpacity != 0.0) {
          setState(() {
            topBarOpacity = 0.0;
          });
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    listViews.add(
      SizedBox(),
    );
  }

  Future<bool> getData() async {
    await Future.delayed(const Duration(milliseconds: 10));
    return true;
  }

  @override
  Widget build(BuildContext context) {

    Widget getInput(){
      return Align(
          alignment: Alignment.topCenter,
          child: Form(
            autovalidate: true,
            key: _homeKey,
            child: Container(
              margin: EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5.0, top: 5.0),
              child: FieldSearch(
                controller: _txtFormCodeCtrl,
                context: context,
              ),
            ),
          )
      );
    }

    Widget getEmpty(){
      return Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                width: double.infinity,
                child: Text(
                  'Empty',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.black.withOpacity(0.7), fontWeight: FontWeight.w400),
                  maxLines: 1,
                ),
              ),
              SizedBox(height: 20,),
              Icon(Icons.search),
              SizedBox(height: 40,),
            ],
          )
      );
    }

    return Container(
      color: Colors.white.withOpacity(0.98),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: PreferredSize(
          preferredSize: Size(0.0, 124.0),
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 10.0,),
                getInput(),
                TabBar(
                  isScrollable: true,
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.white,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicator: new BubbleTabIndicator(
                    indicatorHeight: 28.0,
                    indicatorColor: Colors.black,
                    tabBarIndicatorSize: TabBarIndicatorSize.tab,
                  ),
                  tabs: [
                    new Tab(child: new Text("Name")),
                    new Tab(child: new Text("Tag")),
                    new Tab(child: new Text("Animal")),
                    new Tab(child: new Text("Color")),
                    new Tab(child: new Text("Element")),
                  ],
                  controller: _tabController,
                ),

              ],
            )
          ),
        ),
        body: TabBarView(
            controller: _tabController,
            children: [

              Stack(
                children: <Widget>[
                  (search == ' ' || search.isEmpty) ? getEmpty() : getContentName(),
                ],
              ),

              Stack(
                children: <Widget>[
                  (search == ' ' || search.isEmpty) ? getEmpty() : getContentTag(),
                ],
              ),

              Stack(
                children: <Widget>[
                  (search == ' ' || search.isEmpty) ? getEmpty() : getContentAnimal(),
                ],
              ),
              Stack(
                children: <Widget>[
                  (search == ' ' || search.isEmpty) ? getEmpty() : getContentColor(),
                ],
              ),
              Stack(
                children: <Widget>[
                  (search == ' ' || search.isEmpty) ? getEmpty() : getContentElement(),
                ],
              ),

            ]
        ),
      ),
    );
  }

  Widget getContentName() {
    return Align(
      alignment: Alignment.center,
      child: MaterialSearch<GlyphModel>(
        results: widget.glyphs.map(
                (GlyphModel v) => MaterialSearchResult<GlyphModel>( value: v, )
        ).toList(),
        filter: (GlyphModel value, GlyphModel criteria) {
          return value.name.toLowerCase().trim().contains(RegExp(r'' + criteria.name.toLowerCase().trim() + ''));
        },
        criteria: GlyphModel(name: search),
      ),
    );
  }
  Widget getContentTag() {
    return Align(
      alignment: Alignment.center,
      child: MaterialSearch<GlyphModel>(
        results: widget.glyphs.map(
                (GlyphModel v) => MaterialSearchResult<GlyphModel>( value: v, )
        ).toList(),
        filter: (GlyphModel value, GlyphModel criteria) {
          return value.tags.contains(criteria.name.toLowerCase());
        },
        criteria: GlyphModel(name: search),
      ),
    );
  }

  Widget getContentAnimal() {
    return Align(
      alignment: Alignment.center,
      child: Container()
    );
  }

  Widget getContentColor() {
    return Align(
      alignment: Alignment.center,
      child: Container()
    );
  }

  Widget getContentElement() {
    return Align(
      alignment: Alignment.center,
      child: Container()
    );
  }

}
