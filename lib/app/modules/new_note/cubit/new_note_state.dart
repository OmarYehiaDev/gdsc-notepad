part of 'new_note_cubit.dart';

@immutable
abstract class NewNoteState {}

class NewNoteInitial extends NewNoteState {}

class NewNoteLoading extends NewNoteState {}

class NewNoteCreated extends NewNoteState {}

class NewNoteUpdated extends NewNoteState {}

class NewNoteFailed extends NewNoteState {
  final String error;
  NewNoteFailed(this.error);
}
