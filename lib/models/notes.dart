import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class NoteStorage {
  static const String notesKey = "notes";

  Future<void> saveNotes(List<Note> notes) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> jsonNotes =
        notes.map((note) => jsonEncode(note.toJson())).toList();

    await prefs.setStringList(notesKey, jsonNotes);
  }

  // Retrieve notes from SharedPreferences
  Future<List<Note>> getNotes() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? jsonNotes = prefs.getStringList(notesKey);
    if (jsonNotes == null) {
      return [];
    }

    return jsonNotes
        .map((jsonNote) => Note.fromJson(jsonDecode(jsonNote)))
        .toList();
  }
}
//Class for Note

class Note {
  final String content;

  Note({
    required this.content,
  });

  // Convert a Note object to a JSON string
  Map<String, dynamic> toJson() => {
        'content': content,
      };

  // Convert a JSON string to a Note object
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      content: json['content'],
    );
  }
}
