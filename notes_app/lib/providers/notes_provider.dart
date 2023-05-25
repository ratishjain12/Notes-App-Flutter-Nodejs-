import 'package:flutter/material.dart';
import 'package:notes_app/services/api_service.dart';

import '../models/note.dart';

class NoteProvider extends ChangeNotifier {
  bool isLoading = true;
  List<Note> notes = [];

  void sortNotes() {
    notes.sort((a, b) => b.dateadded!.compareTo(a.dateadded!));
  }

  List<Note> searchList(String searchQuery) {
    List<Note> searchedNotes = [];
    searchedNotes = notes
        .where((element) => element.title!.toLowerCase().contains(searchQuery))
        .toList();
    return searchedNotes;
  }

  void addNote(Note note) {
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void updateNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes[indexOfNote] = note;
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }

  void deleteNote(Note note) {
    int indexOfNote =
        notes.indexOf(notes.firstWhere((element) => element.id == note.id));
    notes.removeAt(indexOfNote);
    sortNotes();
    notifyListeners();
    ApiService.deleteNote(note);
  }

  void fetchNotes() async {
    notes = await ApiService.fetchNotes("ratishjain62@gmail.com");
    sortNotes();
    isLoading = false;
    notifyListeners();
  }
}
