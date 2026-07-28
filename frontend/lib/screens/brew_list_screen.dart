import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/config/theme.dart';
import 'package:frontend/cubit/brew/brew_cubit.dart';
import 'package:frontend/cubit/brew/brew_state.dart';
import 'brew_card.dart';
import 'brew_form.dart';

class BrewListScreen extends StatefulWidget {
  const BrewListScreen({super.key});

  @override
  State<BrewListScreen> createState() => _BrewListScreenState();
}

class _BrewListScreenState extends State<BrewListScreen> {
  String _selectedMethod = 'ALL';

  final List<String> _methodOptions = [
    'ALL',
    'V60',
    'Aeropress',
    'Drip coffee',
    'Espresso',
    'French Press',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Brew Log',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const BrewForm(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  )
                ],
              ), 
              
              const SizedBox(height: 20),

              // filter dropdown
              DropdownButtonFormField<String>(
                value: _selectedMethod,
                dropdownColor: AppColors.secondaryColor,
                style: TextStyle(color: AppColors.textColor, fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Filter by method',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  filled: true,
                  fillColor: AppColors.secondaryColor.withOpacity(0.5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(
                      color: AppColors.textColor.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: AppColors.textColor),
                  ),
                ),
                items: _methodOptions.map((String method) {
                  return DropdownMenuItem<String>(
                    value: method,
                    child: Text(
                      method == 'ALL' ? 'Filter by method' : method,
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedMethod = newValue;
                    });
                  }
                },
              ),

              const SizedBox(height: 16),

              // Brew list area
              Expanded(
                child: BlocBuilder<BrewCubit, BrewState>(
                  builder: (context, state) {
                    if (state is BrewLoading || state is BrewInitial) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is BrewError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Failed to load brews',
                              style: TextStyle(color: AppColors.textColor),
                            ),
                            const SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () =>
                                  context.read<BrewCubit>().loadBrews(),
                              child: const Text('Retry'),
                            ),
                          ],
                        )
                      );
                    }

                    if (state is BrewLoaded) {
                      // method filter applied locally
                      final filteredBrews = _selectedMethod == 'ALL'
                          ? state.brews
                          : state.brews
                              .where((brew) =>
                                  brew.brewMethod.toLowerCase() ==
                                  _selectedMethod.toLowerCase())
                              .toList();

                      if (filteredBrews.isEmpty) {
                        return Center(
                          child: Text(
                            'No brews found',
                            style: TextStyle(color: AppColors.textColor),
                          )
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: () async {
                          await context.read<BrewCubit>().loadBrews();
                        },
                        child: ListView.builder(
                          itemCount: filteredBrews.length,
                          itemBuilder: (context, index) {
                            final brew = filteredBrews[index];
                            return BrewCard(
                              brew: brew,
                              onEdit: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => 
                                        BrewForm(brew: brew),
                                  )
                                );
                              },
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}