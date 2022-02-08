import 'package:flutter/material.dart';

class ButtonExitComponent extends StatelessWidget {
  const ButtonExitComponent({Key? key, required this.onTap}) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: const [
            Text('Sair', style: TextStyle(color: Colors.black)),
            Icon(Icons.exit_to_app, color: Colors.black),
          ],
        ),
      ),
    );
  }
}
