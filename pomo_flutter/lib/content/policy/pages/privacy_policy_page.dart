import 'package:PomoFlutter/content/home/widgets/generic_template.dart';
import 'package:PomoFlutter/themes/colors.dart';
import 'package:PomoFlutter/themes/styles/my_text_styles.dart';
import 'package:PomoFlutter/widgets/generic_container.dart';
import 'package:PomoFlutter/widgets/responsive_layout.dart';
import 'package:PomoFlutter/widgets/row_divider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.CURRENT.color,
      body: SafeArea(
        child: ResponsiveLayout(
          mobile: const PrivacyPolicyBody(),
          tablet: const PrivacyPolicyBody(),
          desktop: RowDivider(
            bgColor: MyColors.PRIMARY.color,
            child: const PrivacyPolicyBody(),
          ),
        ),
      ),
    );
  }
}

class PrivacyPolicyBody extends StatelessWidget {
  const PrivacyPolicyBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GenericTemplate(
      onIconTap: () {
        Get.back();
      },
      title: "privacy_policy".tr,
      body: ListView(
        children: [
          //Información del sitio web
          GenericContainer(
            direction: Axis.vertical,
            children: [
              Text(
                "privacy_policy_info_title".tr,
                style: MyTextStyles.h2.textStyle.copyWith(
                  color: MyColors.CONTRARY.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text("privacy_policy_info_body".tr,
                  style: MyTextStyles.p.textStyle),
            ],
          ),
          const SizedBox(height: 40),
          //Tipo de datos recopilados
          GenericContainer(
            direction: Axis.vertical,
            children: [
              Text(
                "privacy_policy_data_title".tr,
                style: MyTextStyles.h2.textStyle.copyWith(
                  color: MyColors.CONTRARY.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text("privacy_policy_data_body".tr,
                  style: MyTextStyles.p.textStyle),
            ],
          ),
          const SizedBox(height: 40),
          //Finalidad de la recopilación
          GenericContainer(
            direction: Axis.vertical,
            children: [
              Text(
                "privacy_policy_purpose_title".tr,
                style: MyTextStyles.h2.textStyle.copyWith(
                  color: MyColors.CONTRARY.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text("privacy_policy_purpose_body".tr,
                  style: MyTextStyles.p.textStyle),
            ],
          ),
          const SizedBox(height: 40),
          //Terceros
          GenericContainer(
            direction: Axis.vertical,
            children: [
              Text(
                "privacy_policy_third_title".tr,
                style: MyTextStyles.h2.textStyle.copyWith(
                  color: MyColors.CONTRARY.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text("privacy_policy_third_body".tr,
                  style: MyTextStyles.p.textStyle),
            ],
          ),
          const SizedBox(height: 40),
          //Seguridad de los datos
          GenericContainer(
            direction: Axis.vertical,
            children: [
              Text(
                "privacy_policy_security_title".tr,
                style: MyTextStyles.h2.textStyle.copyWith(
                  color: MyColors.CONTRARY.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text("privacy_policy_security_body".tr,
                  style: MyTextStyles.p.textStyle),
            ],
          ),
          const SizedBox(height: 40),
          //Derechos del usuario
          GenericContainer(
            direction: Axis.vertical,
            children: [
              Text(
                "privacy_policy_rights_title".tr,
                style: MyTextStyles.h2.textStyle.copyWith(
                  color: MyColors.CONTRARY.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text("privacy_policy_rights_body".tr,
                  style: MyTextStyles.p.textStyle),
            ],
          ),
          const SizedBox(height: 40),
          //Actualizaciones en la política
          GenericContainer(
            direction: Axis.vertical,
            children: [
              Text(
                "privacy_policy_updates_title".tr,
                style: MyTextStyles.h2.textStyle.copyWith(
                  color: MyColors.CONTRARY.color,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text("privacy_policy_updates_body".tr,
                  style: MyTextStyles.p.textStyle),
            ],
          ),
        ],
      ),
    );
  }
}
