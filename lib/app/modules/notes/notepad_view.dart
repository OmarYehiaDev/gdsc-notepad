import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_notepad/app/modules/new_note/new_note_view.dart';
import 'package:gdsc_notepad/app/modules/notes/cubit/notes_cubit.dart';

class NotepadView extends StatelessWidget {
  const NotepadView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: BlocBuilder<NotesCubit, NotesState>(
        builder: (context, state) {
          final cubit = NotesCubit.of(context);
          if (state == NotesLoading()) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.orange.shade800,
              ),
            );
          }

          if (state == NotesEmpty()) {
            return const Text(
              "Empty",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            );
          }
          return Scaffold(
            extendBodyBehindAppBar: true,

            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    cubit.getNotes();
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 80,
                    horizontal: 30,
                  ),
                  child: const Text(
                    'Notepad',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                //search
                if (state == NotesSuccess() && cubit.notes.isNotEmpty)
                  ...cubit.notes
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(e.title),
                        ),
                      )
                      .toList(),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const NewNoteView();
                    },
                  ),
                );
              },
              backgroundColor: Colors.yellow,
              tooltip: 'Add note',
              child: const Icon(
                Icons.add,
                color: Colors.black,
                size: 40,
              ),
            ), // This trail
          );
        },
      ),
    );
  }
}
