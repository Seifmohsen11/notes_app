import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';

import 'custom_note_item.dart';

class NotesListView extends StatefulWidget {
  const NotesListView({super.key});

  @override
  State<NotesListView> createState() => _NotesListViewState();
}

class _NotesListViewState extends State<NotesListView> {
  final ScrollController controller = ScrollController();
  int previousNoteCount = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        List<NoteModel> notes =
            BlocProvider.of<NotesCubit>(context).notes ?? [];

        if (notes.length > previousNoteCount) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            controller.animateTo(
              controller.position.maxScrollExtent,
              duration: const Duration(milliseconds: 500),
              curve: Curves.fastOutSlowIn,
            );
          });
        }

        previousNoteCount = notes.length;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: ListView.builder(
            reverse: true,
            controller: controller,
            itemCount: notes.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: NoteItem(
                  note: notes[index],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
