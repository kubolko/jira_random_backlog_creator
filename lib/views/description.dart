import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SelectableText(
              """🙄 Hey there. So, you've found your way to Jira Backlog Creator. Lucky you, or maybe not. We get it; dealing with Jira can be as exciting as watching paint dry. But hey, since you're here, let's make the best of it.
Here, we halfheartedly present our Jira Backlog Creator, because, well, somebody has to, right? Whether you're a Jira veteran or just trying to survive the corporate chaos, we've got some stuff here for you.""",
              style: GoogleFonts.getFont('Roboto Mono'),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(width: 16), // Adjust the spacing between texts
          Expanded(
            child: SelectableText(
              """Underwhelming Features: \n
🤯 Learn Jira... or Don't: Dive into the world of Jira if you must. Our guides will walk you through the mind-numbing details of different Jira versions. But let's be real, you're probably here because someone higher up said so.
🤔 Backlog Creation Made Marginally Easier: Our Jira Backlog Creator attempts to simplify the process. Will it make you love Jira? Unlikely. Will it save you a few minutes of your life? Maybe.
📖 Version-Specific Insights (Because Why Not?): Whether you're stuck with Jira Software, Jira Core, or Jira Service Management, we've gathered version-specific insights. Because, honestly, we needed something to fill this space.""",
              style: GoogleFonts.getFont('Roboto Mono'),
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: SelectableText(
              """Getting Started (If You Really Have To): \n
🧠 Select columns your doomed project will ignore anyway: Pick the ones no one cares about. Your team won't glance at them during the disaster.
🛠️ Feeling ambitious? Add or remove fields (hotfix? What hotfix?): Customize for excitement. I was supposed to work on that hotfix, but here we are.
🌐 Unspent energy? Try a feature request—I'll crush your dreams: Go to the project page, make a request, and brace for rejection. Good luck!""",
              style: GoogleFonts.getFont('Roboto Mono'),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }
}
