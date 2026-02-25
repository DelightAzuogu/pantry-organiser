import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:markdown_widget/markdown_widget.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_scaffold.dart';
import 'package:pantry_organiser_frontend/pantry/providers/get_user_pantries.dart';
import 'package:pantry_organiser_frontend/recipe/providers/gemini_recommendation_provider.dart';

class GeminiRecommendation extends ConsumerStatefulWidget {
  const GeminiRecommendation({super.key});

  @override
  ConsumerState createState() => _GeminiRecommendationState();
}

class _GeminiRecommendationState extends ConsumerState<GeminiRecommendation> {
  final _instructionController = TextEditingController();
  final _scrollController = ScrollController();
  final _selectedPantryIds = <String>{};

  @override
  void dispose() {
    _instructionController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _getRecommendation() async {
    final controller =
        ref.read(geminiRecommendationControllerProvider.notifier);
    await controller.getRecommendation(
      pantryIds: _selectedPantryIds.isEmpty ? [] : _selectedPantryIds.toList(),
      instructionPrompt: _instructionController.text.trim(),
    );

    // Scroll to latest
    await Future.delayed(const Duration(milliseconds: 300));
    if (_scrollController.hasClients) {
      await _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(geminiRecommendationControllerProvider);
    final pantryAsync = ref.watch(getUserPantriesProvider);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    final markdownConfig = isDark
        ? MarkdownConfig.darkConfig.copy(
            configs: [
              const PConfig(textStyle: TextStyle(fontSize: 15, height: 1.6)),
            ],
          )
        : MarkdownConfig.defaultConfig.copy(
            configs: [
              const PConfig(textStyle: TextStyle(fontSize: 15, height: 1.6)),
            ],
          );

    return CustomScaffold(
      title: 'Gemini Recommendation',
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Recommendations List
            Expanded(
              child: pantryAsync.when(
                data: (pantries) {
                  String getPantryName(String id) =>
                      pantries.firstWhere((p) => p.id == id).name;

                  if (state.recommendations.isEmpty) {
                    return const Center(
                      child: Text(
                        'No recommendations yet.\nRequest one to get started!',
                        textAlign: TextAlign.center,
                      ),
                    );
                  }

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: state.recommendations.length,
                    itemBuilder: (context, index) {
                      final rec = state.recommendations[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Instruction
                              Text(
                                rec.instruction == null ||
                                        rec.instruction!.isEmpty
                                    ? 'Instruction: (none provided)'
                                    : 'Instruction: ${rec.instruction!}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(height: 8),

                              // Pantry chips (optional)
                              if (rec.pantries.isNotEmpty)
                                Wrap(
                                  spacing: 6,
                                  runSpacing: -6,
                                  children: rec.pantries
                                      .map(
                                        (id) => Chip(
                                          label: Text(getPantryName(id)),
                                          visualDensity: VisualDensity.compact,
                                        ),
                                      )
                                      .toList(),
                                ),
                              if (rec.pantries.isNotEmpty)
                                const SizedBox(height: 8),

                              // Recommendation text
                              MarkdownWidget(
                                data: rec.text,
                                config: markdownConfig,
                                shrinkWrap: true,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (err, _) => Text('Error loading pantries: $err'),
              ),
            ),

            const SizedBox(height: 12),

            // Pantry selector + chips
            pantryAsync.when(
              data: (pantries) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_selectedPantryIds.isNotEmpty)
                    Wrap(
                      spacing: 6,
                      children: _selectedPantryIds.map((id) {
                        final name =
                            pantries.firstWhere((p) => p.id == id).name;
                        return Chip(
                          label: Text(name),
                          onDeleted: () =>
                              setState(() => _selectedPantryIds.remove(id)),
                        );
                      }).toList(),
                    ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Select Pantry Item (optional)',
                      border: OutlineInputBorder(),
                    ),
                    items: pantries
                        .map(
                          (p) => DropdownMenuItem(
                            value: p.id,
                            child: Text(p.name),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null &&
                          !_selectedPantryIds.contains(value)) {
                        setState(() => _selectedPantryIds.add(value));
                      }
                    },
                  ),
                ],
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text('Error loading pantries: $err'),
            ),

            const SizedBox(height: 12),

            // Input & Button
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _instructionController,
                    decoration: const InputDecoration(
                      hintText: 'Optional: e.g. "a quick breakfast idea"',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: state.isLoading ? null : _getRecommendation,
                  child: state.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Ask'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
