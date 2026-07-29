import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/config/theme.dart';
import 'package:frontend/cubit/brew/brew_cubit.dart';
import 'package:frontend/cubit/brew/brew_state.dart';
import 'package:frontend/screens/brew_list_screen.dart';
import 'package:frontend/services/api_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  runApp(const CoffeeApp());
}

class CoffeeApp extends StatelessWidget {
  const CoffeeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrewCubit(apiService: ApiService()),
      child: MaterialApp(
        title: 'Coffee Brew Log',
        debugShowCheckedModeBanner: false,
        theme: primaryTheme,
        home: const BrewListScreen(),
      ),
    );
  }
}