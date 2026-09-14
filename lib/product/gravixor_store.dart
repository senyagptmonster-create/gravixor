import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class GravixorStore extends ChangeNotifier {
  List<String> history = [];

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    history = prefs.getStringList('grav_history') ?? [];
    if (history.isEmpty) {
      try {
        final jsonStr = await rootBundle.loadString('packages/gravixor/content.json');
        final data = jsonDecode(jsonStr);
        history = List<String>.from(data['history']);
      } catch (e) {
        // Fallback
      }
    }
    notifyListeners();
  }
}
