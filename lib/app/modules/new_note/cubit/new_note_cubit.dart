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

  void changeImportance(NoteImportance? value) {
    emit(NewNoteLoading());
    note = note.copyWith(importance: value);
    emit(NewNoteUpdated());
  }

  Color switchColors(NoteImportance e) {
    switch (e) {
      case NoteImportance.high:
        return Colors.red;
      case NoteImportance.moderate:
        return Colors.orange;
      default:
        return Colors.green;
    }
  }

  void saveNote() async {
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
    }
  }
}
