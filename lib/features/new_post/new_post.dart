import 'dart:io';

import 'package:firebase_chat/core/components/components.dart';
import 'package:firebase_chat/core/cubit/cubit.dart';
import 'package:firebase_chat/core/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);
  var textcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: defualtAppBar(
              context: context,
              tittle: 'Create New Post',
              action: [
                defaultTextButton(
                    function: () {
                      var now = DateTime.now();
                      // print('==============time========${now}');
                      if (cubit.postimage == null) {
                        cubit.createPost(

                            dateTime: now.toString(),
                            text: textcontroller.text);
                      } else {
                        cubit.uploadPostImage(
                            dateTime: now.toString(),
                            text: textcontroller.text);
                      }
                    },
                    text: 'Post'),
              ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                        'https://img.freepik.com/free-photo/full-shot-travel-concept-with-landmarks_23-2149153258.jpg?3&w=1060&t=st=1665582793~exp=1665583393~hmac=050d8ad41a9299dd13b2abe7eb752784da2228469836a9ed53d0288fb6b2a5b5',
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      children: const [
                        Text(
                          'AbdelRahman A Dandash',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textcontroller,
                    decoration: const InputDecoration(
                      hintText: 'What is in Your mind Abdelrahman',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                if(cubit.postimage!=null)
               Container(
                 // height: 100,
                 child: Align(
                     alignment: Alignment.topCenter,
                   child: Stack(
                     alignment: AlignmentDirectional.topEnd,
                     children: [
                       Container(

                         decoration: BoxDecoration(
                           borderRadius: const BorderRadius.only(
                             topLeft: Radius.circular(5),
                             topRight: Radius.circular(5),
                           ),
                           image: DecorationImage(

                             image: FileImage(
                               File(
                                 cubit.postimage!.path,
                               ),
                             ),
                             fit: BoxFit.cover,
                           ),
                         ),
                         height: 280,
                         width: double.infinity,
                       ),
                       IconButton(
                           onPressed: () {
                             cubit.removePostImage();
                           },
                           icon: const CircleAvatar(
                               radius: 20, child: Icon(Icons.close)))
                     ],
                   ),
                 ) ,
               ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            cubit.getpostimage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.image),
                              SizedBox(
                                width: 5,
                              ),
                              Text('add photo')
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(onPressed: () {}, child: Text('Tags')),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
