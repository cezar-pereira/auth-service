// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class TextFormFieldUserComponent extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final Function? validation;
  const TextFormFieldUserComponent(
      {Key? key, required this.onChanged, this.validation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        onChanged: (value) => onChanged(value),
        cursorColor: Theme.of(context).hintColor,
        validator: validation != null ? (value) => validation!(value) : null,
        style: Theme.of(context).textTheme.caption,
        decoration: InputDecoration(
          errorStyle: Theme.of(context).textTheme.bodyText2,
          hintStyle: Theme.of(context).textTheme.caption,
          hintText: 'Usuário',
          icon: Icon(Icons.person_outline,
              color: Theme.of(context).iconTheme.color),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 2),
        ),
      ),
    );
  }
}
