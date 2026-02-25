import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_basket_response.dart';
import 'package:pantry_organiser_frontend/api/model/shopping_basket/get_shopping_users_response.dart';
import 'package:pantry_organiser_frontend/custom_widgets/custom_widgets.dart';
import 'package:pantry_organiser_frontend/helpers/helpers.dart';
import 'package:pantry_organiser_frontend/shopping_basket/providers/shopping_basket_providers.dart';

class BasketUsersPage extends ConsumerStatefulWidget {
  const BasketUsersPage({super.key});

  @override
  ConsumerState<BasketUsersPage> createState() => _BasketUsersPageState();
}

class _BasketUsersPageState extends ConsumerState<BasketUsersPage> {
  late GetShoppingBasketResponse basket;

  @override
  void initState() {
    super.initState();
    final selectedBasket = ref.read(selectedShoppingBasketProvider);
    if (selectedBasket == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.of(context).pop();
        }
      });
    } else {
      basket = selectedBasket;
    }
  }

  Future<void> _refreshUsers() async {
    ref.invalidate(getShoppingBasketUsersProvider(basketId: basket.id));
  }

  void _showRemoveUserDialog(
    BuildContext context,
    GetShoppingBasketUsersResponse user,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove User'),
        content: Text(
          'Are you sure you want to remove "${user.userEmail}" from this basket? '
          'They will no longer have access to it.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          AsyncButton(
            onPressed: () async {
              try {
                await ref.read(
                  removeUserFromShoppingBasketProvider(
                    basketId: basket.id,
                    userId: user.userId,
                  ).future,
                );

                if (context.mounted) {
                  await showCustomToast(
                    message: '${user.userEmail} removed from basket',
                  );
                  _refreshUsers();
                  Navigator.of(context).pop();
                }
              } catch (e) {
                if (context.mounted) {
                  await showCustomToast(
                    message: 'Failed to remove user',
                  );
                  Navigator.of(context).pop();
                }
              }
            },
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('Remove'),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final asyncValue = ref.watch(
      getShoppingBasketUsersProvider(basketId: basket.id),
    );

    return CustomScaffold(
      title: 'Basket Users',
      body: asyncValue.when(
        data: (users) {
          return RefreshIndicator(
            onRefresh: _refreshUsers,
            child: _buildContent(theme, users),
          );
        },
        loading: () => const CustomLoadingWidget(),
        error: (error, stackTrace) => CustomErrorWidget(
          onRetry: _refreshUsers,
          message: 'Failed to load users',
        ),
      ),
    );
  }

  Widget _buildContent(
    ThemeData theme,
    List<GetShoppingBasketUsersResponse> users,
  ) {
    if (users.isEmpty) {
      return _buildEmptyState(theme);
    }

    // Sort users to show owner first
    final sortedUsers = List<GetShoppingBasketUsersResponse>.from(users);

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: sortedUsers.length,
      itemBuilder: (context, index) {
        final user = sortedUsers[index];
        // Since we're on this page, we're the owner (basket.isOwner is true)
        // We can't remove ourselves, so check if this is our user entry
        return _buildUserCard(theme, user, index == 0 && basket.isOwner);
      },
    );
  }

  Widget _buildUserCard(
    ThemeData theme,
    GetShoppingBasketUsersResponse user,
    bool isOwner,
  ) {
    // Extract name from email (before @)
    final displayName = user.userEmail.split('@').first;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        leading: CircleAvatar(
          backgroundColor: isOwner
              ? theme.colorScheme.primary
              : theme.colorScheme.secondaryContainer,
          child: Text(
            user.userEmail.isNotEmpty ? user.userEmail[0].toUpperCase() : 'U',
            style: TextStyle(
              color: isOwner
                  ? theme.colorScheme.onPrimary
                  : theme.colorScheme.onSecondaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          displayName,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          user.userEmail,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        trailing: isOwner
            ? Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Owner',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            : IconButton(
                icon: const Icon(Icons.person_remove),
                color: Colors.red,
                tooltip: 'Remove user',
                onPressed: () => _showRemoveUserDialog(context, user),
              ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_outline,
            size: 64,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            'No users in this basket',
            style: theme.textTheme.headlineSmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Share the basket to add users',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}
