import 'package:flutter/material.dart';

import '../services/cache_helper.dart';
import '../services/cache_keys.dart';
import '../../features/auth/presentation/screens/register_screen.dart';

class GuestGuard {
  static void run(
      BuildContext context, {
        required VoidCallback onAuthenticated,
      }) {
    final bool isGuest =
        CacheHelper.getData(CacheKeys.isGuest) ?? false;

    if (isGuest) {
      _showGuestDialog(context);
      return;
    }

    onAuthenticated();
  }

  static void _showGuestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: const Text(
            "Guest Mode",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: const Text(
            "Please sign in or create an account to use this feature.",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Later"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterView(),
                  ),
                );
              },
              child: const Text("Sign In",style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }
}