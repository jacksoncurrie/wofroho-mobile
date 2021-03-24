import 'package:flutter/material.dart';

class TabGroup extends StatelessWidget {
  TabGroup({
    required this.selectedTab,
    required this.tabTitles,
    required this.tabPages,
    required this.tabTapped,
  });

  final int? selectedTab;
  final List<Widget> tabTitles;
  final List<Widget> tabPages;
  final void Function(int) tabTapped;

  List<Widget> get getTabTitles => tabTitles
      .asMap()
      .entries
      .map((entry) => _showTabTitle(entry.key, entry.value))
      .toList();

  List<Widget> get getTabPages => tabPages
      .asMap()
      .entries
      .map((entry) => _showTabPage(entry.key, entry.value))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: getTabTitles,
          ),
        ),
        Expanded(
          child: Stack(
            children: getTabPages,
          ),
        ),
      ],
    );
  }

  Widget _showTabTitle(int titleNumber, Widget titleWidget) {
    return GestureDetector(
      onTap: () => tabTapped(titleNumber),
      child: AnimatedOpacity(
        duration: Duration(milliseconds: 200),
        opacity: selectedTab == titleNumber ? 1.0 : 0.5,
        child: titleWidget,
      ),
    );
  }

  Widget _showTabPage(int pageNumber, Widget pageWidget) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 200),
      opacity: selectedTab == pageNumber ? 1.0 : 0,
      child: IgnorePointer(
        ignoring: selectedTab != pageNumber,
        child: tabPages[pageNumber],
      ),
    );
  }
}
