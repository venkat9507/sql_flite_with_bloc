
import 'package:flutter/material.dart';


Widget? loadingIndicator(BuildContext context){
return
  Scaffold(
      body: Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ));
}