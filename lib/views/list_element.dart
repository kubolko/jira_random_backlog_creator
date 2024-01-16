import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListElement extends StatefulWidget {
  final String text;
  final Color color;
  final VoidCallback onDelete;
  final Function(String) onTextChanged;
  final Function(String) onSubmitted; // Added onSubmitted callback
  final VoidCallback onPressed;

  const ListElement({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    required this.onSubmitted,
    required this.onDelete,
    required this.onTextChanged,
  });

  @override
  _ListElementState createState() => _ListElementState();
}

class _ListElementState extends State<ListElement> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
    _focusNode = FocusNode();

    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        // The text field has lost focus
        widget.onSubmitted(_controller.text);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        ElevatedButton(
          onPressed: widget.onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.color,
            minimumSize: const Size(125, 70),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: TextFormField(
            controller: _controller,
            focusNode: _focusNode,
            style: GoogleFonts.getFont('Roboto Mono'),
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            onFieldSubmitted: widget.onSubmitted, // Using onSubmitted callback
          ),
        ),
        GestureDetector(
          onTap: widget.onDelete,
          child: Container(
            width: 20,
            height: 20,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFD9D9D9),
            ),
            child: const Center(
              child: Text(
                '💀',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
