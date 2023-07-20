import 'package:flutter/material.dart';

import '../../utils/colors.dart';

class AppLoader extends StatelessWidget {
  const AppLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.white,
        backgroundColor: AppColors.black,
      ),
    );
  }
}
