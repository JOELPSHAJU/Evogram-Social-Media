import '../../core/constants.dart';
import '../widgets/text_styles.dart';
import 'package:flutter/material.dart';

class SuggessionScreen extends StatelessWidget {
  const SuggessionScreen({super.key});
  final profilepic =
      'https://mir-s3-cdn-cf.behance.net/project_modules/fs/abd02a98993327.5ee8e3a24669e.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          backgroundColor: white,
          surfaceTintColor: white,
          title: appbarTitle(title: 'Suggessions'),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.arrow_back)),
        ),
        body: ListView.builder(
            itemCount: 15,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                          image: NetworkImage(profilepic), fit: BoxFit.cover)),
                ),
                title: const Text(
                  'Nathalie Emanuel',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text(
                  'nathalie_e',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                ),
                trailing: MaterialButton(
                    minWidth: 80,
                    height: 27,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                        side: const BorderSide(color: blueaccent2)),
                    onPressed: () {},
                    child: const Text('Follow',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: blueaccent2,
                            fontSize: 13))),
              );
            }));
  }
}
