import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wofroho_mobile/molecules/text_with_image.dart';
import 'package:wofroho_mobile/organisms/button_pair.dart';
import 'package:wofroho_mobile/pages/details_page.dart';
import 'package:wofroho_mobile/pages/setup_page.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/padded_scroll_page_template.dart';

class AllSetUpPage extends StatefulWidget {
  @override
  _AllSetUpPageState createState() => _AllSetUpPageState();
}

class _AllSetUpPageState extends State<AllSetUpPage> {
  void _homePressed() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => DetailsPage(),
      ),
    );
  }

  void _beginSetup() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (ctx) => SetupPage(initialSetup: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PaddedScrollPageTemplate(
      pageWidgets: InputTemplate(
        pageWidgets: _showPageWidgets(),
        bottomWidget: _showBottomWidget(),
      ),
      background: _showBackground(),
    );
  }

  Widget _showPartyPopper() {
    return SvgPicture.asset(
      'assets/images/party_popper.svg',
      semanticsLabel: "Party popper",
      fit: BoxFit.contain,
      width: 50.0,
    );
  }

  Widget _showPageWidgets() {
    return Center(
      child: TextWithImage(
        text: 'All set up yeah',
        image: _showPartyPopper(),
      ),
    );
  }

  Widget _showBottomWidget() {
    return ButtonPair(
      primaryText: "Setup",
      primaryOnPressed: _beginSetup,
      secondaryText: "Home",
      secondaryOnPressed: _homePressed,
    );
  }

  Widget _showBackground() {
    return SvgPicture.asset(
      'assets/images/confetti.svg',
      semanticsLabel: "Success confetti",
      fit: BoxFit.cover,
    );
  }
}
