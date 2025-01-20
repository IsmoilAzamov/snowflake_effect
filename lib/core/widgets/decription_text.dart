
import 'package:flutter/material.dart';

Widget descriptionText({required String text, bool required = false}) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, bottom: 2),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          // Wrap the text widget in Flexible
          child: Text(
            text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            overflow: TextOverflow.ellipsis, // Handle overflow by ellipsis
          ),
        ),
        Text(required ? ' *' : '', style: const TextStyle(color: Colors.red)),
      ],
    ),
  );
}
