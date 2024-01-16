import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutMeSection extends StatelessWidget {
  const AboutMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'About Me',
              style: GoogleFonts.getFont('Roboto Mono',
                  fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            screenWidth < 600 // Conditional layout based on screen width
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildContent(),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildContent(),
                  ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildContent() {
    return [
      ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: SizedBox(
          width: 100,
          height: 100,
          child: Image.asset(
            'assets/about_me.jpeg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      const SizedBox(width: 20, height: 20),
      Wrap(
        alignment: WrapAlignment.start,
        direction: Axis.vertical,
        spacing: 20, // Horizontal space between widgets
        runSpacing: 20, // Vertical space between widgets
        children: [
          Text(
            "Hi there! I'm Kuba, a developer who by occasion has learned a bit about Agile. \n Please enjoy this little tool I've made.",
            style: GoogleFonts.getFont('Roboto Mono', fontSize: 16),
          ),
          Text(
            "When I'm not coding, you'll find me riding the bike.",
            style: GoogleFonts.getFont('Roboto Mono', fontSize: 16),
          ),
          _buildSocialLinks(),
        ],
      ),
    ];
  }

  Widget _buildSocialLinks() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialLinkButton(
          'https://www.linkedin.com/in/jakub-sumionka-52033b151/',
          'LinkedIn',
          Colors.blue,
        ),
        const SizedBox(width: 20),
        _buildSocialLinkButton(
          'https://www.strava.com/athletes/12091137',
          'Strava',
          Colors.orange,
        ),
      ],
    );
  }

  Widget _buildSocialLinkButton(String url, String text, Color color) {
    return InkWell(
      onTap: () async {
        final link = Uri.parse(url);
        if (await canLaunchUrl(link)) {
          await launchUrl(link);
        } else {
          throw 'Could not launch $url';
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          text,
          style: GoogleFonts.getFont('Roboto Mono', color: Colors.white),
        ),
      ),
    );
  }
}
