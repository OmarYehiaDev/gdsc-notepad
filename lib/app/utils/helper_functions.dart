import 'package:flutter/material.dart';

import '../models/note_importance.dart';

class Helpers {
  static Color switchColors(NoteImportance e) {
    switch (e) {
      case NoteImportance.high:
        return Colors.red;
      case NoteImportance.moderate:
        return Colors.orange;
      default:
        return Colors.green;
    }
  }
}
