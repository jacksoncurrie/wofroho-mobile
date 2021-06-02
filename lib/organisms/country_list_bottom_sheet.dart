import 'package:flutter/material.dart';
import 'package:wofroho_mobile/models/country.dart';
import 'package:wofroho_mobile/molecules/country_list_view.dart';
import '../theme.dart';

void showCountryListBottomSheet({
  required BuildContext context,
  required ValueChanged<Country> onSelect,
  List<String>? exclude,
  List<String>? countryFilter,
  bool showPhoneCode = false,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) =>
        _builder(context, onSelect, exclude, countryFilter, showPhoneCode),
  );
}

Widget _builder(
  BuildContext context,
  ValueChanged<Country> onSelect,
  List<String>? exclude,
  List<String>? countryFilter,
  bool showPhoneCode,
) {
  final device = MediaQuery.of(context).size.height;
  final statusBarHeight = MediaQuery.of(context).padding.top;
  final height = device - (statusBarHeight + (kToolbarHeight / 1.5));
  Color backgroundColor = Theme.of(context).colorScheme.backgroundColor;

  return Container(
    height: height,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(15.0),
        topRight: Radius.circular(15.0),
      ),
    ),
    child: CountryListView(
      onSelect: onSelect,
      exclude: exclude,
      countryFilter: countryFilter,
      showPhoneCode: showPhoneCode,
    ),
  );
}
