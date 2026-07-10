import 'package:arctive/core/models/app_user.dart';
import 'package:arctive/core/services/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DebugRoleSwitcher extends ConsumerWidget {
  const DebugRoleSwitcher({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentAppUserProvider);
    final notifier = ref.read(currentAppUserProvider.notifier);

    return Material(
      color: Colors.transparent,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 360),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF0B1629).withOpacity(0.96),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF1E293B)),
          boxShadow: const [
            BoxShadow(
              color: Colors.black54,
              blurRadius: 24,
              offset: Offset(0, 12),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Debug Role Switcher',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              currentUser == null
                  ? 'Signed out'
                  : '${currentUser.name} • ${currentUser.role.name}',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: const Color(0xFFCBD5E1)),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _roleButton(context, notifier, UserRole.superAdmin),
                _roleButton(context, notifier, UserRole.admin),
                _roleButton(context, notifier, UserRole.analyst),
                _roleButton(context, notifier, UserRole.viewer),
                _roleButton(context, notifier, UserRole.scanner),
                TextButton(
                  onPressed: notifier.signOut,
                  child: const Text('Sign out'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _roleButton(
    BuildContext context,
    CurrentAppUser notifier,
    UserRole role,
  ) {
    return FilledButton.tonal(
      onPressed: () => notifier.switchRole(role),
      child: Text(role.name),
    );
  }
}
