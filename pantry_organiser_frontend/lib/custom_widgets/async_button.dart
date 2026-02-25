import 'package:flutter/material.dart';

class AsyncButton extends StatefulWidget {
  const AsyncButton({
    required this.child,
    this.onPressed,
    super.key,
    this.isLoading,
    this.width,
    this.height,
    this.backgroundColor,
    this.foregroundColor,
    this.borderRadius,
    this.padding,
  });

  final Widget child;
  final Future<void> Function()? onPressed;
  final bool? isLoading;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  @override
  State<AsyncButton> createState() => _AsyncButtonState();
}

class _AsyncButtonState extends State<AsyncButton> {
  bool _isLoading = false;

  void _handlePress() async {
    if (_isLoading || widget.onPressed == null) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await widget.onPressed!();
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = widget.isLoading ?? _isLoading;

    return ElevatedButton(
      onPressed: widget.onPressed == null || isLoading ? null : _handlePress,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.backgroundColor,
        foregroundColor: widget.foregroundColor,
        padding: widget.padding,
        minimumSize: Size(
          widget.width ?? 0,
          widget.height ?? 0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: widget.borderRadius ?? BorderRadius.circular(8),
        ),
      ),
      child: isLoading
          ? const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            )
          : widget.child,
    );
  }
}
