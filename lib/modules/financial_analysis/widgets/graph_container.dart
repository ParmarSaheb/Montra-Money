import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:montra_clone/app/app_colors.dart';
import 'package:montra_clone/core/extensions/to_indian_rupee_extension.dart';
import 'package:montra_clone/core/utils/devlog.dart';
import 'package:montra_clone/modules/financial_analysis/model/chart_data_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class GraphContainer extends StatelessWidget {
  const GraphContainer({
    super.key,
    required this.dataList,
  });

  final List<ChartDataModel> dataList;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: 372,
      child: SfCartesianChart(
        margin: const EdgeInsets.all(0),
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat("dd-M \nhh:mm a"),
          intervalType: DateTimeIntervalType.auto,
          interval: 10,
          // isVisible: false,
          borderColor: Colors.transparent,
          borderWidth: 0,
          axisLabelFormatter: (axisLabelRenderArgs) {
            return ChartAxisLabel(axisLabelRenderArgs.text, TextStyle(fontSize: 9, fontWeight: FontWeight.w600));
          },
        ),

        primaryYAxis:  NumericAxis(
          // title: AxisTitle(text: 'Amount'),
          // isVisible: false,
          // maximum: 30000,
          axisLabelFormatter: (axisLabelRenderArgs) {
            return ChartAxisLabel(axisLabelRenderArgs.text.toIndianRupeeWith(decimalPoint: 0), TextStyle( fontWeight: FontWeight.w600));
          },
          borderWidth: 0,
          borderColor: Colors.transparent,
        ),

        series: [

          SplineAreaSeries<ChartDataModel, DateTime>(
            animationDuration: 500,
            xValueMapper: (model, _) => model.dateTime,
            yValueMapper: (model, _) => model.amount,
            dataSource: dataList,
            gradient: LinearGradient(
              colors: [
                AppColors.instance.violet40,
                AppColors.instance.violet20,
                AppColors.instance.light100,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderColor: AppColors.instance.primary,
            borderWidth: 5,
          )
        ],
      ),
    );
  }
}
