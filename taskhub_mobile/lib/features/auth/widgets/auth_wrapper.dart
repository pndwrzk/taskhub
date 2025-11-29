import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../tasks/screens/task_list_screen.dart';
import '../providers/auth_provider.dart';
import '../screens/login_screen.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return authState.when(
      data: (isLoggedIn) {
        if (isLoggedIn == true) {
          return const TaskListScreen();
        } else {
          return const LoginScreen();
        }
      },
      loading: () {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
      error: (err, stack) {
        return Scaffold(body: Center(child: Text("Oops… auth error")));
      },
    );
  }
}
