import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:notes_app/helper/show_snake_bar.dart';
import 'package:notes_app/models/note_model.dart';

import 'colors_list_view.dart';
import 'custom_bottom.dart';
import 'custom_text_field.dart';

class AddNoteForm extends StatefulWidget {
  const AddNoteForm({
    super.key,
  });

  @override
  State<AddNoteForm> createState() => _AddNoteFormState();
}

class _AddNoteFormState extends State<AddNoteForm> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? title, subTitle;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          CustomTextField(
            onSaved: (value) {
              title = value;
            },
            hintText: 'Title',
          ),
          SizedBox(
            height: 18,
          ),
          CustomTextField(
            onSaved: (value) {
              subTitle = value;
            },
            hintText: 'Content',
            maxLines: 5,
          ),
          const SizedBox(
            height: 24,
          ),
          const ColorsListView(),
          const SizedBox(
            height: 24,
          ),
          BlocBuilder<AddNoteCubit, AddNoteState>(
            builder: (context, state) {
              return CustomBottom(
                isLoading: state is AddNoteLoading ? true : false,
                onTap: () {
                  var currentDate = DateTime.now();
                  var formatedCurrentDate =
                      DateFormat('EEEE, dd/MM/yyyy').format(currentDate);
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    var noteModel = NoteModel(
                        title: title!,
                        subTitle: subTitle!,
                        date: formatedCurrentDate,
                        color: Colors.blue.value);
                    BlocProvider.of<AddNoteCubit>(context).addNote(noteModel);
                    showSnackBar(context, 'note added successfully');
                  } else {
                    autovalidateMode = AutovalidateMode.always;
                    setState(() {});
                  }
                },
              );
            },
          ),
          const SizedBox(
            height: 45,
          ),
        ],
      ),
    );
  }
}
