import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter_asp/app/app_widget.dart';
import 'package:template_flutter_asp/app/injector.dart';

void main() {
  registerInstances();
  runApp(const RxRoot(child: AppWidget()));
}
