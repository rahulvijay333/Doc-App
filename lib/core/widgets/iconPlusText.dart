import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class IconPlusTextWidget extends StatelessWidget {
  const IconPlusTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Icon(Icons.local_hospital), Text('Doctors')],
    );
  }
}
