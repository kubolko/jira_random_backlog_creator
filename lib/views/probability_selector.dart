import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProbabilitySelector extends StatefulWidget {
  final String fieldsMode;
  final Function(String) onProbabilityModeChanged;

  const ProbabilitySelector({
    super.key,
    required this.fieldsMode,
    required this.onProbabilityModeChanged,
  });

  @override
  _ProbabilitySelectorState createState() => _ProbabilitySelectorState();
}

class _ProbabilitySelectorState extends State<ProbabilitySelector> {
  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("Current fieldsMode: ${widget.fieldsMode}");
    }
    return Column(
      children: [
        const Text("How to select the elements?"),
        SizedBox(
          height: 110,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              ChoiceCard(
                icon: '🗿',
                label: 'even',
                isSelected: widget.fieldsMode == 'even',
                onTap: () => widget.onProbabilityModeChanged('even'),
              ),
              ChoiceCard(
                icon: '🙏',
                label: 'normal \n (gaussian)',
                isSelected: widget.fieldsMode == 'normal',
                onTap: () {
                  widget.onProbabilityModeChanged('normal');
                },
              ),
              ChoiceCard(
                icon: '🔝',
                label: 'rising',
                isSelected: widget.fieldsMode == 'rising',
                onTap: () {
                  widget.onProbabilityModeChanged('rising');
                },
              ),
              ChoiceCard(
                icon: '📉',
                label: 'descending',
                isSelected: widget.fieldsMode == 'descending',
                onTap: () {
                  widget.onProbabilityModeChanged('descending');
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
