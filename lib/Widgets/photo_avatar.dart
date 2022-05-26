import 'package:flutter/material.dart';

class PhotoAvatar extends StatelessWidget {
  final String photoLink;
  const PhotoAvatar({Key? key, required this.photoLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20,
      backgroundImage: NetworkImage(photoLink),
    );
  }
}
