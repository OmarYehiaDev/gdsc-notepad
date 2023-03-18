import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_notepad/app/models/note_importance.dart';
import 'package:gdsc_notepad/app/modules/new_note/cubit/new_note_cubit.dart';
import 'package:gdsc_notepad/app/utils/context_helpers.dart';
import 'package:intl/intl.dart';

import '../../utils/helper_functions.dart';

class NewNoteView extends StatelessWidget {
  const NewNoteView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: BlocProvider<NewNoteCubit>(
        create: (context) => NewNoteCubit(),
        child: BlocBuilder<NewNoteCubit, NewNoteState>(
          builder: (context, state) {
            final cubit = NewNoteCubit.of(context);
            if (state is NewNoteLoading) {
              return Center(
                child: CircularProgressIndicator(
                  color: Colors.orange.shade800,
                ),
              );
            }
            return Scaffold(
              appBar: AppBar(
                iconTheme: const IconThemeData(
                  color: Colors.yellow, //change your color here
                ),
                backgroundColor: Colors.white,
                title: const Text(
                  'Note',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                elevation: 0,
                actions: [
                  PopupMenuButton(
                    icon: const Icon(Icons.share),
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          child: Text('Share as image'),
                        ),
                        const PopupMenuItem(
                          child: Text('Share as Text'),
                        ),
                      ];
                    },
                  ),
                  PopupMenuButton(
                    icon: const Icon(Icons.menu),
                    itemBuilder: (context) {
                      return [
                        const PopupMenuItem(
                          child: Text('Delete'),
                        ),
                        const PopupMenuItem(
                          child: Text('Save'),
                        ),
                      ];
                    },
                  )
                ],
              ),
              body: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 5),
                              child: Text(
                                DateFormat.yMMMMd().format(cubit.note.lastUpdatedAt),
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            Text(
                              DateFormat.jm().format(cubit.note.lastUpdatedAt),
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          bottom: 10,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, right: 5),
                              child: Text(
                                "Charachters: ${cubit.charsNumber} char",
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 11,
                                ),
                              ),
                            ),
                            Text(
                              "Words: ${cubit.wordsNumber} word",
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  //title
                  SizedBox(
                    width: context.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            child: TextFormField(
                              maxLines: 1,
                              controller: cubit.titleCtrl,
                              decoration: const InputDecoration.collapsed(
                                hintText: "Title",
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: context.width * 0.325,
                          child: Center(
                            child: DropdownButton<NoteImportance>(
                              alignment: AlignmentDirectional.center,
                              value: cubit.note.importance,
                              selectedItemBuilder: (context) => NoteImportance.values
                                  .map(
                                    (e) => DropdownMenuItem<NoteImportance>(
                                      value: e,
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: e == cubit.note.importance
                                              ? Helpers.switchColors(e)
                                              : Colors.white,
                                          borderRadius: BorderRadius.circular(15),
                                        ),
                                        child: Text(
                                          e.name.toUpperCase(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              items: NoteImportance.values
                                  .map(
                                    (e) => DropdownMenuItem<NoteImportance>(
                                      value: e,
                                      child: Text(
                                        e.name.toUpperCase(),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                              onChanged: cubit.changeImportance,
                              underline: const SizedBox.shrink(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //body
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 32,
                    ),
                    child: TextFormField(
                      controller: cubit.contentCtrl,
                      textInputAction: TextInputAction.newline,
                      minLines: 1,
                      maxLines: null,
                      maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Note something down",
                      ),
                    ),
                  ),
                ],
              ),
              persistentFooterAlignment: AlignmentDirectional.center,
              persistentFooterButtons: [
                OutlinedButton(
                  onPressed: () {
                    cubit.saveNote(context);
                  },
                  style: ButtonStyle(
                    alignment: AlignmentDirectional.center,
                    backgroundColor: MaterialStatePropertyAll(
                      Colors.amber.shade800,
                    ),
                  ),
                  child: const Text(
                    "Save note & Go back",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: const Color.fromARGB(255, 174, 174, 166),
                fixedColor: Colors.black,
                items: const [
                  BottomNavigationBarItem(
                    label: "Album",
                    icon: Icon(
                      Icons.add_a_photo,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "To do list",
                    icon: Icon(
                      Icons.list_alt,
                    ),
                  ),
                  BottomNavigationBarItem(
                    label: "Remoinder",
                    icon: Icon(
                      Icons.notifications,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
