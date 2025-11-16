import 'package:flutter/material.dart';

Future<void> showEditCommentDialog(
  BuildContext context,
  String oldContent,
  Function(String) onSave,
) {
  TextEditingController controller =
      TextEditingController(text: oldContent);

  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Edit Comment"),
      content: TextField(
        controller: controller,
        minLines: 1,
        maxLines: 3,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        ),
        ElevatedButton(
          onPressed: () {
            final edited = controller.text.trim();
            if (edited.isNotEmpty) {
              onSave(edited);
            }
            Navigator.pop(context);
          },
          child: Text("Save"),
        ),
      ],
    ),
  );
}
