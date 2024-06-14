import 'package:flutter/material.dart';

class NeuBox extends StatelessWidget {
  const NeuBox({super.key, required this.child, required this.isDark});
  final Widget child;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: isDark ? Colors.transparent : Colors.grey.shade400,
                offset: Offset(4, 4),
                blurRadius: 15,
              ),
              BoxShadow(
                  color: isDark ? Colors.transparent : Colors.grey.shade400,
                  offset: Offset(-4, -4),
                  blurRadius: 15),
            ],
            color: Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(15)),
        child: child);
  }
}
