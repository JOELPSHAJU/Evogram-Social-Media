import 'package:flutter/material.dart';

class GridviewProfile extends StatelessWidget {
  const GridviewProfile({super.key});
  final coverpic =
      'https://di-uploads-pod47.dealerinspire.com/subaruofglendale/uploads/2023/11/2023-subaru-wrx-rally.jpg';
  @override
  Widget build(context) {
    return Scaffold(
        body: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 3,
      mainAxisSpacing: .1,
      crossAxisSpacing: .1,
      childAspectRatio: 1 / 1,
      children: List.generate(25, (index) {
        return Card(
          child: GridTile(
            child: Image.network(
              coverpic,
              fit: BoxFit.cover,
            ),
          ),
        );
      }),
    ));
  }
}
