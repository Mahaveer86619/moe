import 'package:flutter/material.dart';
import 'package:moe/config/theme/theme.dart';
import 'package:moe/features/qr_scanner/presentation/screens/qr_scanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MOE',
      theme: lightMode,
      debugShowCheckedModeBanner: false,
      home: const QrScannerScreen(),
    );
  }
}
