import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final drawerKeyProvider = StateProvider((ref) => GlobalKey<ScaffoldState>());
final currentYearProvider = StateProvider((ref) => DateTime.now().year);
final currentMonthProvider = StateProvider((ref) => DateTime.now().month);
