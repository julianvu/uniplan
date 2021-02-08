import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uniplan/injection.dart';
import 'package:uniplan/presentation/core/app_widget.dart';

void main() {
  configureInjection(Environment.prod);
  runApp(AppWidget());
}
