import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/brew/brew_cubit.dart';

var uuid = const Uuid(); //use this to generate new unique random IDs for brews

class BrewForm extends StatefulWidget {
  const BrewForm({super.key});

  @override
  State<BrewForm> createState() => _BrewFormState();
}

class _BrewFormState extends State<BrewForm> {
  final _roasterController = TextEditingController();
  final _brewMethodController = TextEditingController();
  final _coffeeWeightController = TextEditingController();
  final _waterWeightController = TextEditingController();
  final _grindSizeController = TextEditingController();
  final _ratingController = TextEditingController();
  final _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    _roasterController.dispose();
    _brewMethodController.dispose();
    _coffeeWeightController.dispose();
    _waterWeightController.dispose();
    _grindSizeController.dispose();
    _ratingController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // building the payload to match the fastapi structure
      final brewData = {
        'roaster': _roasterController.text.trim(),
        'brew_method': _brewMethodController.text.trim(),
        'coffee_weight': double.tryParse(_coffeeWeightController.text) ?? 0.0,
        'water_weight': double.tryParse(_waterWeightController.text) ?? 0.0,
        'grind_size': int.tryParse(_grindSizeController.text) ?? 0,
        'rating': int.tryParse(_ratingController.text) ?? 0,
        'notes': _notesController.text.trim(),
      };

      // send to the BrewCubit
      context.read<BrewCubit>().addBrew(brewData);

      // close the form 
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Brew'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Roaster
                TextFormField(
                  controller: _roasterController,
                  decoration: const InputDecoration(
                    labelText: 'Roaster / Bean Name',
                    icon: Icon(Icons.coffee),
                  ),
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Enter roaster name' : null,
                ),
                const SizedBox(height: 12),

                // Method 
                //TODo: This seems like it has to be a drop down menu for the user to select from an existing list of options
                //TODO: Change this in the FastAPI code as well
                TextFormField(
                  controller: _brewMethodController,
                  decoration: const InputDecoration(
                    labelText:'Method',
                    icon: Icon(Icons.coffee_maker),
                  ),
                  validator: (value) =>
                  value == null || value.isEmpty ? 'Select a method' : null,
                ),
                const SizedBox(height: 12),

                // water and coffee weight
                Row(
                  children: [
                    TextFormField(
                      controller: _coffeeWeightController,
                      decoration: const InputDecoration(
                        labelText: 'Coffer (grams)',
                        icon: Icon(Icons.scale),
                      ),
                      validator: (value) =>
                            value == null || value.isEmpty ? '0' : null,
                    ),
                    const SizedBox(width: 8),

                    // water weight
                    TextFormField(
                      controller: _waterWeightController,
                      decoration: const InputDecoration(
                        labelText: 'Water',
                        icon: Icon(Icons.water),
                      ),
                      validator: (value) =>
                            value == null || value.isEmpty ? '0' : null,
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                //rating
                //TODO: Make this a selector type thing where the user clicks on a button with a counter type thing
                TextFormField(
                  controller: _ratingController,
                  decoration: const InputDecoration(
                    labelText: 'Raing: 1-5',
                    icon: Icon(Icons.star),
                  ),
                  validator: (value) =>
                        value == null || value.isEmpty ? 'Rate out of 5' : null,
                ),
                const SizedBox(height: 12),

                // notes 
                TextFormField(
                  controller: _notesController,
                  decoration: const InputDecoration(
                    labelText: 'Notes',
                    icon: Icon(Icons.notes),
                  ),
                  validator: (value) =>
                        value == null || value.isEmpty ? 'Tasting Notes' : null
                ),
                const SizedBox(height: 24),

                // Save button
                ElevatedButton(
                  onPressed: _submitForm,
                  child: const Text('Save Brew')
                )
              ],
            ),
          )
        ),
      )
    );
  }
}

