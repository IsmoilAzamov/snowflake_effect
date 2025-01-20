


import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'animated_filter_icon.dart';

class EnhancedSearchBar extends StatefulWidget {
  final ValueNotifier<bool>? filterNotifier;
  final TextEditingController controller;
  final VoidCallback? onFilterTap;
  final Function(String) onChanged;
  final String hintText;

  const EnhancedSearchBar({
    super.key,
    required this.filterNotifier,
    required this.controller,
    required this.onFilterTap,
    required this.onChanged,
    required this.hintText,
  });

  @override
  State<EnhancedSearchBar> createState() => _EnhancedSearchBarState();
}

class _EnhancedSearchBarState extends State<EnhancedSearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _focusAnimationController;
  late Animation<double> _elevationAnimation;
  late Animation<double> _scaleAnimation;
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _elevationAnimation = Tween<double>(
      begin: 1,
      end: 8,
    ).animate(CurvedAnimation(
      parent: _focusAnimationController,
      curve: Curves.easeOut,
    ));

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(
      parent: _focusAnimationController,
      curve: Curves.easeOut,
    ));

    _focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
    if (_focusNode.hasFocus) {
      _focusAnimationController.forward();
    } else {
      _focusAnimationController.reverse();
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _focusAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),

      child: AnimatedBuilder(
        animation: _focusAnimationController,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: _elevationAnimation.value,
                    spreadRadius: _elevationAnimation.value * 0.2,
                    offset: Offset(0, _elevationAnimation.value * 0.5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(28.0),
                child: Stack(
                  children: [
                    // Animated highlight border
                    if (_isFocused)
                      Positioned.fill(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(),
                        ),
                      ),
                    if (!_isFocused)
                      Positioned.fill(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(),
                        ),
                      ),
                    TextField(
                      focusNode: _focusNode,
                      controller: widget.controller,
                      decoration: InputDecoration(
                        hintText: widget.hintText,
                        hintStyle: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(12.0),
                          child: Icon(
                            Icons.search_rounded,
                            color: _isFocused
                                ? Theme.of(context).primaryColor
                                : Colors.grey[600],
                            size: 22,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0,
                          horizontal: 20.0,
                        ),
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (widget.controller.text.isNotEmpty)
                              _buildClearButton(),
                            if (widget.onFilterTap != null)
                              if (widget.filterNotifier != null)
                            _buildFilterButton(),
                          ],
                        ),
                      ),
                      style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                      ),
                      onChanged: widget.onChanged,
                      textAlignVertical: TextAlignVertical.center,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildClearButton() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 20,
      child: MaterialButton(
        padding: EdgeInsets.zero,
        shape: const CircleBorder(),
        onPressed: () {
          widget.controller.clear();
          widget.onChanged('');
          HapticFeedback.lightImpact();
        },
        child: Icon(
          Icons.close_rounded,
          size: 20,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildFilterButton() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: AnimatedFilterIcon(
        isActiveNotifier: widget.filterNotifier!,
        size: 42.0,
        activeColor: Colors.grey,
        inactiveColor: Colors.blue!,
        onTap: () {
          HapticFeedback.lightImpact();
          if (widget.onFilterTap != null) {
            widget.onFilterTap!();
          }
        },
      ),
    );
  }
}
