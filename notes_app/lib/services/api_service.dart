import 'dart:convert';
import 'dart:math';

import '../models/note.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String _baseUrl = "http://10.0.2.2:5000/notes";

  static Future<void> addNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/add");
    var response = await http.post(
      requestUri,
      body: note.toMap(),
    );
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
  }

  static Future<void> deleteNote(Note note) async {
    Uri requestUri = Uri.parse("$_baseUrl/delete");
    var response = await http.post(
      requestUri,
      body: {"id": note.toMap()["id"]},
    );
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
  }

  static Future<List<Note>> fetchNotes(String userid) async {
    Uri requestUri = Uri.parse("$_baseUrl/list");
    var response = await http.post(
      requestUri,
      body: {"userid": userid},
    );
    var decoded = jsonDecode(response.body);
    print(decoded.toString());
    List<Note> notesList = [];
    decoded.forEach((e) {
      Note newNote = Note.fromMap(e);
      notesList.add(newNote);
    });

    return notesList;
  }
}
