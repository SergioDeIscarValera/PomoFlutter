import 'package:PomoFlutter/content/home/storage/controller/main_controller.dart';
import 'package:PomoFlutter/content/home/storage/controller/statistics_controller.dart';
import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/content/home/widgets/statistics/my_bar_chart.dart';
import 'package:PomoFlutter/content/home/widgets/statistics/my_pie_chart.dart';
import 'package:PomoFlutter/widgets/wrap_in_mid.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({
    Key? key,
    required this.mainController,
  }) : super(key: key);

  final MainController mainController;
  @override
  Widget build(BuildContext context) {
    StatisticsController statisticsController = Get.find();
    double staticPie = context.width < 900
        ? context.width < 350
            ? 350
            : 300
        : 350;
    return GenericTemplate(
      onIconTap: () {
        mainController.setPage(0);
      },
      title: "statics_title".tr,
      body: ListView(
        children: [
          //Today statistics
          GenericContainer(
            direction: Axis.vertical,
            children: [
              WrapInMid(
                flex: 3,
                otherFlex: context.width > 800 ? 1 : 0,
                child: Column(
                  children: [
                    Text(
                      "today_statistics".tr,
                      style: MyTextStyles.h2.textStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    if (statisticsController.todayDailyData.value != null)
                      SizedBox(
                        height: 250,
                        width: 250,
                        child: MyBarChart(
                          dailyData: [
                            statisticsController.todayDailyData.value!,
                          ].obs,
                          fontSize: 16,
                        ),
                      ),
                    const SizedBox(height: 20),
                    if (statisticsController.todayDailyData.value != null)
                      SizedBox(
                        height: staticPie,
                        child: MyPieChart(
                          dailyData: [
                            statisticsController.todayDailyData.value!,
                          ].obs,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          //Month statistics
          GenericContainer(
            direction: Axis.vertical,
            children: [
              WrapInMid(
                flex: 3,
                otherFlex: context.width > 800 ? 1 : 0,
                child: Column(
                  children: [
                    Text(
                      "month_statistics".tr,
                      style: MyTextStyles.h2.textStyle,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 250,
                      child: MyBarChart(
                        dailyData: statisticsController.monthDailyData,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: staticPie,
                      child: MyPieChart(
                        dailyData: statisticsController.monthDailyData,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}
