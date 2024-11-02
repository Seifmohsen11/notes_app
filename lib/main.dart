import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/simple_block_observer.dart';
import 'package:notes_app/views/notes_view.dart';
import 'package:notes_app/views/splash_view.dart';
import 'package:notes_app/views/widgets/costants.dart';

import 'cubits/notes_cubit/notes_cubit.dart';
import 'models/note_model.dart';

void main() async {
  await Hive.initFlutter();
  Bloc.observer = SimpleBlockObserver();
  Hive.registerAdapter(NoteModelAdapter());
  await Hive.openBox<NoteModel>(kNotesBox);

  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotesCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark, fontFamily: "Poppins"),
        routes: {
          SplashView.id: (context) => SplashView(),
          NotesView.id: (context) => NotesView(),
        },
        initialRoute: SplashView.id,
      ),
    );
  }
}
