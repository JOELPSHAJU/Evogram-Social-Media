
import 'package:flutter/material.dart';

class FindProfileScreen extends StatelessWidget {
  const FindProfileScreen({super.key});
  final profilepic =
      'https://i.redd.it/rate-actress-michelle-rodriguez-had-roles-in-avatar-fast-v0-5ajp4kyc4iva1.jpg?width=2527&format=pjpg&auto=webp&s=e0e15527167cf143508acc91e2d25d021e6e24f8';
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 20,
      itemBuilder: (context, index) {
        return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {},
              child: ListTile(
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image: NetworkImage(profilepic), fit: BoxFit.cover)),
                ),
                title: const Text(
                  'Michele Rodregues',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  'its_michele_rodrigues',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                trailing: const Text(''),
              ),
            ));
      },
    );
  }
}
