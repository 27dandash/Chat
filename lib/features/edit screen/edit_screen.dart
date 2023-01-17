import 'dart:io';
import 'package:firebase_chat/core/components/components.dart';
import 'package:firebase_chat/core/cubit/cubit.dart';
import 'package:firebase_chat/core/cubit/state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class edit_profile_screen extends StatelessWidget {
  edit_profile_screen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        var usermodel = SocialCubit.get(context).userModel;
        nameController.text = cubit.userModel!.name!;
        phoneController.text = cubit.userModel!.phone!;
        bioController.text = cubit.userModel!.bio!;
        // UserModel? usermodel = SocialCubit.get(context).model;
        // if (usermodel !=null)
        // { nameController.text= usermodel!.name!;}else{}
        return Scaffold(
          appBar: defualtAppBar(
            tittle: 'Edit profile',
            action: [
              defaultTextButton(
                  function: () {
                    cubit.updateUser(
                        name: nameController.text,
                        phone: phoneController.text,
                        bio: bioController.text);
                  },
                  text: 'update')
            ],
            context: context,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  if(state is SocialUpdateDataLoadingState)
                  const LinearProgressIndicator(),
                  SizedBox(
                    height: 180,
                    child: Stack(
                      // alignment: AlignmentDirectional.bottomCenter,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              cubit.coverImage == null
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '${usermodel!.coverimg}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 140,
                                      width: double.infinity,
                                    )
                                  : Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5),
                                        ),
                                        image: DecorationImage(
                                          image: FileImage(
                                            File(
                                              cubit.coverImage!.path,
                                            ),
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      height: 140,
                                      width: double.infinity,
                                    ),
                              IconButton(
                                  onPressed: () {
                                    cubit.getcoverImage();
                                  },
                                  icon: const CircleAvatar(
                                      radius: 20, child: Icon(Icons.edit)))
                            ],
                          ),
                        ),
                        CircleAvatar(
                          radius: 58,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              cubit.profileimage == null
                                  ? CircleAvatar(
                                      radius: 55,
                                      backgroundImage:
                                          NetworkImage('${usermodel!.img}'))
                                  : CircleAvatar(
                                      radius: 55,
                                      backgroundImage: FileImage(
                                        File(
                                          cubit.profileimage!.path,
                                        ),
                                      ),
                                    ),
                              IconButton(
                                  onPressed: () {
                                    cubit.getProfileImage();
                                  },
                                  icon: const CircleAvatar(
                                      radius: 20, child: Icon(Icons.edit)))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  if(cubit.profileimage !=null || cubit.coverImage!=null)
                  Row(
                    children: [
                  if(cubit.profileimage !=null)
                      Expanded(child: Column(
                        children: [
                          defaultButton(function: (){
                            cubit.uploadprofileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text,);
                          }, text: 'Upload Profile'),
                          if(state is SocialUpdateDataLoadingState)
                          SizedBox(
                            height: 5,
                          ),
                          if(state is SocialUpdateDataLoadingState)
                          LinearProgressIndicator(),
                        ],
                      )),

                      if(cubit.coverImage !=null)
                      Expanded(child: Column(
                        children: [
                          defaultButton(function: (){
                            cubit.uploadcoverImage(name: nameController.text, phone: phoneController.text, bio: bioController.text,);
                          }, text: 'Upload  Cover'),
                          if(state is SocialUpdateDataLoadingState)
                            SizedBox(
                              height: 5,
                            ),
                          if(state is SocialUpdateDataLoadingState)
                            LinearProgressIndicator(),
                        ],
                      )),
                    ],
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.name,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Name can\'t be Empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: Icons.person),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.number,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'phone number can\'t be Empty';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: Icons.phone),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'bio can\'t be Empty';
                        }
                        return null;
                      },
                      label: 'Bio',
                      prefix: Icons.textsms_outlined),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
