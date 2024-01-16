import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FakerSelector extends StatefulWidget {
  final String fakerMode;
  final Function(String) onFakerModeChanged;

  const FakerSelector({
    super.key,
    required this.fakerMode,
    required this.onFakerModeChanged,
  });

  @override
  _FakerSelectorState createState() => _FakerSelectorState();
}

class _FakerSelectorState extends State<FakerSelector> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("How to create the elements?"),
        SizedBox(
          height: 110,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            //TODO: add random dates
            children: <Widget>[
              ChoiceCard(
                icon: '🈳',
                label: 'word',
                isSelected: widget.fakerMode == 'word',
                onTap: () {
                  setState(() {
                    widget.onFakerModeChanged('word');
                  });
                },
              ),
              ChoiceCard(
                icon: '🖊️',
                label: 'sentence',
                isSelected: widget.fakerMode == 'sentence',
                onTap: () {
                  setState(() {
                    widget.onFakerModeChanged('sentence');
                  });
                },
              ),
              ChoiceCard(
                icon: '📕',
                label: 'follow \n user story format',
                isSelected: widget.fakerMode == 'user_story',
                onTap: () {
                  setState(() {
                    widget.onFakerModeChanged('user_story');
                  });
                },
              ),
              ChoiceCard(
                icon: '💯',
                label: 'number',
                isSelected: widget.fakerMode == 'number',
                onTap: () {
                  setState(() {
                    widget.onFakerModeChanged('number');
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ChoiceCard extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const ChoiceCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? const Color(0xff03045E) : Colors.transparent,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(10.0), // Set border radius here
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              icon,
              style: GoogleFonts.merienda(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4.0),
            Text(
              label,
              style: GoogleFonts.merienda(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
