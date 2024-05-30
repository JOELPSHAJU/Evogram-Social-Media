import '../../core/constants.dart';
import 'widgets.dart';
import '../widgets/text_styles.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final coverpic =
      'https://di-uploads-pod47.dealerinspire.com/subaruofglendale/uploads/2023/11/2023-subaru-wrx-rally.jpg';
  final profilepic =
      'https://yt3.googleusercontent.com/0P0WUIUvlJ2KfaoTeDy5Xm-14u7m-7NJLy_2wa1pjBoxjHFuMqt7tMWWuZ93lETK-CYKTt4O=s900-c-k-c0x00ffffff-no-rj';

  @override
  Widget build(BuildContext context) {
    nameController.text = 'Vin Diesel';
    bioController.text =
        'I Live my life a quarter mile at a time,if you are ten seconds or less im free';

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: appbarTitle(title: 'Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            children: [
              Container(
                width: size.width,
                height: 270,
                decoration: BoxDecoration(
                    color: blueaccent,
                    image: DecorationImage(
                        image: NetworkImage(coverpic), fit: BoxFit.cover)),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                        left: size.width * .1,
                        bottom: -80,
                        child: Container(
                          height: 180,
                          width: 180,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage(profilepic),
                                  fit: BoxFit.cover),
                              color: blueaccent3,
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  width: 5,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? white
                                      : black)),
                          child: const Align(
                            alignment: Alignment.bottomRight,
                            child: EditButton(),
                          ),
                        )),
                    const Positioned(bottom: 10, right: 10, child: EditButton())
                  ],
                ),
              ),
              SizedBox(
                width: size.width,
                height: 80,
              ),
              h10,
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Name',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              h10,
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: TextFormFieldEditProfile(
                    controller: nameController,
                    hintText: 'Name',
                    keyboard: TextInputType.name,
                    minlines: 1,
                    maxlines: 1),
              ),
              h20,
              const Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Bio',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              h10,
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  right: 8,
                ),
                child: TextFormFieldEditProfile(
                    controller: bioController,
                    hintText: 'Bio',
                    keyboard: TextInputType.text,
                    minlines: 3,
                    maxlines: 5),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 20),
                child: MaterialButton(
                    color: blueaccent3,
                    minWidth: size.width,
                    height: 55,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    onPressed: () {},
                    child: const Text('Update',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: white,
                            fontSize: 17))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
