import 'package:gdsc_notepad/app/models/note_importance.dart';

class Note {
  final String id;
  final String title;
  final String content;
  NoteImportance importance;
  final DateTime createdAt;
  final DateTime lastUpdatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.importance = NoteImportance.low,
    required this.createdAt,
    required this.lastUpdatedAt,
  });

  factory Note.empty() => Note(
        id: "0",
        title: "",
        content: "",
        createdAt: DateTime.now(),
        lastUpdatedAt: DateTime.now(),
      );

  Note copyWith({
    String? id,
    String? title,
    String? content,
    NoteImportance? importance,
    DateTime? createdAt,
    DateTime? lastUpdatedAt,
  }) =>
      Note(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
        importance: importance ?? this.importance,
      );

  factory Note.fromJson({
    required Map<String, dynamic> data,
  }) {
    return Note(
      id: data["id"],
      title: data["title"],
      content: data["content"],
      createdAt: DateTime.parse(data["createdAt"]),
      importance: NoteImportance.values.singleWhere(
        (element) => element.name == data["importance"],
      ),
      lastUpdatedAt: DateTime.parse(data["lastUpdatedAt"]),
    );
  }

  static Map<String, dynamic> toJson(Note note) {
    return {
      "id": note.id,
      "title": note.title,
      "content": note.content,
      "importance": note.importance.name,
      "createdAt": note.createdAt.toString(),
      "lastUpdatedAt": note.lastUpdatedAt.toString(),
    };
  }
}
