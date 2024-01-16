import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jira_creator/viewModels/app_provider.dart';
import 'package:jira_creator/views/recommended_rows.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import 'views/about_me.dart';
import 'views/generate_backlog.dart';
import 'views/add_more.dart';
import 'views/description.dart';
import 'views/list_with_selectable_values.dart';
import 'views/background_with_circles.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ChangeNotifierProvider(
      create: (context) => AppProvider(), // Directly create the instance here
      child: const MaterialApp(home: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late List<BackgroundWithCircles> elementsList;
  bool showAboutMe = false;

  @override
  void initState() {
    super.initState();
    elementsList =
        _initializeElementsList(); // Initialize your list in initState
  }

  Color get colorOfLastElement {
    var color = elementsList.isNotEmpty
        ? elementsList.last.backgroundColor
        : const Color(0xff90E0EF);
    if (color == const Color(0xff03045E)) {
      color = const Color(0xffCAF0F8);
    }
    return color;
  }

  Color get overlayColorOfLastElement {
    var color =
        elementsList.isNotEmpty ? elementsList.last.overlayColor : Colors.white;
    if (color == const Color(0xff03045E)) {
      color = const Color(0xffCAF0F8);
    }
    return color;
  }

  void _handleDeletionJiraRow(String id) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    appProvider.removeJiraRow(id);

    // Iterate through elementsList to find and remove the matching JiraRow
    elementsList.removeWhere((element) {
      if (element.child is JiraRow) {
        final jiraRow = element.child as JiraRow;
        return jiraRow.id == id;
      }
      return false;
    });
  }

  void _handleAddPredefinedJiraRow(String title, List<String> items) {
    final appProvider = Provider.of<AppProvider>(context, listen: false);
    final id = 'jiraRow${DateTime.now().millisecondsSinceEpoch}';
    appProvider.addJiraRow(id, title, items, 'even', 'word', false);
    final newElement = BackgroundWithCircles(
      backgroundColor: overlayColorOfLastElement,
      overlayColor: colorOfLastElement,
      child: JiraRow(
        initialTitle: title,
        initialItems: items,
        initialFieldsMode: 'even',
        initialFakerMode: 'word',
        useFaker: false,
        id: id,
        onRemoveElement: (String id) => _handleDeletionJiraRow(id),
      ),
    );
    elementsList.add(newElement);
  }

  List<BackgroundWithCircles> _initializeElementsList() {
    List<PredefinedElement> predefinedJiraRowsList = [
      PredefinedElement(
        elementName: 'Story Points (T-shirt sizes)',
        elementDescription: const ['S', 'M', 'L', 'XL'],
        onAddJiraRow: _handleAddPredefinedJiraRow,
      ),
      PredefinedElement(
          elementName: 'Story Points (Fibonacci Series)',
          elementDescription: const ['1', '2', '3', '5', '8', '13'],
          onAddJiraRow: _handleAddPredefinedJiraRow),
      PredefinedElement(
        elementName: 'IssueType',
        elementDescription: const ['Bug', 'Epic', 'Story', 'Task', 'Sub-task'],
        onAddJiraRow: _handleAddPredefinedJiraRow,
      ),
      PredefinedElement(
        elementName: 'Issue Key',
        elementDescription: const ['JR-'],
        hint:
            "It will be the prefix of the issue ID, must contain '-' at the end",
        onAddJiraRow: _handleAddPredefinedJiraRow,
      ),
      PredefinedElement(
        elementName: 'Status',
        elementDescription: const ['To Do', 'In Progress', 'Done'],
        onAddJiraRow: _handleAddPredefinedJiraRow,
      ),
      PredefinedElement(
        elementName: 'Priority',
        elementDescription: const ['Low', 'Medium', 'High'],
        onAddJiraRow: _handleAddPredefinedJiraRow,
      ),
      PredefinedElement(
        elementName: 'Assignee',
        elementDescription: const ['abc@example.net', 'bcd@example.net'],
        hint:
            'https://<yoursitename>.atlassian.net/jira/people/<Your Atlassian account ID>',
        onAddJiraRow: _handleAddPredefinedJiraRow,
      ),
      PredefinedElement(
        elementName: 'Reporter',
        elementDescription: const ['abc@example.net', 'bcd@example.net'],
        hint:
            'https://<yoursitename>.atlassian.net/jira/people/<Your Atlassian account ID>',
        onAddJiraRow: _handleAddPredefinedJiraRow,
      ),
      PredefinedElement(
        elementName: 'Labels',
        elementDescription: const ['Label1', 'Label2', 'Label3'],
        onAddJiraRow: _handleAddPredefinedJiraRow,
      ),
      PredefinedElement(
        elementName: 'Sprint',
        elementDescription: const ['Sprint 1', 'Sprint 2', 'Sprint 3'],
        onAddJiraRow: _handleAddPredefinedJiraRow,
      ),
      PredefinedElement(
        elementName: 'Comments',
        elementDescription: const ['Who tf invented this, remove this asap'],
        onAddJiraRow: _handleAddPredefinedJiraRow,
      ),
    ];

    List<BackgroundWithCircles> elementsList = [];

    elementsList.add(
      BackgroundWithCircles(
        backgroundColor: const Color(0xff03045E),
        overlayColor: const Color(0xff90E0EF),
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(
                "Here are some recommended rows, they are all compatible with the default Jira template",
                style: GoogleFonts.getFont('Roboto Mono', color: Colors.white)),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: predefinedJiraRowsList),
            ),
          ],
        ),
      ),
    );

    return elementsList;
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<AppProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(screenWidth < 600 ? 80 : 120),
          child: AppBar(
            automaticallyImplyLeading: false, // Disable the back button
            backgroundColor: const Color(0xff03045E),
            flexibleSpace: Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 50),
                  child: InkWell(
                    child: const Text('repo',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'menlo',
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
                    onTap: () async {
                      final Uri url = Uri.parse('https://flutter.dev');
                      if (!await launchUrl(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.fitWidth,
                        height: 80, // Adjust the height as needed
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 50),
                  child: InkWell(
                    child: const Text('about me 👉👈',
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'menlo',
                            fontWeight: FontWeight.normal,
                            color: Colors.white)),
                    onTap: () {
                      setState(() {
                        showAboutMe = !showAboutMe; // Toggle the flag
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: elementsList.length + 2,
          // Adjust itemCount
          itemBuilder: (BuildContext context, int index) {
            if (showAboutMe && index == 0) {
              return const BackgroundWithCircles(
                  backgroundColor: Color(0xff90E0EF),
                  overlayColor: Color(0xff03045E),
                  child: AboutMeSection());
            } else if (!showAboutMe && index == 0) {
              return const BackgroundWithCircles(
                backgroundColor: Color(0xff90E0EF),
                overlayColor: Color(0xff03045E),
                child: Description(),
              );
            }
            int adjustedIndex = index - 1;
            if (adjustedIndex == elementsList.length) {
              return Column(
                children: [
                  BackgroundWithCircles(
                    backgroundColor: colorOfLastElement,
                    overlayColor: colorOfLastElement,
                    child: AddMoreButton(
                      onAddElement: (String title) =>
                          _handleAddPredefinedJiraRow(
                              title, ['Element 1', 'Element 2', 'Element 3']),
                      provider: provider,
                      backgroundColor: overlayColorOfLastElement,
                      overlayColor: colorOfLastElement,
                    ),
                  ),
                  GenerateBacklogButton(
                      provider: provider,
                      backgroundColorOfPreviousElement:
                          elementsList.last.backgroundColor,
                      overlayColorOfPreviousElement:
                          elementsList.last.overlayColor),
                  Container(
                      color: elementsList.last.backgroundColor,
                      width: double.infinity,
                      height: 100),
                ],
              ); // Helper method for bottom widgets
            } else {
              return elementsList[adjustedIndex]; // Render other elements
            }
          },
        ),
      );
    });
  }
}
