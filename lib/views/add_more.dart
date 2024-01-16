import 'package:flutter/material.dart';
import 'package:jira_creator/viewModels/app_provider.dart';
import 'package:jira_creator/views/background_with_circles.dart';

class AddMoreButton extends StatelessWidget {
  final Function(String) onAddElement;
  final Color backgroundColor;
  final Color overlayColor;
  final AppProvider provider;

  const AddMoreButton({
    super.key,
    required this.onAddElement,
    required this.backgroundColor,
    required this.overlayColor,
    required this.provider,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        TextEditingController titleController = TextEditingController();

        String customTitle = await showDialog<String>(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Title of your jira field'),
                  content: TextFormField(
                    autofocus: true,
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter title here',
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('OK'),
                      onPressed: () {
                        Navigator.of(context).pop(titleController.text);
                      },
                    ),
                  ],
                );
              },
            ) ??
            'Field Title'; // Default title if none is entered

        // Add new BackgroundWithCircles with JiraRow
        onAddElement(customTitle);
      },
      child: BackgroundWithCircles(
          backgroundColor: backgroundColor,
          overlayColor: overlayColor,
          child: const Column(
            children: [
              SizedBox(height: 25),
              Icon(Icons.add, color: Colors.white, size: 50),
              SizedBox(height: 25),
              Text('Add more'),
            ],
          )),
    );
  }
}
