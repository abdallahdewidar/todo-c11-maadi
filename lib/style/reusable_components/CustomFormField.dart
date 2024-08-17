import 'package:flutter/material.dart';
typedef Validation = String? Function(String?);
class CustomFormField extends StatefulWidget {
  String label;
  TextInputType type;
  TextInputAction textInputAction;
  bool isPassword;
  Validation validator;
  int lines;
  TextEditingController controller;
  CustomFormField({required this.label,
    this.type = TextInputType.text,
    this.lines = 1,
    this.textInputAction = TextInputAction.next,
    this.isPassword = false,
    required this.validator,
    required this.controller
  });

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  bool isObscured =true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines:widget.lines ,
      minLines:widget.lines ,
      controller: widget.controller,
      validator: widget.validator,
      keyboardType: widget.type,
      obscureText: widget.isPassword?isObscured:false,
      obscuringCharacter: '*',
      textInputAction:widget.textInputAction,
      decoration: InputDecoration(
          labelStyle: TextStyle(
            color: Colors.black
          ),
          suffixIcon:widget.isPassword
              ?IconButton(
              onPressed: (){
                setState(() {
                  isObscured = !isObscured;
                });
              },
              icon: Icon(isObscured?Icons.visibility_off_rounded:Icons.visibility_rounded,
              color: Theme.of(context).colorScheme.primary,
              ))
              :null,
          labelText: widget.label
      ),
    );
  }
}
