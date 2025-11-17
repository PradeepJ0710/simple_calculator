import 'package:flutter/material.dart';

/// Display section showing expression and result
class DisplaySection extends StatelessWidget {
  final String expression;
  final String displayValue;
  final bool isError;

  const DisplaySection({
    super.key,
    required this.expression,
    required this.displayValue,
    required this.isError,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? theme.colorScheme.surface : theme.scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // Expression display
          if (expression.isNotEmpty)
            AnimatedOpacity(
              opacity: expression.isNotEmpty ? 1.0 : 0.0,
              duration: const Duration(milliseconds: 200),
              child: Text(
                expression,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: isDark ? Colors.white60 : Colors.black54,
                  fontSize: 20,
                ),
                textAlign: TextAlign.right,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),

          const SizedBox(height: 8),

          // Main display value
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              displayValue,
              style: theme.textTheme.displayLarge?.copyWith(
                fontSize: 56,
                fontWeight: FontWeight.w300,
                color: isError ? Colors.red : (isDark ? Colors.white : Colors.black87),
              ),
              textAlign: TextAlign.right,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}
