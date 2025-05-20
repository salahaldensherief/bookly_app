import 'package:bookly_app/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errMassege});
  final String errMassege;
  @override
  Widget build(BuildContext context) {
    return Center(child: Text(errMassege, style: Styles.textStyle18));
  }
}
