import 'package:PomoFlutter/content/home/models/daily_data.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/content/home/utils/daily_data_utils.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyBarChart extends StatelessWidget {
  const MyBarChart({
    super.key,
    required this.dailyData,
    this.fontSize,
  });

  final RxList<DailyData> dailyData;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    double max = DailyDataUtils.getMaxFromList(dailyData);
    double temFontSize = context.width < 500
        ? 8
        : context.width < 1100
            ? 12
            : 16;
    return Container(
      padding: const EdgeInsets.only(bottom: 50),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Obx(
            () => BarChart(
              BarChartData(
                maxY: max,
                minY: 0,
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, titleMeta) => Text(
                        value.toInt().toString(),
                        style: MyTextStyles.p.textStyle.copyWith(
                          fontSize: fontSize ?? temFontSize,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, titleMeta) => Text(
                        value.toInt().toString(),
                        style: MyTextStyles.p.textStyle.copyWith(
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border(
                    bottom: BorderSide(
                      color: MyColors.CONTRARY.color,
                      width: 2,
                    ),
                    left: BorderSide(
                      color: MyColors.CONTRARY.color,
                      width: 2,
                    ),
                  ),
                ),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: MyColors.CONTRARY.color,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        "${rod.toY.toInt()} min",
                        MyTextStyles.p.textStyle.copyWith(
                          color: MyColors.CURRENT.color,
                        ),
                        textAlign: TextAlign.center,
                      );
                    },
                  ),
                ),
                barGroups: dailyData
                    .map(
                      (daily) => BarChartGroupData(
                        x: daily.date.day,
                        barRods: [
                          BarChartRodData(
                            toY: daily.categoryTimes.values
                                .map((e) => (e.workingTime ~/ 60).toDouble())
                                .reduce((value, element) => value + element),
                            color: MyColors.SUCCESS.color,
                            width: dailyData.length < 20 ? 15 : 5,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(24),
                              topRight: Radius.circular(24),
                            ),
                          ),
                          if (context.width > 380 || dailyData.length == 1)
                            BarChartRodData(
                              toY: daily.categoryTimes.values
                                  .map((e) => (e.breakingTime ~/ 60).toDouble())
                                  .reduce((value, element) => value + element),
                              color: MyColors.INFO.color,
                              width: dailyData.length < 20 ? 15 : 5,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(24),
                                topRight: Radius.circular(24),
                              ),
                            ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          // Legend
          Positioned(
            bottom: -50,
            right: 0,
            left: 0,
            child: Wrap(alignment: WrapAlignment.center, children: [
              Container(
                decoration: BoxDecoration(
                  color: MyColors.SUCCESS.color,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(5),
                child: Text(
                  TaskCategory.work.name.tr,
                  style: MyTextStyles.p.textStyle.copyWith(
                    color: MyColors.LIGHT.color,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: MyColors.INFO.color,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: const EdgeInsets.all(5),
                margin: const EdgeInsets.all(5),
                child: Text(
                  "break".tr,
                  style: MyTextStyles.p.textStyle.copyWith(
                    color: MyColors.LIGHT.color,
                  ),
                ),
              ),
            ]),
          )
        ],
      ),
    );
  }
}
