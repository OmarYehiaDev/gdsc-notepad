import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_notepad/app/models/note.dart';
import 'package:gdsc_notepad/app/services/prefs.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial());

  static NotesCubit of(BuildContext context) => BlocProvider.of(context);
  List<Note> notes = [];
  void getNotes() {
    emit(NotesLoading());

    if (Prefs.keyExists("Notes")) {
      List<Note> data = Prefs.getList<Note>("Notes", (data) => Note.fromJson(data: data));
      notes = data;
      emit(NotesSuccess());
    } else {
      emit(NotesEmpty());
    }
  }

  void refreshNotesList() async {
    getNotes();
    await Future.delayed(const Duration(seconds: 2));
    emit(NotesInitial());
  }
}
