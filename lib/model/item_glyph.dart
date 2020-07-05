
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:search_object/model/glyph_model.dart';

class ItemGlyph extends StatelessWidget {

  final GlyphModel glyph;
  const ItemGlyph({ this.glyph});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      child: Slidable(
        actionPane: SlidableDrawerActionPane(),
        actionExtentRatio: 0.25,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(0.5, 0.5),
                  blurRadius: 6.0),
            ],
          ),
          padding: EdgeInsets.all(2.0),
          margin: EdgeInsets.only(left: 5.0, right: 5.0, top: 2.0, bottom: 3.0),
          child: ListTile(
              leading: Container(
                width: 40,
                height: 40,
                child: Icon(Icons.favorite ),
              ),
              title: Text(glyph.name,
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              subtitle: Text.rich(
                TextSpan(
                  text: 'Description: ', style: TextStyle(fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(text: glyph.description.split('.')[0], style: TextStyle(fontWeight: FontWeight.w400)),
                  ],
                ),
              ),
          ),
        ),
        actions: <Widget>[

          IconSlideAction(
            caption: 'Share',
            color: Colors.green,
            iconWidget: Icon(Icons.share, ),
            onTap: () async {
              //Share.share('Descarga la aplicación Ajaw: https://weareokan.com/project#asun', subject: 'Ajaw, hoy ${app.dayNumber} ${app.dayName}');
            },
          ),
        ],
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Code',
            color: Colors.red,
            iconWidget: Icon(Icons.code, ),
            onTap: () {
            },
          ),
        ],
      ),
      onTap: () {
        //print(glyph.toMap());
      },
    );
      
  }
}
