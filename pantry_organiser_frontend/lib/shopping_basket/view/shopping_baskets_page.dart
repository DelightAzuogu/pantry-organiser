import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_basket_by_unique_string.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_basket_response.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_widgets.dart';
import 'package:pantry_organiser_frontend/helpers/helpers.dart';
import 'package:pantry_organiser_frontend/shopping_basket/providers/shopping_basket_controller.dart';
import 'package:pantry_organiser_frontend/shopping_basket/shopping_basket.dart';

class ShoppingBasketsPage extends ConsumerStatefulWidget {
  const ShoppingBasketsPage({super.key});

  @override
  ConsumerState createState() => _ShoppingBasketsPageState();
}

class _ShoppingBasketsPageState extends ConsumerState<ShoppingBasketsPage> {
  late bool isLoading;
  late String? errorMessage;
  late List<GetShoppingBasketResponse> shoppingBaskets;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    errorMessage = null;
    shoppingBaskets = [];

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(shoppingBasketControllerProvider.notifier)
          .getOpenShoppingBaskets();
    });
  }

  void _onRefresh() {
    ref
        .read(shoppingBasketControllerProvider.notifier)
        .getOpenShoppingBaskets();
  }

  void _onBasketTap(GetShoppingBasketResponse basket) {
    ref.read(selectedShoppingBasketProvider.notifier).state = basket;

    Navigator.pushNamed(
      context,
      '/shoppingBasketDetails',
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    ref.listen(shoppingBasketControllerProvider, (_, next) {
      if (next.isLoading) {
        setState(() {
          isLoading = true;
          errorMessage = null;
        });
      } else if (next.errorMessage != null) {
        setState(() {
          isLoading = false;
          errorMessage = next.errorMessage;
        });
        showCustomToast(message: next.errorMessage!);
      }

      if (true == next.hasGottenBaskets) {
        setState(() {
          isLoading = false;
          errorMessage = null;
          shoppingBaskets = next.shoppingBaskets;
        });
      }
    });

    return CustomScaffold(
      title: 'Shopping Baskets',
      actions: [
        IconButton(
          icon: const Icon(Icons.group_add),
          tooltip: 'Join Basket',
          onPressed: () {
            _showJoinBasketDialog(context);
          },
        ),
      ],
      body: _buildBody(theme),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateBasketDialog(context);
        },
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (isLoading) {
      return const CustomLoadingWidget();
    }

    if (errorMessage != null) {
      return CustomErrorWidget(
        message: errorMessage!,
        onRetry: _onRefresh,
      );
    }

    if (shoppingBaskets.isEmpty) {
      return _buildEmptyState(theme);
    }

    return RefreshIndicator(
      onRefresh: () async {
        _onRefresh();
      },
      child: _buildBasketsList(theme),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_basket_outlined,
            size: 64,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No shopping baskets found',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Create your first shopping basket to get started',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: _onRefresh,
            icon: const Icon(Icons.refresh),
            label: const Text('Refresh'),
          ),
        ],
      ),
    );
  }

  Widget _buildBasketsList(ThemeData theme) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: shoppingBaskets.length,
      itemBuilder: (context, index) {
        final basket = shoppingBaskets[index];
        return ShoppingBasketCard(
          basket: basket,
          onTap: () => _onBasketTap(basket),
        );
      },
    );
  }

  void _showCreateBasketDialog(BuildContext context) {
    final nameController = TextEditingController();

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Shopping Basket'),
        content: TextField(
          controller: nameController,
          decoration: const InputDecoration(
            labelText: 'Basket Name',
            hintText: 'Enter basket name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          AsyncButton(
            onPressed: () async {
              if (nameController.text.trim().isEmpty) {
                await showCustomToast(message: 'Please enter a basket name');
                return;
              }

              await ref
                  .read(shoppingBasketControllerProvider.notifier)
                  .createShoppingBasket(nameController.text.trim());

              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Create'),
            ),
          ),
        ],
      ),
    );
  }

  void _showJoinBasketDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => const _JoinBasketDialog(),
    );
  }
}

class _JoinBasketDialog extends ConsumerStatefulWidget {
  const _JoinBasketDialog();

  @override
  ConsumerState<_JoinBasketDialog> createState() => _JoinBasketDialogState();
}

class _JoinBasketDialogState extends ConsumerState<_JoinBasketDialog> {
  final TextEditingController _uniqueCodeController = TextEditingController();
  bool _isSearching = false;
  bool _isJoining = false;
  String? _errorMessage;

  @override
  void dispose() {
    _uniqueCodeController.dispose();
    super.dispose();
  }

  Future<void> _searchAndJoinBasket() async {
    final uniqueCode = _uniqueCodeController.text.trim();

    if (uniqueCode.isEmpty) {
      await showCustomToast(message: 'Please enter a basket code');
      return;
    }

    setState(() {
      _isSearching = true;
      _errorMessage = null;
    });

    try {
      // First, search for the basket
      final basket = await ref.read(
        getShoppingBasketByUniqueStringProvider(
          uniqueString: uniqueCode,
        ).future,
      );

      setState(() {
        _isSearching = false;
      });

      if (!mounted) return;

      // Show confirmation dialog with basket details
      final shouldJoin = await showDialog<bool>(
        context: context,
        builder: (context) => _BasketConfirmationDialog(basket: basket),
      );

      if (shouldJoin == true && mounted) {
        setState(() {
          _isJoining = true;
        });

        // Join the basket
        await ref.read(
          joinShoppingBasketByUniqueStringProvider(
            uniqueString: uniqueCode,
          ).future,
        );

        if (mounted) {
          await showCustomToast(
            message: 'Successfully joined "${basket.name}"!',
            backgroundColor: Colors.green,
          );

          // Refresh the baskets list
          ref.invalidate(getUserOpenShoppingBasketsProvider);
          ref
              .read(shoppingBasketControllerProvider.notifier)
              .getOpenShoppingBaskets();

          // Close both dialogs
          Navigator.of(context).pop();
        }
      }
    } catch (e) {
      setState(() {
        _isSearching = false;
        _isJoining = false;
        _errorMessage =
            'Basket not found. Please check the code and try again.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.group_add,
            color: colorScheme.primary,
          ),
          const SizedBox(width: 8),
          const Text('Join Shopping Basket'),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter the unique code shared with you to join a shopping basket',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _uniqueCodeController,
              decoration: InputDecoration(
                labelText: 'Basket Code',
                hintText: 'Enter basket code',
                prefixIcon: const Icon(Icons.vpn_key),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                errorText: _errorMessage,
              ),
              textCapitalization: TextCapitalization.characters,
              onSubmitted: (_) => _searchAndJoinBasket(),
            ),
            if (_isSearching || _isJoining) ...[
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    _isJoining ? 'Joining basket...' : 'Searching...',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isSearching || _isJoining
              ? null
              : () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          onPressed: _isSearching || _isJoining ? null : _searchAndJoinBasket,
          icon: const Icon(Icons.search),
          label: const Text('Search & Join'),
        ),
      ],
    );
  }
}

class _BasketConfirmationDialog extends StatelessWidget {
  const _BasketConfirmationDialog({required this.basket});

  final GetShoppingBasketByUniqueStringResponse basket;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: const Text('Basket Found!'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.shopping_basket,
                  size: 48,
                  color: colorScheme.onPrimaryContainer,
                ),
                const SizedBox(height: 12),
                Text(
                  basket.name,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.onPrimaryContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.surface,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.person,
                        size: 16,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Owner: ${basket.ownerName}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (basket.isClosed) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: colorScheme.onErrorContainer,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'This basket is closed and cannot be joined',
                      style: TextStyle(
                        color: colorScheme.onErrorContainer,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Would you like to join this shopping basket?',
                      style: theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancel'),
        ),
        if (!basket.isClosed)
          FilledButton.icon(
            onPressed: () => Navigator.of(context).pop(true),
            icon: const Icon(Icons.check),
            label: const Text('Join Basket'),
          ),
      ],
    );
  }
}
