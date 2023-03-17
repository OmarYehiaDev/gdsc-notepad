part of 'notes_cubit.dart';

@immutable
abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoading extends NotesState {}

class NotesSuccess extends NotesState {}
class NotesEmpty extends NotesState {}

class NotesFailed extends NotesState {
  final String error;
  NotesFailed(this.error);
}
