// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:minoragain/models/Provider.dart';

class ChartAnalytics extends StatefulWidget {
  const ChartAnalytics({Key? key}) : super(key: key);

  @override
  _ChartAnalyticsState createState() => _ChartAnalyticsState();
}

class _ChartAnalyticsState extends State<ChartAnalytics> {
  bool _isLoading = true;

  void fetchAnalytics() async {
    await Provider.of<BList>(context, listen: false).fetchSourceAnalytics();
    await Provider.of<BList>(context, listen: false)
        .fetchDestinationAnalytics();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    fetchAnalytics();
    // TODO: implement initState

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pie Chart"),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Consumer<BList>(
          builder: (context, data, ch) {
            Map<String, double> _pieInfo = {};
            //print(data.dataDestinationMap);
            //print(data.dataSourceMap);
            data.dataSourceMap!.forEach((key, value) {
              double pval = value * 1.0;
              if (_pieInfo.containsKey(key)) {
                double ppval = _pieInfo[key]! * 1.0;
                ppval = ppval + pval;
                _pieInfo[key] = ppval;
              } else {
                _pieInfo[key] = pval;
              }
            });
            data.dataDestinationMap!.forEach((key, value) {
              double pval = value * 1.0;
              if (_pieInfo.containsKey(key)) {
                double ppval = _pieInfo[key]! * 1.0;
                ppval = ppval + pval;
                _pieInfo[key] = ppval;
              } else {
                _pieInfo[key] = pval;
              }
            });
            print(_pieInfo);
            return _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                    ),
                  )
                : PieChart(
                    dataMap: _pieInfo,
                    animationDuration: Duration(milliseconds: 800),
                    chartLegendSpacing: 32,
                    chartRadius: MediaQuery.of(context).size.width / 3.2,
                    //colorList: colorList,
                    initialAngleInDegree: 0,
                    chartType: ChartType.ring,
                    ringStrokeWidth: 32,
                    centerText: "HYBRID",
                    legendOptions: LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.right,
                      showLegends: true,
                      //legendShape: _BoxShape.circle,
                      legendTextStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    chartValuesOptions: ChartValuesOptions(
                      showChartValueBackground: true,
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                      showChartValuesOutside: false,
                      decimalPlaces: 1,
                    ),
                    // gradientList: ---To add gradient colors---
                    // emptyColorGradient: ---Empty Color gradient---
                  );
          },
        ),
      ),
    );
  }
}
