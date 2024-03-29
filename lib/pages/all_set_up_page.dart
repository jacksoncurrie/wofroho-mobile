import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:wofroho_mobile/animations/fade_page_transition.dart';
import 'package:wofroho_mobile/atoms/heading_text.dart';
import 'package:wofroho_mobile/molecules/primary_button.dart';
import 'package:wofroho_mobile/molecules/text_with_image.dart';
import 'package:wofroho_mobile/pages/details_page.dart';
import 'package:wofroho_mobile/templates/input_template.dart';
import 'package:wofroho_mobile/templates/padded_scroll_page_template.dart';

class AllSetUpPage extends StatelessWidget {
  void _getStartedPressed(BuildContext context) {
    var nextPage = DetailsPage();
    Navigator.of(context).pushReplacement(
      FadePageTransition(child: nextPage),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PaddedScrollPageTemplate(
      pageWidgets: InputTemplate(
        pageWidgets: _showPageWidgets(),
        bottomWidget: _showBottomWidget(context),
      ),
      background: _showBackground(),
    );
  }

  Widget _showPartyPopper() {
    return SvgPicture.asset(
      'assets/images/party_popper.svg',
      semanticsLabel: "Party popper",
      fit: BoxFit.contain,
      width: 35,
    );
  }

  Widget _showPageWidgets() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _showHeadingText(),
          _showAllSetUpText(),
        ],
      ),
    );
  }

  Widget _showHeadingText() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: HeadingText(
        text: 'Request sent to organisation.',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _showAllSetUpText() {
    return TextWithImage(
      text: 'All set up, yeah!',
      image: _showPartyPopper() as SvgPicture,
    );
  }

  Widget _showBottomWidget(BuildContext context) {
    return PrimaryButton(
      text: 'Let\'s get started',
      onPressed: () => _getStartedPressed(context),
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
