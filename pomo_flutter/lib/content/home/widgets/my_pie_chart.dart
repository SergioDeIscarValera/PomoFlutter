import 'package:PomoFlutter/content/home/models/daily_data.dart';
import 'package:PomoFlutter/content/home/models/task_category.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyPieChart extends StatelessWidget {
  const MyPieChart({
    Key? key,
    required this.dailyData,
  }) : super(key: key);
  final RxList<DailyData> dailyData;

  @override
  Widget build(BuildContext context) {
    Map<TaskCategory, int> totalTimeMap = <TaskCategory, int>{};

    // Calcular la suma total de workingTime para cada TaskCategory
    for (var dailyData in dailyData) {
      for (var categoryTime in dailyData.categoryTimes.values) {
        totalTimeMap.update(
          categoryTime.category,
          (value) => value + (categoryTime.workingTime ~/ 60),
          ifAbsent: () => (categoryTime.workingTime ~/ 60),
        );
      }
    }
    double space = context.width < 350 ? 100 : 50;
    return Container(
      padding: EdgeInsets.only(bottom: space),
      child: Stack(
        alignment: Alignment.topCenter,
        clipBehavior: Clip.none,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 5,
              sections: totalTimeMap.entries
                  .map(
                    (e) => PieChartSectionData(
                      color: e.key.color,
                      value: e.value.toDouble(),
                      //title: e.key.name.tr,
                      title: "${e.value} min",
                      radius: 80,
                      titleStyle: MyTextStyles.p.textStyle.copyWith(
                        color: MyColors.LIGHT.color,
                        fontSize: context.width < 500 ? 14 : 16,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          // Legend
          Positioned(
            bottom: -space,
            right: 0,
            left: 0,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: totalTimeMap.entries
                  .map(
                    (e) => Container(
                      decoration: BoxDecoration(
                        color: e.key.color,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.all(5),
                      child: Text(
                        e.key.name.tr,
                        style: MyTextStyles.p.textStyle.copyWith(
                          color: MyColors.LIGHT.color,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          )
        ],
      ),
    );

    /*Wrap(
      children: [
        
        // Legend
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: totalTimeMap.entries
              .map(
                (e) => Container(
                  decoration: BoxDecoration(
                    color: e.key.color,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.all(5),
                  child: Text(
                    e.key.name.tr,
                    style: MyTextStyles.p.textStyle.copyWith(
                      color: MyColors.LIGHT.color,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );*/
  }
}
