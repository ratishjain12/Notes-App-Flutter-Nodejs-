import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/models/note.dart';
import 'package:notes_app/pages/addnewnote.dart';
import 'package:notes_app/providers/notes_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final notesProvider = Provider.of<NoteProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Notes App"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            Note currentNote = notesProvider.notes[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) => AddNewPage(
                              isUpdate: true,
                              note: currentNote,
                            )));
              },
              onLongPress: () {
                notesProvider.deleteNote(currentNote);
              },
              child: Container(
                  margin: const EdgeInsets.all(5),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Colors.grey,
                      width: 2,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        currentNote.title!,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Text(
                        currentNote.content!,
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey[700],
                        ),
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )),
            );
          },
          itemCount: notesProvider.notes.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => const AddNewPage(
                        isUpdate: false,
                      )));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}