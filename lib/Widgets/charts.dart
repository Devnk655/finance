import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key}) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        child:SfCartesianChart(primaryXAxis: CategoryAxis(),
        series:<SplineSeries<SalesData,String>>[
           SplineSeries<SalesData,String>(
             color: Color.fromARGB(255, 47, 125, 121),
             width: 3 ,
             dataSource:<SalesData>[
              SalesData(100, "mon"),
               SalesData(20, "Tue"),
               SalesData(40, "wed"),
               SalesData(15, "sat"),
               SalesData(5, "sun"),
             ],
             xValueMapper:(SalesData sales,_)=>sales.year,
             yValueMapper:(SalesData sales,_)=>sales.sales,
           )
        ]
        ) ,
      ),
    );
  }
}
class SalesData{
  final String year;
  final int  sales;
  SalesData(this.sales, this.year);
}
