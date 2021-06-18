import 'package:fdg_web_admin/src/ui/products/product_unit.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fdg_web_admin/src/ui/products/editor/product_editor.dart';
import 'package:fdg_web_admin/src/fdg_products_locale_keys.dart';


class ProductUnitLocalization {
  static String convert(BuildContext context, ProductUnit productUnit) {
    switch (productUnit) {
      case ProductUnit.grams:
        return FDGProductsLocaleKeys.unitGrams.tr();
      case ProductUnit.milliliters:
        return FDGProductsLocaleKeys.unitMls.tr();
      case ProductUnit.liters:
        return FDGProductsLocaleKeys.unitLiters.tr();
      case ProductUnit.kilograms:
        return FDGProductsLocaleKeys.unitKilograms.tr();
    }
  }

  static String convertShorthand(BuildContext context, ProductUnit productUnit) {
    switch (productUnit) {
      case ProductUnit.grams:
        return FDGProductsLocaleKeys.unitGramsShort.tr();
      case ProductUnit.milliliters:
        return FDGProductsLocaleKeys.unitMlsShort.tr();
      case ProductUnit.liters:
        return FDGProductsLocaleKeys.unitLitersShort.tr();
      case ProductUnit.kilograms:
        return FDGProductsLocaleKeys.unitKilogramsShort.tr();
    }
  }
}
