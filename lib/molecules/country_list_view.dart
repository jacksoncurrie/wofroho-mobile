import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wofroho_mobile/atoms/data_field.dart';
import 'package:wofroho_mobile/atoms/text_input.dart';
import 'package:wofroho_mobile/models/country.dart';
import 'package:wofroho_mobile/utils/country_codes.dart';
import 'package:wofroho_mobile/utils/utils.dart';

class CountryListView extends StatefulWidget {
  /// Called when a country is select.
  ///
  /// The country picker passes the new value to the callback.
  final ValueChanged<Country> onSelect;

  /// An optional [showPhoneCode] argument can be used to show phone code.
  final bool showPhoneCode;

  /// An optional [exclude] argument can be used to exclude(remove) one ore more
  /// country from the countries list. It takes a list of country code(iso2).
  /// Note: Can't provide both [exclude] and [countryFilter]
  final List<String> exclude;

  /// An optional [countryFilter] argument can be used to filter the
  /// list of countries. It takes a list of country code(iso2).
  /// Note: Can't provide both [countryFilter] and [exclude]
  final List<String> countryFilter;

  const CountryListView({
    Key key,
    @required this.onSelect,
    this.exclude,
    this.countryFilter,
    this.showPhoneCode = false,
  })  : assert(onSelect != null),
        assert(exclude == null || countryFilter == null,
            'Cannot provide both exclude and countryFilter'),
        super(key: key);

  @override
  _CountryListViewState createState() => _CountryListViewState();
}

class _CountryListViewState extends State<CountryListView> {
  List<Country> _countryList;
  List<Country> _filteredList;
  TextEditingController _searchController;
  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    _countryList =
        countryCodes.map((country) => Country.from(json: country)).toList();

    if (widget.exclude != null) {
      _countryList.removeWhere(
          (element) => widget.exclude.contains(element.countryCode));
    }
    if (widget.countryFilter != null) {
      _countryList.removeWhere(
          (element) => !widget.countryFilter.contains(element.countryCode));
    }

    _filteredList = <Country>[];
    _filteredList.addAll(_countryList);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _showMinimiseIcon(),
        Padding(
          padding: const EdgeInsets.only(
            left: 14,
            right: 14,
            bottom: 20,
            top: 10,
          ),
          child: DataField(
            title: 'Search',
            child: TextInput(
              controller: _searchController,
              hintText: 'Search for your country',
              onChanged: _filterSearchResults,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children:
                _filteredList.map((country) => _listRow(country)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _showMinimiseIcon() {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: SvgPicture.asset(
        'assets/images/minimise.svg',
        semanticsLabel: "Minmise icon",
      ),
    );
  }

  Widget _listRow(Country country) {
    return Material(
      // Add Material Widget with transparent color
      // so the ripple effect of InkWell will show on tap
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          widget.onSelect(country);
          Navigator.pop(context);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: Row(
            children: <Widget>[
              const SizedBox(width: 20),
              Text(
                Utils.countryCodeToEmoji(country.countryCode),
                style: const TextStyle(fontSize: 25),
              ),
              if (widget.showPhoneCode) ...[
                const SizedBox(width: 15),
                Container(
                  width: 45,
                  child: Text(
                    '+${country.phoneCode}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 5),
              ] else
                const SizedBox(width: 15),
              Expanded(
                child: Text(
                  country.name,
                  style: const TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _filterSearchResults(String query) {
    List<Country> _searchResult = <Country>[];

    if (query.isEmpty) {
      _searchResult.addAll(_countryList);
    } else {
      _searchResult = _countryList.where((c) => c.startsWith(query)).toList();
    }

    setState(() => _filteredList = _searchResult);
  }
}
