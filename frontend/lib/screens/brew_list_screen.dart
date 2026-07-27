import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/brew/brew_state.dart';
import '../cubit/brew/brew_cubit.dart';

class BrewListScreen extends StatelessWidget {
  const BrewListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coffee Brew Log'),
      ),
      floatingActionButton: FloatingActionButton(onPressed: onPressed),
      body: SafeArea(
        child: BlocBuilder<BrewCubit, BrewState>(
          builder: (context, state) {
            if (state is BrewLoading || state is BrewInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is BrewError) {
              return Center(child: Text(state.message));
            }

            if (state is BrewLoaded) {
              if (state.brews.isEmpty) {
                return Center(child: Text('No brews available yet.'));
              }
            }
          }
        )
      )
    );

  }
}