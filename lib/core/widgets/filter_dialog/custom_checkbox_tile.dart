import 'package:flutter/material.dart';

class CustomCheckboxTile extends StatefulWidget {
  final String label;
  bool check;
  final void Function(bool)? onChange;

  CustomCheckboxTile(
      {super.key, required this.label, this.onChange, this.check = false});

  @override
  State<CustomCheckboxTile> createState() => _CustomCheckboxTileState();
}

class _CustomCheckboxTileState extends State<CustomCheckboxTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          visualDensity: VisualDensity.compact,
          value: widget.check,
          onChanged: (_) {
            setState(() {
              widget.check = !widget.check;
              if (widget.onChange != null) {
                widget.onChange!(widget.check);
              }
            });
          },
        ),
        Text(widget.label),
      ],
    );
  }
}