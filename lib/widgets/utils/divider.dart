import 'package:flutter/material.dart';

class ThemedDivider extends StatelessWidget {
  const ThemedDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: Theme.of(context).colorScheme.primary,
      thickness: 1,
    );
  }
}
