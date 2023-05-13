import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:styled_text/styled_text.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key, required this.title});

  final String title;

  final List<ButtonSegment<int>> _listButtons =
      List<ButtonSegment<int>>.generate(
          3,
          (index) => ButtonSegment<int>(
                value: index,
                label: Text('$index'),
              ));
  int _value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        badges.Badge(
          position: badges.BadgePosition.topEnd(top: 0, end: 3),
          badgeAnimation: const badges.BadgeAnimation.slide(),
          showBadge: true,
          badgeStyle: const badges.BadgeStyle(),
          badgeContent: Text(
            _value.toString(),
            style: const TextStyle(color: Colors.white),
          ),
          child: IconButton(
              icon: const Icon(Icons.shopping_cart), onPressed: () {}),
        ),
        const Text('action01'),
        const Text('action02'),
        const Text('action03'),
      ], title: Text(title)),
      body: Center(
        child: Column(
          children: [
            SegmentedButton<int>(
//            segments: _listButtons,
              segments: [
                for (int index = 1; index <= 5; ++index)
                  ButtonSegment<int>(
                    value: index,
                    label: Text('$index'),
                  ),
              ],
              selected: <int>{_value},
              onSelectionChanged: (Set<int> newSelection) {},
            ),
            const SingleChoice(),
            const MultipleChoice(),
            StyledText(
              text: t,
              style: const TextStyle(fontSize: 15),
              tags: {
                'title': StyledTextTag(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.blue,
                      textBaseline: TextBaseline.ideographic,
                    )),
                'header': StyledTextTag(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white10,
                    )),
                'refer': StyledTextTag(
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    )),
                'bold': StyledTextTag(
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                'TextButton': StyledTextWidgetTag(Center(
                  child: TextButton(
                    onPressed: () {},
                    child: const Text('Кнопка'),
                  ),
                )),
                'Divader': StyledTextWidgetTag(const Divider(
                  thickness: 5,
                )),
                'fl-ego': StyledTextWidgetTag(const FlutterLogo(size: 72.0)),
                'TextButton2': StyledTextWidgetTag(TextButton(
                  onPressed: () {

                  },
                  child: const Text('Кнопка'),
                )),
                'sizebox': StyledTextWidgetTag(const SizedBox(width: 100, height: 100,)),
              },
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Segmented Button'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Item 2'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

enum Calendar { day, week, month, year }

class SingleChoice extends StatefulWidget {
  const SingleChoice({super.key});

  @override
  State<SingleChoice> createState() => _SingleChoiceState();
}

class _SingleChoiceState extends State<SingleChoice> {
  Calendar calendarView = Calendar.day;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Calendar>(
      segments: const <ButtonSegment<Calendar>>[
        ButtonSegment<Calendar>(
            value: Calendar.day,
            label: Text('Day'),
            icon: Icon(Icons.calendar_view_day)),
        ButtonSegment<Calendar>(
            value: Calendar.week,
            label: Text('Week'),
            icon: Icon(Icons.calendar_view_week)),
        ButtonSegment<Calendar>(
            value: Calendar.month,
            label: Text('Month'),
            icon: Icon(Icons.calendar_view_month)),
        ButtonSegment<Calendar>(
            value: Calendar.year,
            label: Text('Year'),
            icon: Icon(Icons.calendar_today)),
      ],
      selected: <Calendar>{calendarView},
      onSelectionChanged: (Set<Calendar> newSelection) {
        setState(() {
          // By default there is only a single segment that can be
          // selected at one time, so its value is always the first
          // item in the selected set.
          calendarView = newSelection.first;
        });
      },
    );
  }
}

enum Sizes { extraSmall, small, medium, large, extraLarge }

class MultipleChoice extends StatefulWidget {
  const MultipleChoice({super.key});

  @override
  State<MultipleChoice> createState() => _MultipleChoiceState();
}

class _MultipleChoiceState extends State<MultipleChoice> {
  Set<Sizes> selection = <Sizes>{Sizes.large, Sizes.extraLarge};

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<Sizes>(
      segments: const <ButtonSegment<Sizes>>[
        ButtonSegment<Sizes>(value: Sizes.extraSmall, label: Text('XS')),
        ButtonSegment<Sizes>(value: Sizes.small, label: Text('S')),
        ButtonSegment<Sizes>(value: Sizes.medium, label: Text('M')),
        ButtonSegment<Sizes>(
          value: Sizes.large,
          label: Text('L'),
        ),
        ButtonSegment<Sizes>(value: Sizes.extraLarge, label: Text('XL')),
      ],
      selected: selection,
      onSelectionChanged: (Set<Sizes> newSelection) {
        setState(() {
          selection = newSelection;
        });
      },
      multiSelectionEnabled: true,
    );
  }
}

String t = '''

<title>StyledText</title> 

<TextButton></TextButton>
<Divader></Divader>
Text widget with formatted text using tags. <icon>Icon Text</icon>Makes it easier to use formatted text in multilingual applications.

Formatting is set in the text using xml tags, for which styles and other behaviors are defined separately. It is also possible to insert icons and widgets through tags.

<fl-ego></fl-ego>A list tile contains one to three lines of text optionally flanked by icons or other widgets, such as check boxes. The icons (or other widgets) for the tile are defined with the leading and trailing parameters. The first line of text is not optional and is specified with title. <sizebox></sizebox>The value of subtitle, which is optional, will occupy the space allocated for an additional line of text, or two lines if isThreeLine is true. If dense is true then the overall height of this tile and the size of the DefaultTextStyles that wrap the title and subtitle widget are reduced.
You can set the click handler for the tag, <TextButton2></TextButton2>through a tag definition class StyledTextActionTag.

<bold>Attention!</bold> The way of specifying the styles and behavior of tags has changed. See how to migrate from version 2.0.

<bold>Attention!</bold> The default value of the newLineAsBreaks parameter has been changed, <sizebox></sizebox>now it is enabled by default and line breaks are not ignored in the text.

<header>Table of Contents</header>
<refer>
  Getting Started
    Escaping & special characters
    Line breaks
  Usage examples
    How to insert a widget into text
Migration from version 2.0
</refer>
    ''';
