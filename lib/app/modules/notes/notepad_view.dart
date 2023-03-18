import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_notepad/app/modules/new_note/new_note_view.dart';
import 'package:gdsc_notepad/app/modules/notes/cubit/notes_cubit.dart';
import 'package:gdsc_notepad/app/utils/context_helpers.dart';
import 'package:gdsc_notepad/app/utils/helper_functions.dart';
import 'package:intl/intl.dart';

import '../../models/note.dart';

class NotepadView extends StatelessWidget {
  const NotepadView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesCubit>(
      create: (context) {
        final cubit = NotesCubit();
        cubit.getNotes();
        return cubit;
      },
      child: BlocConsumer<NotesCubit, NotesState>(
        listener: (context, state) {
          if (state is NotesSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                backgroundColor: Colors.green,
                content: Center(
                  child: Text(
                    "We have the notes",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }
        },
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final cubit = NotesCubit.of(context);
          if (state is NotesLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(
                  color: Colors.orange.shade800,
                ),
              ),
            );
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              toolbarHeight: kToolbarHeight + 20,
              title: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Notaty',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
              elevation: 0,
              actions: [
                IconButton(
                  onPressed: () {
                    cubit.refreshNotesList();
                  },
                  icon: const Icon(
                    Icons.refresh,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            body: state is NotesEmpty
                ? const Center(
                    child: Text(
                      "Empty Data :\"(",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  )
                : ListView.separated(
                    itemBuilder: (context, index) {
                      Note e = cubit.notes.reversed.toList()[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: const EdgeInsets.all(16),
                        color: Helpers.switchColors(e.importance),
                        child: SizedBox(
                          width: context.width * 0.8,
                          child: ListTile(
                            title: Text(
                              e.title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              e.content,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey.shade200,
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.watch_later,
                                    color: Colors.white,
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      DateFormat.yMMMd().format(
                                        e.lastUpdatedAt,
                                      ),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      DateFormat.jm().format(e.lastUpdatedAt),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        height: 16,
                        indent: context.width * 0.25,
                        endIndent: context.width * 0.25,
                        thickness: 1,
                        color: Colors.black,
                      );
                    },
                    itemCount: cubit.notes.length,
                  ),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.abc),
                  label: "ABC",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.abc),
                  label: "ABC",
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.abc),
                  label: "ABC",
                ),
              ],
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                bool? res = await Navigator.push<bool>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const NewNoteView(),
                  ),
                );
                if (res != null && res) cubit.refreshNotesList();
              },
              backgroundColor: Colors.orange,
              tooltip: 'Add note',
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
            ), // This trail
          );
        },
      ),
    );
  }
}
