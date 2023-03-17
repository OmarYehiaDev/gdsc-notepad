import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_notepad/app/models/note.dart';
import 'package:gdsc_notepad/app/services/prefs.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesLoading());

  static NotesCubit of(BuildContext context) => BlocProvider.of(context);
  List<Note> notes = [];
  void getNotes() {
    emit(NotesLoading());
    List<Note> data = Prefs.getList<Note>("Notes", (data) => Note.fromJson(data: data));
    notes = data;
    emit(NotesEmpty());
  }
}
