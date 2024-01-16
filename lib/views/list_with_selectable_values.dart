import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jira_creator/views/faker_selector.dart';
import 'package:jira_creator/views/probability_selector.dart';
import 'package:provider/provider.dart';
import '../viewModels/app_provider.dart';
import 'list_element.dart';

class JiraRow extends StatefulWidget {
  final String id;
  final List<String> initialItems;
  final Function(String) onRemoveElement;

  String initialTitle;
  String initialFieldsMode;
  String initialFakerMode;
  bool useFaker;

  JiraRow({
    super.key,
    required this.id, // Unique ID for each JiraRow instance
    required this.initialItems, // Initial items list
    required this.initialTitle,
    this.initialFieldsMode = 'even',
    this.initialFakerMode = 'word',
    this.useFaker = false,
    required this.onRemoveElement,
  });

  @override
  _JiraRowState createState() => _JiraRowState();
}

class _JiraRowState extends State<JiraRow> {
  late TextEditingController _titleController;
  late FocusNode _titleFocusNode;

  @override
  void initState() {
    super.initState();
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    _titleController = TextEditingController(text: widget.initialTitle);
    _titleFocusNode = FocusNode();
    _titleFocusNode.addListener(() {
      if (!_titleFocusNode.hasFocus) {
        appProvider.updateJiraRowTitle(widget.id, _titleController.text);
      }
    });
  }

  void _handleReorder(int oldIndex, int newIndex) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    var items = appProvider.getItemsForJiraRow(widget.id);
    final String item = items.removeAt(oldIndex);
    items.insert(newIndex, item);
    appProvider.updateJiraRowItems(widget.id, items);
  }

  void handleDelete(int index) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    var items = appProvider.getItemsForJiraRow(widget.id);
    items.removeAt(index);
    appProvider.updateJiraRowItems(widget.id, items);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    List<String> items = appProvider.getItemsForJiraRow(widget.id);
    String probabilityMode = appProvider.getJiraRowFieldsMode(widget.id);
    String fakerMode = appProvider.getJiraRowFakerMode(widget.id);
    bool useFaker = appProvider.getJiraRowUseFaker(widget.id);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 25),
        LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 600) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    controller: _titleController,
                    focusNode: _titleFocusNode,
                    style: GoogleFonts.merienda(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onFieldSubmitted: (newValue) {
                      setState(() {
                        appProvider.updateJiraRowTitle(widget.id, newValue);
                      });
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      widget.onRemoveElement(widget.id);
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        "Remove?",
                        style: GoogleFonts.merienda(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF03045E),
                            // Border color
                            width: 2.0, // Border width
                          ),
                        ),
                        child: Image.asset(
                          'assets/do_not_include.png',
                          fit: BoxFit.fitHeight,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 45),
                Text(
                  'Custom Fields',
                  style: GoogleFonts.merienda(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Switch(
                  activeColor: const Color(0xFF03045E),
                  value: useFaker,
                  onChanged: (bool newValue) {
                    setState(() {
                      useFaker = newValue;
                      appProvider.updateJiraRowUseFaker(widget.id, newValue);
                    });
                  },
                ),
                Text(
                  'Generate fake stuff',
                  style: GoogleFonts.merienda(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  child: TextFormField(
                    controller: _titleController,
                    focusNode: _titleFocusNode,
                    style: GoogleFonts.merienda(
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    onFieldSubmitted: (newValue) {
                      setState(() {
                        appProvider.updateJiraRowTitle(widget.id, newValue);
                      });
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      widget.onRemoveElement(widget.id);
                    });
                  },
                  child: Column(
                    children: [
                      Text(
                        "Remove?",
                        style: GoogleFonts.merienda(
                          fontSize: 18,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF03045E),
                            // Border color
                            width: 2.0, // Border width
                          ),
                        ),
                        child: Image.asset(
                          'assets/do_not_include.png',
                          fit: BoxFit.fitHeight,
                          height: 40,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 45),
                Text(
                  'Custom Fields',
                  style: GoogleFonts.merienda(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                Switch(
                  activeColor: const Color(0xFF03045E),
                  value: useFaker,
                  onChanged: (bool newValue) {
                    setState(() {
                      useFaker = newValue;
                      appProvider.updateJiraRowUseFaker(widget.id, newValue);
                    });
                  },
                ),
                Text(
                  'Generate fake stuff',
                  style: GoogleFonts.merienda(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
              ],
            );
          }
        }),
        const SizedBox(height: 10),
        useFaker
            ? Column(children: [
                const SizedBox(height: 10),
                const Text(
                  'Custom Fields',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Generate fake stuff',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                FakerSelector(
                    fakerMode: fakerMode,
                    onFakerModeChanged: (newMode) {
                      setState(() {
                        fakerMode = newMode;
                        appProvider.updateJiraRowFakerMode(widget.id, newMode);
                      });
                    })
              ])
            : Column(
                children: [
                  SizedBox(
                    height: 125,
                    child: Center(
                      child: ReorderableListView.builder(
                        buildDefaultDragHandles: false,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        onReorder: _handleReorder,
                        itemBuilder: (context, index) {
                          final String item = items[index];

                          return ReorderableDragStartListener(
                            index: index,
                            key: ValueKey(items[index]),
                            child: Container(
                              width: 150,
                              padding: const EdgeInsets.all(8.0),
                              child: ListElement(
                                text: item,
                                color: const Color(0xFF0077B6),
                                onPressed: () {},
                                onDelete: () {
                                  setState(() {
                                    items.removeAt(index);
                                    appProvider.updateJiraRowItems(
                                        widget.id, items);
                                  });
                                },
                                onTextChanged: (newText) {
                                  if (newText.isNotEmpty) {
                                    items[index] = newText;
                                  }
                                },
                                onSubmitted: (newText) {
                                  setState(() {
                                    items[index] = newText;
                                    appProvider.updateJiraRowItems(
                                        widget.id, items);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        String newItem = 'New Item ${items.length + 1}';
                        if (kDebugMode) {
                          print('Adding $newItem');
                        }
                        appProvider.addItemToJiraRow(widget.id, newItem);
                        items = List.from(
                            appProvider.getItemsForJiraRow(widget.id));
                      });
                    },
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent, // Bright background color
                        border: Border.all(
                          color: const Color(
                              0xff0035E3), // Contrasting border color
                          width: 3, // Thicker border
                        ),
                        borderRadius:
                            BorderRadius.circular(12), // Rounded corners
                      ),
                      child: Text(
                        'Add Item',
                        style: GoogleFonts.getFont(
                          'Roboto Mono',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                          letterSpacing: 3,
                        ),
                        textAlign: TextAlign.center, // Center the text
                      ),
                    ),
                  ),
                  ProbabilitySelector(
                    fieldsMode: probabilityMode.toLowerCase(),
                    onProbabilityModeChanged: (newMode) {
                      setState(() {
                        probabilityMode = newMode;
                        appProvider.updateJiraRowProbabilityMode(
                            widget.id, newMode);
                      });
                    },
                  ),
                ],
              )
      ],
    );
  }
}
