import 'package:flutter/material.dart';

import 'layout/component/header.dart';
import 'layout/component/navigation.dart';

class HomeScreen extends StatelessWidget {  // Changed to StatelessWidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigation(),  // Use Navigation widget here
    );
  }
}