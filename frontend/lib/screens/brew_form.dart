import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/cubit/brew/brew_cubit.dart';
import 'package:frontend/models/brew.dart';

class BrewForm extends StatefulWidget {
  final Brew? brew; // Null = Create mode | Not null = Edit mode

  const BrewForm({
    super.key,
    this.brew,
  });


  @override
  State<BrewForm> createState() => _BrewFormState();
}

class _BrewFormState extends State<BrewForm> {
  final _roasterController = TextEditingController();
  final _coffeeWeightController = TextEditingController();
  final _waterWeightController = TextEditingController();
  final _ratingController = TextEditingController();
  final _notesController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final List<String> _brewMethods = [
    'V60',
    'AeroPress',
    'Drip Coffee',
    'French Press',
    'Espresso',
    'French Press',
    'Chemex',
    'Moka Pot',
  ];
  String? _selectedBrewMethod;

  int _rating = 3; // Default rating

  @override
  void initState() {
    super.initState();
    if (widget.brew != null) {
      final brew = widget.brew!;
      _roasterController.text = brew.roasterName;
      _selectedBrewMethod = brew.brewMethod;
      _coffeeWeightController.text = brew.coffeeWeight.toString();
      _waterWeightController.text = brew.waterWeight.toString();
      _rating = brew.rating;
      _notesController.text = brew.notes ?? '';
    }
  }


  @override
  void dispose() {
    _roasterController.dispose();
    _coffeeWeightController.dispose();
    _waterWeightController.dispose();
    _ratingController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // building the payload to match the fastapi structure
      final brewData = {
        'roaster_name': _roasterController.text.trim(),
        'brew_method': _selectedBrewMethod, // uses selected dropdown value
        'coffee_weight': int.parse(_coffeeWeightController.text.trim()),
        'water_weight': int.parse(_waterWeightController.text.trim()),
        'rating': _rating, // Uses counter state integer
        'notes': _notesController.text.trim(),
      };

      if (widget.brew == null) {
        // Create Mode
        context.read<BrewCubit>().addBrew(brewData);
      } else {
        // Edit Mode
        context.read<BrewCubit>().updateBrew(widget.brew!.id, brewData);
      }

      // close the form 
      Navigator.of(context).pop();
    }
  }

  void _deleteBrew() {
    if (widget.brew != null) {
      context.read<BrewCubit>().deleteBrew(widget.brew!.id);
      Navigator.of(context).pop();
    }
  }

  bool get isEditing => widget.brew != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Brew' : 'Add New Brew'),
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
                DropdownButtonFormField<String>(
                  value: _selectedBrewMethod,
                  decoration: const InputDecoration(
                    labelText: 'Brew Method',
                    icon: Icon(Icons.coffee_maker),
                  ),
                  items: _brewMethods.map((method) {
                    return DropdownMenuItem(
                      value: method,
                      child: Text(method), 
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedBrewMethod = value;
                    });
                  },
                  validator: (value) =>
                      value == null || value.isEmpty ? 'Select a brew method' : null,
                ),
                const SizedBox(height: 12), 

                // water and coffee weight
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _coffeeWeightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Coffee (g)',
                          icon: Icon(Icons.scale),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter weight';
                          }
                          if (int.tryParse(value.trim()) == null) {
                            return 'Enter valid number';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 8),

                    // water weight
                    Expanded(
                      child: TextFormField(
                        controller: _waterWeightController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Water (g)',
                          icon: Icon(Icons.water),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter weight';
                          }
                          if (int.tryParse(value.trim()) == null) {
                            return 'Enter valid number';
                          }
                          return null;
                        }
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                //rating
                TextFormField(
                  key: ValueKey(_rating), // Ensure field updates when state changes
                  readOnly: true, // to prevent the keyboard from popping up
                  initialValue: '$_rating / 5',
                  decoration: InputDecoration(
                    labelText: 'Rating',
                    icon: const Icon(Icons.star),
                    prefixIcon: IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: _rating > 1
                          ? () {
                            setState(() {
                              _rating--;
                            });
                          }
                        : null, // Disabled at 1
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: _rating < 5
                          ? () {
                            setState(() {
                              _rating++;
                            });
                          }
                        : null, // Disabled at 5  
                    ),
                  ),
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

                // Dynamic Action Buttons
                if (isEditing)
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: _deleteBrew,
                          icon: const Icon(Icons.delete, color: Colors.red,),
                          label: const Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _submitForm,
                          child: const Text('Update Brew'),
                        ),
                      ),
                    ],
                  )
                else 
                  // Save button
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: const Text('Save Brew')
                  ),
              ],
            ),
          )
        ),
      )
    );
  }
}