import 'package:flutter/material.dart';
import 'package:hewr_note_app/widgets/create_note_dialog.dart';
import 'package:hewr_note_app/widgets/edit_note_dialog.dart';
import 'package:hewr_note_app/widgets/note_dialog.dart';

class DialogFuncs {
  static openDialiagNote(context, id, note) => showDialog(
        context: context,
        builder: (context) => NoteDialog(id: id, note: note),
      );
  static openCreateDialoagNote(context, note) => showDialog(
        context: context,
        builder: (context) => CreateNoteDialoag(
          note: note,
        ),
      );
  static openEditDialogNote(context, id, note) => showDialog(
        context: context,
        builder: (context) => EditNoteDialog(
          id: id,
          note: note,
        ),
      );
}
