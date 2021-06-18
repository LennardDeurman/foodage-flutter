import 'package:flutter/material.dart';

class ProductEditorValidation {

  static bool validateNumber(BuildContext context, String? value) {
    if (value != null) {
      final nutrient = double.tryParse(value) ?? int.tryParse(value)?.toDouble();
      if (nutrient != null) {
        return true;
      }
    }
    return false;
  }

  static bool validatePrice(BuildContext context, String? value) {
    return validateNumber(context, value);
  }

  static bool validateNutrient(BuildContext context, String? value) {
    return validateNumber(context, value);
  }

  static bool validateName(BuildContext context, String? value) {
    return value?.isNotEmpty ?? false;
  }

  static bool validateProductUrl(BuildContext context, String? value) {
    return value?.isNotEmpty ?? false;
  }

  static bool validateQuantityValue(BuildContext context, String? value) {
    return validateNumber(context, value);
  }


}
