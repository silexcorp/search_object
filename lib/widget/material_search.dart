
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:search_object/model/glyph_model.dart';
import 'package:search_object/model/item_glyph.dart';

typedef GlyphModel FormFieldFormatter<T>(T v);
typedef bool MaterialSearchFilter<T>(GlyphModel v, GlyphModel c);
typedef int MaterialSearchSort<T>(T a, T b, GlyphModel c);
typedef Future<List<MaterialSearchResult>> MaterialResultsFinder(GlyphModel c);
typedef void OnSubmit(GlyphModel value);

class MaterialSearchResult<T> extends StatelessWidget {
  const MaterialSearchResult({
    Key key,
    this.value,
  }) : super(key: key);

  final GlyphModel value;

  @override
  Widget build(BuildContext context) {
    return ItemGlyph(glyph: value,);
  }
}

class MaterialSearch<T> extends StatefulWidget {
  MaterialSearch({
    Key key,
    this.criteria,
    this.results,
    this.getResults,
    this.filter,
    this.sort,
    this.onSelect,
    this.onSubmit,
  }) : assert(() {
    if (results == null && getResults == null
        || results != null && getResults != null) {
      throw AssertionError('Either provide a function to get the results, or the results.');
    }

    return true;
  }()),
        super(key: key);

  final GlyphModel criteria;

  final List<MaterialSearchResult<T>> results;
  final MaterialResultsFinder getResults;
  final MaterialSearchFilter<T> filter;
  final MaterialSearchSort<T> sort;
  final ValueChanged<T> onSelect;
  final OnSubmit onSubmit;

  @override
  _MaterialSearchState<T> createState() => _MaterialSearchState<T>();
}

class _MaterialSearchState<T> extends State<MaterialSearch> {
  bool _loading = false;
  List<MaterialSearchResult<T>> _results = [];

  _filter(GlyphModel value, GlyphModel criteria) {
    return value.name.toLowerCase().trim().contains(RegExp(r'' + criteria.name.toLowerCase().trim() + ''));
  }

  @override
  void initState() {
    super.initState();

    if (widget.getResults != null) {
      _getResultsDebounced();
    }

  }

  Timer _resultsTimer;

  Future _getResultsDebounced() async {
    if (_results.length == 0) {
      setState(() {
        _loading = true;
      });
    }

    if (_resultsTimer != null && _resultsTimer.isActive) {
      _resultsTimer.cancel();
    }

    _resultsTimer = Timer(Duration(milliseconds: 400), () async {
      if (!mounted) {
        return;
      }

      setState(() {
        _loading = true;
      });

      //TODO: debounce widget.results too
      var results = await widget.getResults(widget.criteria);

      if (!mounted) {
        return;
      }

      setState(() {
        _loading = false;
        _results = results;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _resultsTimer?.cancel();
  }

  @override
  Widget build(BuildContext context) {

    var results = (widget.results ?? _results)
        .where((MaterialSearchResult result) {

      if (widget.filter != null) {
        return widget.filter(result.value, widget.criteria);
      }
      //only apply default filter if used the `results` option
      //because getResults may already have applied some filter if `filter` option was omited.
      else if (widget.results != null) {
        return _filter(result.value, widget.criteria);
      }
      return true;
    })
        .toList();

    return Scaffold(
      body: _loading
          ? Center(
          child: Container(
            width: 125.0,
            height: 125.0,
            child: CircularProgressIndicator()
          )
      )
          : SingleChildScrollView(
        child: Column(
          children: results.map((MaterialSearchResult result) {
            return InkWell(
              onTap: () => widget.onSelect(result.value),
              child: result,
            );
          }).toList(),
        ),
      ),
    );
  }
}