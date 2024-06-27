import 'package:cached_network_image/cached_network_image.dart';
import 'package:evogram/presentation/screens/userprofile/profile_screen/widgets/my_post/widgets/gridshimmer.dart';
import 'package:flutter/cupertino.dart';

class ProfileCircleTile extends StatelessWidget {
  const ProfileCircleTile({
    super.key,
    required this.profilepic,
  });

  final String profilepic;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: profilepic,
          fit: BoxFit.cover,
          placeholder: (context, url) {
            return circleshimmer(context);
          },
        ),
      ),
    );
  }
}
