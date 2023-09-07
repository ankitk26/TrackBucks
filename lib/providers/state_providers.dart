import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final drawerKeyProvider = StateProvider((ref) => GlobalKey<ScaffoldState>());
final currentYearProvider = StateProvider((ref) => 2023);
final currentMonthProvider = StateProvider((ref) => DateTime.now().month);
