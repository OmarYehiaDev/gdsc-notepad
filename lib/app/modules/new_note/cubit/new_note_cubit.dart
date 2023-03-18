import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_notepad/app/models/note.dart';
import 'package:gdsc_notepad/app/models/note_importance.dart';
import 'package:gdsc_notepad/app/services/prefs.dart';

part 'new_note_state.dart';

class NewNoteCubit extends Cubit<NewNoteState> {
  NewNoteCubit() : super(NewNoteInitial());

  static NewNoteCubit of(BuildContext context) => BlocProvider.of(context);

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentCtrl = TextEditingController();
  Note note = Note.empty();

  int get charsNumber => (titleCtrl.text.length + contentCtrl.text.length).toInt();
  int get wordsNumber {
    int titleWordsLength = titleCtrl.text.isNotEmpty ? titleCtrl.text.split(" ").length : 0;
    int contentWordsLength = contentCtrl.text.isNotEmpty ? contentCtrl.text.split(" ").length : 0;
    return titleWordsLength + contentWordsLength;
  }

  void changeImportance(NoteImportance? value) {
    emit(NewNoteLoading());
    note = note.copyWith(importance: value);
    emit(NewNoteUpdated());
  }

  void saveNote(BuildContext context) async {
    emit(NewNoteLoading());
    note = note.copyWith(
      id: "${titleCtrl.text}test",
      title: titleCtrl.text,
      content: contentCtrl.text,
      createdAt: DateTime.now(),
      lastUpdatedAt: DateTime.now(),
    );
    emit(NewNoteCreated());

    final res = await Prefs.setList(
      "Notes",
      [note],
      (data) => Note.toJson(data),
    );
    if (res == true) {
      List<Note> notes = Prefs.getList("Notes", (data) => Note.fromJson(data: data));
      log(notes.toString());
      log(notes.last.title);
      log(notes.last.content);
      if (context.mounted) {
        Navigator.of(context).pop(true);
      }
    }
  }
}
