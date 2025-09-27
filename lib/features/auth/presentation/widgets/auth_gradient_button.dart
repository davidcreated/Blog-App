import 'package:blog_app/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AuthGradientButton extends StatelessWidget {
  const AuthGradientButton({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppPalette.gradient1, AppPalette.gradient2],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: ElevatedButton(onPressed: (){},
      style: ElevatedButton.styleFrom(
        fixedSize: const Size(395, 55),
        backgroundColor: AppPalette.tranparent,
        shadowColor: AppPalette.tranparent,

      ), child: Text("Sign Up ", style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),)
      ),
    );
  } 
}     