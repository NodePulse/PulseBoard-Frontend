import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pulseboard_frontend/features/authentication/presentation/notifier/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);
    final user = authState.user;

    return Center(
      child: user == null
          ? const Text('User not found')
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (user.avatarUrl != null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(user.avatarUrl!),
                  )
                else
                  CircleAvatar(
                    radius: 50,
                    child: Text(
                      '${user.firstName[0]}${user.lastName[0]}',
                      style: const TextStyle(fontSize: 32),
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  '${user.firstName} ${user.lastName}',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 8),
                Text(user.email, style: Theme.of(context).textTheme.bodyLarge),
                const SizedBox(height: 8),
                Chip(
                  label: Text('Plan: ${user.plan}'),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                ),
              ],
            ),
    );
  }
}
