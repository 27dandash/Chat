import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_chat/core/cubit/cubit.dart';
import 'package:firebase_chat/core/cubit/state.dart';
import 'package:firebase_chat/core/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return ConditionalBuilder(
          condition: cubit.posts.length > 0,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
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
                  ListView.builder(
                    itemBuilder: (context, index) =>
                        buildPostItem(cubit.posts[index], context,index),
                    itemCount: cubit.posts.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                  )
                ],
              ),
            );
          },
          fallback: (context) {
            return const Center(child: CircularProgressIndicator());
          },
        );
      },
    );
  }

  Widget buildPostItem(PostModel model, context,index) => Card(
        // surfaceTintColor: Colors.blue,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 5,
        // margin: EdgeInsets.symmetric(horizontal: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      '${model.img}',
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '${model.name}',
                              style: TextStyle(fontSize: 14),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                           if ( SocialCubit.get(context).userModel!.isEmailVerfied == true)
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            // Text(
                            //   'January 21, 2022 at 11:00 pm',
                            //   style: Theme.of(context).textTheme.caption,
                            // ),
                            Text(
                              '${model.dateTime}',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 18,
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Container(
                  color: Colors.grey[300],
                  width: double.infinity,
                  height: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Text(

                  '${model.text}',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              // Tags
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  alignment: WrapAlignment.spaceAround,
                  children: [
                    SizedBox(
                      height: 20,
                      child: MaterialButton(
                        onPressed: () {},
                        height: 25,
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        child: const Text(
                          '#Software',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: MaterialButton(
                        onPressed: () {},
                        height: 25,
                        minWidth: 1,
                        padding: EdgeInsets.zero,
                        child: const Text(
                          '#Software',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              if (model.postImage != '')
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(
                          '${model.postImage}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    height: 240,
                    width: double.infinity,
                  ),
                ),
              const SizedBox(
                height: 7,
              ),
              // Likes comment
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                        child: InkWell(
                      onTap: () {},
                      child: Row(
                        children:  [
                          Icon(
                            Icons.heart_broken_sharp,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('${SocialCubit.get(context).likes[index]}'),
                        ],
                      ),
                    )),
                    // const Spacer(),
                    Expanded(
                      child: InkWell(
                          onTap: () {},
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                Icons.comment,
                                color: Colors.yellow[500],
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Text(
                                '120 Comment',
                              ),
                            ],
                          )),
                    )
                  ],
                ),
              ),
              const Divider(
                height: 1,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundImage: NetworkImage(
                                '${SocialCubit.get(context).userModel!.img}',
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('Write comment...'),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        SocialCubit.get(context).likePostes(SocialCubit.get(context).postId[index]);
                      },
                      child: Row(
                        children: const [
                          Icon(
                            Icons.heart_broken_sharp,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text('Like'),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
}
