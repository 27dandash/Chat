import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10,
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              const Image(
                image: NetworkImage(
                  'https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=1060&t=st=1665582793~exp=1665583393~hmac=050d8ad41a9299dd13b2abe7eb752784da2228469836a9ed53d0288fb6b2a5b5',
                ),
                fit: BoxFit.cover,
                height: 230,
                width: double.infinity,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Communicate With Friends',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              )
            ],
          ),
        ),
        Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          elevation: 10,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    'https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=1060&t=st=1665582793~exp=1665583393~hmac=050d8ad41a9299dd13b2abe7eb752784da2228469836a9ed53d0288fb6b2a5b5',
                  ),
                ),
               const SizedBox(width: 20,),
                Column(children: [
                  const Text('AbdelRahman A Dandash'),
                  Text('January 21, 2022 at 11:00 pm',style: Theme.of(context).textTheme.caption,),
                ],)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
