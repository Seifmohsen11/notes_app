import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/cubits/notes_cubit/notes_cubit.dart';
import 'package:notes_app/helper/show_snake_bar.dart';
import 'package:notes_app/views/widgets/custom_app_bar.dart';
import 'package:notes_app/views/widgets/custom_text_field.dart';

import '../../models/note_model.dart';

import 'edit_note_color_list.dart';

class EditNoteBody extends StatefulWidget {
  const EditNoteBody({super.key, required this.note});
  final NoteModel note;

  @override
  State<EditNoteBody> createState() => _EditNoteBodyState();
}

class _EditNoteBodyState extends State<EditNoteBody> {
  String? title, content;
  int currentIndex = 0;
  @override
  void initState() {
    currentIndex = widget.note.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            CustomAppBar(
              title: 'Edit Notes',
              icon: Icons.check,
              onPressed: () {
                widget.note.title = title ?? widget.note.title;
                widget.note.subTitle = content ?? widget.note.subTitle;
                widget.note.save();
                BlocProvider.of<NotesCubit>(context).fetchAllNotes();
                Navigator.pop(context);
                if (title != null ||
                    content != null ||
                    currentIndex != widget.note.color) {
                  return showSnackBar(context, "Note edited successfully");
                }
              },
            ),
            const SizedBox(
              height: 50,
            ),
            CustomTextField(
              onChange: (value) {
                title = value;
              },
              hintText: widget.note.title,
            ),
            const SizedBox(
              height: 16,
            ),
            CustomTextField(
              onChange: (value) {
                content = value;
              },
              hintText: widget.note.subTitle,
              maxLines: 5,
            ),
            const SizedBox(
              height: 24,
            ),
            EditNoteColorsList(note: widget.note),
          ],
        ),
      ),
    );
  }
}
