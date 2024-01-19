import 'package:get/get.dart';

class FormValidator {
  static final FormValidator _singleton = FormValidator._internal();

  factory FormValidator() {
    return _singleton;
  }

  FormValidator._internal();

  String? isValidName(String? text) {
    if (text == null || text.isEmpty || text.length < 3) {
      return "name_error".tr;
    }
    return null;
  }

  String? isValidEmail(String? text) {
    return (text ?? "").isEmail ? null : "email_error".tr;
  }

  String? isValidPass(String? text) {
    if (text == null || text.length < 6) {
      return "pass_error".tr;
    }
    return null;
  }

  String? isValidConfirmPass(String? text, String? pass) {
    if (text == null || text != pass) {
      return "confirm_pass_error".tr;
    }
    return null;
  }

  String? isValidTaskName(String? text) {
    if (text == null || text.trim().isEmpty || text.trim().length > 50) {
      return "task_name_error".tr;
    }
    return null;
  }

  String? isValidTaskDescription(String? text) {
    if (text == null || text.trim().isEmpty || text.trim().length > 250) {
      return "task_description_error".tr;
    }
    return null;
  }

  String? isValidComment(String? text) {
    if (text == null || text.trim().isEmpty || text.trim().length > 350) {
      return "comment_error".tr;
    }
    return null;
  }

  String? isValidTaskCheckListItem(String? text) {
    if (text == null || text.trim().isEmpty || text.trim().length > 50) {
      return "task_check_list_item_error".tr;
    }
    return null;
  }
}
