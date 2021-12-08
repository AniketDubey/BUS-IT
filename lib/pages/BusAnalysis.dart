// ignore_for_file: file_names, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:minoragain/models/Provider.dart';

class BusAnalysis extends StatefulWidget {
  const BusAnalysis({Key? key}) : super(key: key);

  @override
  _BusAnalysisState createState() => _BusAnalysisState();
}

class _BusAnalysisState extends State<BusAnalysis> {
  bool _isLoading = true;

  void fetchAnalytics() async {
    await Provider.of<BList>(context, listen: false).busAnalyticsData();
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      _isLoading = false;
    });
  }

  void initState() {
    fetchAnalytics();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Consumer<BList>(
          builder: (context, data, ch) {
            Map<String, double> _pieInfo = {};
            //print(data.dataDestinationMap);
            //print(data.dataSourceMap);
            data.dataBusMap!.forEach((key, value) {
              double pval = value * 1.0;
              if (_pieInfo.containsKey(key)) {
                double ppval = _pieInfo[key]! * 1.0;
                ppval = ppval + pval;
                _pieInfo[key] = ppval;
              } else {
                _pieInfo[key] = pval;
              }
            });
            //print(_pieInfo);
            return _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 6,
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 25,
                        ),
                        PieChart(
                          centerText: "Bus \nDensity Graph",
                          centerTextStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                          dataMap: _pieInfo,
                          animationDuration: Duration(milliseconds: 800),
                          chartLegendSpacing: 32,
                          chartRadius: MediaQuery.of(context).size.width / 1.19,
                          //colorList: colorList,
                          initialAngleInDegree: 0,
                          chartType: ChartType.ring,
                          ringStrokeWidth: 32,
                          legendOptions: LegendOptions(
                            showLegendsInRow: true,
                            legendPosition: LegendPosition.bottom,
                            showLegends: true,
                            //legendShape: _BoxShape.circle,
                            legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          chartValuesOptions: ChartValuesOptions(
                            showChartValueBackground: true,
                            showChartValues: true,
                            showChartValuesInPercentage: true,
                            showChartValuesOutside: false,
                            decimalPlaces: 1,
                          ),
                          // gradientList: ---To add gradient colors---
                          // emptyColorGradient: ---Empty Color gradient---
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
