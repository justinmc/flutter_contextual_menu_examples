import 'package:flutter/material.dart';

class EmailButtonPage extends StatelessWidget {
  const EmailButtonPage({
    Key? key,
  }) : super(key: key);

  static const String route = 'email-button';
  static const String title = 'Email Button';
  static const String subtitle = 'A selection-aware email button';

  DialogRoute _showDialog (BuildContext context) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
        const AlertDialog(title: Text('You clicked send email!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(EmailButtonPage.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(height: 20.0),
          TextField(
            buildContextualMenu: (BuildContext context, EditableTextState editableTextState, Offset primaryAnchor, Offset? secondaryAnchor) {
              final TextEditingValue value = editableTextState.textEditingValue;

              return TextSelectionToolbarButtonDatasBuilder(
                editableTextState: editableTextState,
                builder: (BuildContext context, List<ContextualMenuButtonData> buttonDatas) {
                  if (_isValidEmail(value.selection.textInside(value.text))) {
                    buttonDatas.insert(0, ContextualMenuButtonData(
                      label: 'Send email',
                      onPressed: () {
                        Navigator.of(context).push(_showDialog(context));
                      },
                    ));
                  }
                  return DefaultTextSelectionToolbar(
                    primaryAnchor: primaryAnchor,
                    secondaryAnchor: secondaryAnchor,
                    buttonDatas: buttonDatas,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

bool _isValidEmail(String text) {
  return RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
    .hasMatch(text);
}