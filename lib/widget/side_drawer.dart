import 'package:flutter/material.dart';
import 'package:flutter_arrivo/widget/on_hover.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:post_repository/post_repository.dart';

import '../screens/cubit/post_cubit.dart';

class SideDrawer extends StatefulWidget {
  const SideDrawer({Key? key}) : super(key: key);

  @override
  State<SideDrawer> createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  final TextEditingController _titleController =
      TextEditingController.fromValue(TextEditingValue.empty);
  final TextEditingController _bodyController =
      TextEditingController.fromValue(TextEditingValue.empty);
  final TextEditingController _emailController =
      TextEditingController.fromValue(TextEditingValue.empty);
  final _formKey = GlobalKey<FormBuilderState>();

  Post post = const Post();
  String title = '';
  String body = '';
  String email = '';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: FormBuilder(
          autoFocusOnValidationFailure: true,
          key: _formKey,
          child: Column(
            children: [
              // Header
              Container(
                decoration: const BoxDecoration(color: Color(0xfff8f8f8)),
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('New Records',
                          style: TextStyle(
                              color: Color(0xff5f5974),
                              fontWeight: FontWeight.w600)),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.clear,
                            size: 16,
                          ))
                    ]),
              ),
              // Forms
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 3.0),
                child: Row(
                  children: const [
                    Text(
                      'Title',
                      style: TextStyle(
                          color: Color(0xff5f5974),
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              FormBuilderTextField(
                name: 'title',
                obscureText: false,
                controller: _titleController,
                onChanged: (value) {},
                validator: FormBuilderValidators.required(context),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                enableSuggestions: false,
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: const TextStyle(
                      color: Color(0xffcacad1),
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                        width: 1.0,
                      )),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 3.0),
                child: Row(
                  children: const [
                    Text(
                      'Body',
                      style: TextStyle(
                          color: Color(0xff5f5974),
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              FormBuilderTextField(
                name: 'body',
                obscureText: false,
                controller: _bodyController,
                onChanged: (value) {},
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                enableSuggestions: false,
                validator: FormBuilderValidators.required(context),
                autocorrect: false,
                maxLines: 10,
                decoration: InputDecoration(
                  hintText: 'Write body text',
                  hintStyle: const TextStyle(
                      color: Color(0xffcacad1),
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                        width: 1.0,
                      )),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 3.0),
                child: Row(
                  children: const [
                    Text(
                      'Email',
                      style: TextStyle(
                          color: Color(0xff5f5974),
                          fontWeight: FontWeight.w500,
                          fontSize: 12),
                    ),
                    Text(
                      '*',
                      style: TextStyle(
                          color: Colors.red, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              FormBuilderTextField(
                name: 'email',
                obscureText: false,
                controller: _emailController,
                onChanged: (value) {},
                autovalidateMode: AutovalidateMode.onUserInteraction,
                keyboardType: TextInputType.text,
                enableSuggestions: false,
                validator: FormBuilderValidators.required(context),
                autocorrect: false,
                decoration: InputDecoration(
                  hintText: 'johndoe@mail.com',
                  hintStyle: const TextStyle(
                      color: Color(0xffcacad1),
                      fontWeight: FontWeight.w400,
                      fontSize: 12),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      )),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: const BorderSide(
                        color: Colors.deepPurple,
                        width: 1.0,
                      )),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 1.0,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide: const BorderSide(
                      color: Colors.red,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
              // Buttons
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Row(
                  children: [
                    SizedBox(
                      height: 35,
                      width: 100,
                      child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                            ),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState?.validate() == true) {
                              _formKey.currentState?.save();
                              Post newPost = const Post();
                              newPost = Post(
                                  postID: 1,
                                  body: _bodyController.text,
                                  userID: 1,
                                  title: _titleController.text);

                              await BlocProvider.of<PostCubit>(context)
                                  .sendPost(newPost);
                              Navigator.pop(context);
                            }
                          },
                          child: const Text('Submit',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13))),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: SizedBox(
                        height: 35,
                        width: 100,
                        child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                  color: Color(0xff82868b),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13),
                            )),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
