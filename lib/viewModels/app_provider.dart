import 'dart:convert';
import 'dart:math';
import 'dart:html' as html;
import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';

class JiraRowElement {
  String title;
  List<String> items;
  String fieldsMode;
  String fakerMode;
  bool useFaker;

  JiraRowElement({
    required this.title,
    required this.items,
    required this.fieldsMode,
    required this.fakerMode,
    required this.useFaker,
  });
}

class AppProvider with ChangeNotifier {
  Map<String, JiraRowElement> jiraRowData = {};
  String setup;
  Faker faker;

  List<String> getItemsForJiraRow(String jiraRowId) {
    final list = List<String>.from(jiraRowData[jiraRowId]!.items);
    if (kDebugMode) {
      print(list);
    }
    return list;
  }

  void removeJiraRow(String jiraRowId) {
    jiraRowData.remove(jiraRowId);
    if (kDebugMode) {
      print('Removed JiraRow with id $jiraRowId');
    }
    notifyListeners();
  }

  void updateJiraRowItems(String jiraRowId, List<String> newItems) {
    if (kDebugMode) {
      print('Before update $jiraRowData');
    }
    jiraRowData[jiraRowId]!.items = newItems;
    notifyListeners();
    if (kDebugMode) {
      print('After update $jiraRowData');
    }
  }

  String getJiraRowTitle(String jiraRowId) {
    return jiraRowData[jiraRowId]!.title;
  }

  void updateJiraRowTitle(String jiraRowId, String newTitle) {
    jiraRowData[jiraRowId]!.title = newTitle;
    if (kDebugMode) {
      print(jiraRowData[jiraRowId]!.title);
    }
    notifyListeners();
  }

  String getJiraRowFieldsMode(String jiraRowId) {
    return jiraRowData[jiraRowId]!.fieldsMode;
  }

  void updateJiraRowProbabilityMode(String jiraRowId, String newFieldsMode) {
    jiraRowData[jiraRowId]!.fieldsMode = newFieldsMode;
    if (kDebugMode) {
      print(jiraRowData[jiraRowId]!.fieldsMode);
    }
    notifyListeners();
  }

  String getJiraRowFakerMode(String jiraRowId) {
    return jiraRowData[jiraRowId]!.fakerMode;
  }

  void updateJiraRowFakerMode(String jiraRowId, String newFakerMode) {
    jiraRowData[jiraRowId]!.fakerMode = newFakerMode;
    if (kDebugMode) {
      print(jiraRowData[jiraRowId]!.fakerMode);
    }
    notifyListeners();
  }

  bool getJiraRowUseFaker(String jiraRowId) {
    return jiraRowData[jiraRowId]!.useFaker;
  }

  void updateJiraRowUseFaker(String jiraRowId, bool newUseFaker) {
    jiraRowData[jiraRowId]!.useFaker = newUseFaker;
    if (kDebugMode) {
      print(jiraRowData[jiraRowId]!.useFaker);
    }
    notifyListeners();
  }

  void addItemToJiraRow(String jiraRowId, String newItem) {
    List<String> currentItems =
        List<String>.from(jiraRowData[jiraRowId]!.items);
    currentItems.add(newItem);
    jiraRowData[jiraRowId]!.items = currentItems;
    if (kDebugMode) {
      print(jiraRowData);
    }
    notifyListeners();
  }

  void addJiraRow(String jiraRowId, String title, List<String> newItems,
      String fieldsMode, String fakerMode, bool useFaker) {
    final jiraRow = JiraRowElement(
        title: title,
        items: newItems,
        fieldsMode: fieldsMode,
        fakerMode: fakerMode,
        useFaker: useFaker);

    jiraRowData[jiraRowId] = jiraRow;
    if (kDebugMode) {
      print('Added JiraRow with id $jiraRowId');
      print(jiraRowData);
    }

    notifyListeners();
  }

  AppProvider({this.setup = 'unknown'}) : faker = Faker();

  List<int> generateFibonacciList(int n) {
    List<int> fibonacciList = [];
    int a = 0, b = 1;

    for (int i = 0; i < n; i++) {
      fibonacciList.add(a);
      int temp = a;
      a = b;
      b = temp + b;
    }

    return fibonacciList;
  }

  List<String> generateIssueIds(int count) {
    return List<String>.generate(count, (index) => faker.guid.guid());
  }

  List<String> generateIssueTypes(int count) {
    List<String> issueTypes = ['Bug', 'Story', 'Task'];
    return List<String>.generate(
        count, (_) => issueTypes[Random().nextInt(issueTypes.length)]);
  }

  List<String> generateSummaries(int count) {
    return List<String>.generate(count, (_) => faker.lorem.sentence());
  }

  List<String> generateDescriptions(int count) {
    return faker.lorem.sentences(5);
  }

  List<String> generatePriorities(int count) {
    List<String> priorities = ['High', 'Medium', 'Low'];
    return List<String>.generate(
        count, (_) => priorities[Random().nextInt(priorities.length)]);
  }

  List<String> generateAssignees(int count) {
    return List<String>.generate(count, (_) => faker.person.name());
  }

  List<String> generateReporters(int count) {
    return List<String>.generate(count, (_) => faker.person.name());
  }

  List<String> generateLabels(int count) {
    return List<String>.generate(count, (_) => faker.lorem.word());
  }

  List<String> generateSprints(int count) {
    return List<String>.generate(count, (_) => faker.lorem.word());
  }

  List<String> generateComments(int count) {
    return List<String>.generate(count, (_) => faker.lorem.sentence());
  }

  List<String> generateStatuses(int count) {
    List<String> statuses = ['To Do', 'In Progress', 'Done'];
    return List<String>.generate(
        count, (_) => statuses[Random().nextInt(statuses.length)]);
  }

  List<String> generateStoryPoints(int count) {
    List<String> storyPoints = ['S', 'M', 'L', 'XL'];
    return List<String>.generate(
        count, (_) => storyPoints[Random().nextInt(storyPoints.length)]);
  }

  List<String> generateEpics(int count) {
    return List<String>.generate(count, (_) => faker.lorem.sentence());
  }

  List<String> generateComponents(int count) {
    return List<String>.generate(count, (_) => faker.lorem.sentence());
  }

  List<String> generateFixVersions(int count) {
    return List<String>.generate(count, (_) => faker.lorem.sentence());
  }

  int gaussianIndex(int listLength) {
    var rng = Random();
    double u1 = rng.nextDouble();
    double u2 = rng.nextDouble();
    double randStdNormal = sqrt(-2.0 * log(u1)) * sin(2.0 * pi * u2);
    double mean = listLength / 2;
    double stdDev = listLength / 6; // Assuming 99.7% within [0, listLength]
    int index =
        (mean + stdDev * randStdNormal).round().clamp(0, listLength - 1);
    return index;
  }

  int risingIndex(int listLength) {
    var rng = Random();
    double rand = rng.nextDouble();
    int index = (pow(rand, 1 / 3) * listLength).toInt();
    return index.clamp(0, listLength - 1);
  }

  int descendingIndex(int listLength) {
    var rng = Random();
    double rand = rng.nextDouble();
    int index = (pow(rand, 3) * listLength).toInt();
    return index.clamp(0, listLength - 1);
  }

  T pickRandom<T>(List<T> list, String mode) {
    int index;
    switch (mode) {
      case 'gaussian':
        index = gaussianIndex(list.length);
        break;
      case 'rising':
        index = risingIndex(list.length);
        break;
      case 'descending':
        index = descendingIndex(list.length);
        break;
      default: // 'even'
        index = Random().nextInt(list.length);
    }
    return list[index];
  }

  String convertDictToCsv(Map<String, List<dynamic>> data,
      {String separator = ','}) {
    StringBuffer csv = StringBuffer();

    // Removed 'Issue Id' from the header row
    csv.writeln(data.keys.join(separator));

    int numRows = data.values.first.length;

    for (int i = 0; i < numRows; i++) {
      List<String> row = [];

      for (var key in data.keys) {
        row.add(data[key]![i].toString());
      }
      csv.writeln(row.join(separator));
    }

    return csv.toString();
  }

  String generateAgileUserStory() {
    var faker = Faker();

    String role = faker.job.title();
    String task = faker.lorem.sentence();
    String goal = faker.lorem.sentence();

    return 'As a $role, I want to $task so that $goal.';
  }

  void triggerDownload(String content, String fileName) {
    // Encode the content to UTF-8
    final bytes = utf8.encode(content);
    final blob = html.Blob([bytes], 'text/csv; charset=utf-8');
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  void downloadCsv(Map<String, List<dynamic>> data) {
    String csvData = convertDictToCsv(data);
    triggerDownload(csvData, 'myData.csv');
  }

  Map<String, List<dynamic>> generateBacklogWithPredefinedElements(
      int count, int startingIssueID) {
    if (kDebugMode) {
      print('Generating backlog with predefined elements');
      print(count);
      print(jiraRowData.values);
    }

    Map<String, List<dynamic>> backlog = {};
    List<String> issueIds =
        List.generate(count, (index) => 'ID-${startingIssueID + index}');
    backlog['Issue Id'] = issueIds;

    for (var element in jiraRowData.values) {
      var columnName = element.title;
      List<String> row = [];

      if (element.useFaker) {
        if (kDebugMode) {
          print('Faker fields enabled');
        }
        for (int i = 0; i < count; i++) {
          var mode = element.fakerMode;
          switch (mode) {
            case 'sentence':
              row.add(faker.lorem.sentence());
              break;
            case 'user_story':
              row.add(generateAgileUserStory());
              break;
            case 'number':
              row.add(faker.randomGenerator.integer(100).toString());
              break;
            default:
              row.add(faker.lorem.sentence());
          }
        }
      } else {
        var columnItems = element.items;
        for (int i = 0; i < count; i++) {
          var mode = element.fieldsMode;
          row.add(pickRandom(columnItems, mode));
        }
      }
      backlog[columnName] = row;
    }

    if (kDebugMode) {
      print(backlog);
    }
    downloadCsv(backlog);
    return backlog;
  }
}
