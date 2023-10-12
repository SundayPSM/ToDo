import 'package:flutter/material.dart';
import 'package:todo/app_style.dart';

class EmptyListCard extends StatelessWidget {
  const EmptyListCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Press '+' to add To-Do ",
        style: kPromptMedium.copyWith(color: Colors.black),
      ),
    );
  }
}
