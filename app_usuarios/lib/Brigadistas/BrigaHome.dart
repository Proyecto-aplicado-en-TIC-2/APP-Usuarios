
import 'package:appv2/Components/CustonAppbar.dart';
import 'package:appv2/Components/EmergencyCallbox.dart';
import 'package:appv2/Components/EmergencyLayout.dart';
import 'package:appv2/Components/UserHello.dart';
import 'package:flutter/material.dart';

import '../Constants/AppColors.dart';


class BrigaHomescreen extends StatefulWidget {
  const BrigaHomescreen({super.key});

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<BrigaHomescreen> {


  @override
  Widget build(BuildContext context) {
    final basilTheme = Theme.of(context).extension<BasilTheme>();
    return Scaffold(
      appBar: const CustonAppbar(automaticallyImplyLeading: false,),
      body: SingleChildScrollView(
        padding:  EdgeInsets.all(10),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserHello(),
            SizedBox(height: 30),
            EmergencyLayout(),
            SizedBox(height: 30),
              Text(
              '  Llamada de emergencia',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: basilTheme?.onSurface),
            ),
            const SizedBox(height: 10),
            const EmergencyCallBox(),
          ],
        ),
      ),
    );
  }
}



