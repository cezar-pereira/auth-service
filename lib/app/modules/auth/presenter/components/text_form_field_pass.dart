import 'package:flutter/material.dart';

class TextFormFieldPassComponent extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final VoidCallback? onSubmitted;
  final Function? validation;

  const TextFormFieldPassComponent(
      {Key? key, required this.onChanged, this.onSubmitted, this.validation})
      : super(key: key);
  @override
  _TextFieldLoginPasswordComponent createState() =>
      _TextFieldLoginPasswordComponent();
}

class _TextFieldLoginPasswordComponent
    extends State<TextFormFieldPassComponent> {
  bool isHide = true;

  void showViewPassword() {
    setState(() {
      isHide = !isHide;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        onEditingComplete: widget.onSubmitted,
        onChanged: (value) => widget.onChanged(value),
        cursorColor: Theme.of(context).hintColor,
        validator: widget.validation != null
            ? (value) => widget.validation!(value)
            : null,
        obscureText: isHide,
        style: Theme.of(context).textTheme.caption,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          errorMaxLines: 3,
          errorStyle: Theme.of(context).textTheme.bodyText2,
          hintStyle: Theme.of(context).textTheme.caption,
          hintText: 'Senha',
          icon: Icon(Icons.lock_outline_rounded,
              color: Theme.of(context).iconTheme.color),
          border: InputBorder.none,
          suffixIcon: GestureDetector(
            onTap: showViewPassword,
            child: Icon(
                isHide
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: Theme.of(context).iconTheme.color),
          ),
        ),
      ),
    );
  }
}
