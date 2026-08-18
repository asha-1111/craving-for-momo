import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'services/cart_service.dart';

void main() {
  runApp(const CravingForMomoApp());
}

class CravingForMomoApp extends StatelessWidget {
  const CravingForMomoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartService(),
      child: MaterialApp(
        title: AppConstants.pageTitle,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
