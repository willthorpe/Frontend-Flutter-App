import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_app/http/fetch.dart';

class GraphsPage extends StatefulWidget {
  GraphsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CreateGraphsPageState createState() => _CreateGraphsPageState();
}

class _CreateGraphsPageState extends State<GraphsPage> {
  final _scaffoldGraphsKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldGraphsKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
          future: fetchRecipeGraphData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data = [];
              for(var i = 0; i<snapshot.data.length; i++){
                data.add(new RecipeData(snapshot.data[i]['recipe'], snapshot.data[i]['amount']));
              }
              List<charts.Series<dynamic, String>> series = [
                charts.Series(
                    id: "Recipes",
                    data: data,
                    domainFn: (dynamic series, _) => series.recipe,
                    measureFn: (dynamic series, _) => series.amount,
                  labelAccessorFn: (dynamic series, _) => '${series.recipe}',
                )];

              return new Container(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    Text('Graph of Recipe Use in Calendars'),
                    Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: charts.PieChart(series, defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.auto,
                              outsideLabelStyleSpec: charts.TextStyleSpec(fontSize: 10),
                              insideLabelStyleSpec: charts.TextStyleSpec(fontSize: 10)
                              )
                        ]))
                    )
                  ],
                ),
              );

            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class RecipeData{
  final String recipe;
  final int amount;

  RecipeData(this.recipe, this.amount);
}
