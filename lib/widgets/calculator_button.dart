import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';

/// Custom calculator button widget
class CalculatorButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonType type;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = ButtonType.number,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) => _controller.reverse());
    widget.onPressed();
  }

  Color _getButtonColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (widget.type) {
      case ButtonType.number:
        return isDark ? AppTheme.numberButtonDark : AppTheme.numberButtonLight;
      case ButtonType.operator:
        return isDark ? AppTheme.operatorButtonDark : AppTheme.operatorButtonLight;
      case ButtonType.equals:
        return isDark ? AppTheme.equalsButtonDark : AppTheme.equalsButtonLight;
      case ButtonType.function:
        return isDark ? AppTheme.functionButtonDark : AppTheme.functionButtonLight;
    }
  }

  Color _getTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    switch (widget.type) {
      case ButtonType.number:
        return isDark ? Colors.white : Colors.black87;
      case ButtonType.operator:
        return isDark ? Colors.white : AppTheme.primaryLight;
      case ButtonType.equals:
        return Colors.white;
      case ButtonType.function:
        return isDark ? Colors.white : Colors.red.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Material(
        color: _getButtonColor(context),
        borderRadius: BorderRadius.circular(16),
        elevation: widget.type == ButtonType.equals ? 4 : 1,
        shadowColor: widget.type == ButtonType.equals ? AppTheme.primaryLight.withOpacity(0.3) : Colors.black12,
        child: InkWell(
          onTap: _handleTap,
          borderRadius: BorderRadius.circular(16),
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: Center(
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: widget.type == ButtonType.equals ? 32 : 24,
                  fontWeight: widget.type == ButtonType.equals ? FontWeight.w600 : FontWeight.w500,
                  color: _getTextColor(context),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Enum for button types
enum ButtonType {
  number,
  operator,
  equals,
  function,
}
