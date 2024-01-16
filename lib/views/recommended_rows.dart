import 'package:flutter/material.dart';

class PredefinedElement extends StatefulWidget {
  final String elementName;
  final List<String> elementDescription;
  final String? hint;
  final Function(String, List<String>) onAddJiraRow;

  const PredefinedElement({
    super.key,
    required this.elementName,
    required this.elementDescription,
    this.hint,
    required this.onAddJiraRow,
  });

  @override
  _PredefinedElementState createState() => _PredefinedElementState();
}

class _PredefinedElementState extends State<PredefinedElement> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    if (isClicked) {
      // If the element has been clicked, don't show it.
      return Container();
    }

    return InkWell(
      onTap: () {
        if (!isClicked) {
          setState(() {
            isClicked = true; // Mark as clicked to prevent re-adding
            widget.onAddJiraRow(widget.elementName, widget.elementDescription);
          });
        }
      },
      child: Container(
        width: 300,
        height: 160,
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          border: Border.all(color: Colors.blue, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
          gradient: LinearGradient(
            colors: [Colors.lightBlue[100]!, Colors.purple[100]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.elementName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.red,
                shadows: [
                  Shadow(
                    blurRadius: 5.0,
                    color: Colors.yellow,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            if (widget.hint != null)
              Text(
                widget.hint!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  color: Colors.red,
                  shadows: [
                    Shadow(
                      blurRadius: 5.0,
                      color: Colors.yellow,
                      offset: Offset(1.0, 1.0),
                    ),
                  ],
                ),
              ),
            const Divider(color: Colors.green),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  widget.elementDescription.join(', '),
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Text(
              'Add as row',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
