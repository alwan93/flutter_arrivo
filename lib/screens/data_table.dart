import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_arrivo/widget/side_drawer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:post_repository/post_repository.dart';

import '../util/debouncer.dart';
import '../widget/on_hover.dart';
import 'cubit/post_cubit.dart';

class DataTables extends StatefulWidget {
  const DataTables({Key? key}) : super(key: key);

  @override
  State<DataTables> createState() => _DataTablesState();
}

class _DataTablesState extends State<DataTables> {
  int dropdownValue = 15;
  String statusValue = 'Select Status';
  List<String> statusList = [
    'Select Status',
    'Status #1',
    'Status #2',
    'Status #3'
  ];
  List<String> list = ['10', '15', '20', '25'];
  final TextEditingController _searchController =
      TextEditingController.fromValue(TextEditingValue.empty);

  final debouncer = Debouncer(milliseconds: 500);

  final GlobalKey<ScaffoldState> _key = GlobalKey();

  List<DataRow> dataRow(List<Post> posts) {
    return posts
        .map((post) => DataRow(cells: [
              DataCell(Text(
                '#' + post.postID.toString(),
                style: const TextStyle(
                    color: Color(0xff3b3b3b), fontWeight: FontWeight.w500),
              )),
              DataCell(Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: OnHover(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(post.title,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Color(0xff706c83))),
                      const Text(
                        'example@mail.com',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ),
              )),
              DataCell(CircleAvatar(
                  maxRadius: 16,
                  backgroundColor: const Color(0xfffceced),
                  child: IconButton(
                      iconSize: 14,
                      onPressed: () {
                        print('tapped');
                      },
                      icon: const Icon(
                        Icons.info_outline,
                        color: Color(0xfff08687),
                      )))),
              DataCell(Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: OnHover(
                  child: Text(
                    post.body,
                    style: const TextStyle(color: Color(0xff84818f)),
                  ),
                ),
              )),
              DataCell(Container(
                height: 20,
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 8),
                decoration: BoxDecoration(
                    color: const Color(0xffe5f8ef),
                    borderRadius: BorderRadius.circular(55.0)),
                child: const Text('PAID',
                    style: TextStyle(
                        color: Color(0xff46ce8b),
                        fontWeight: FontWeight.bold,
                        fontSize: 11)),
              )),
              DataCell(Row(
                children: [
                  OnHover(
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(Icons.send_outlined,
                            size: 18, color: Color(0xff84818f))),
                  ),
                  OnHover(
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(Icons.remove_red_eye_outlined,
                            size: 18, color: Color(0xff84818f))),
                  ),
                  OnHover(
                    child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert,
                            size: 18, color: Color(0xff84818f))),
                  )
                ],
              )),
            ]))
        .toList();
  }

  List<Material> pagination(int currentPage, int totalPage) {
    List<Material> paginations = List.empty(growable: true);
    for (var i = 1; i <= totalPage; i++) {
      bool isCurrentPage = currentPage == i;
      paginations.add(Material(
        type: MaterialType.transparency,
        child: Ink(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
            color: isCurrentPage ? Colors.black : const Color(0xfff3f2f7),
            shape: BoxShape.circle,
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(500.0),
            onTap: () {
              BlocProvider.of<PostCubit>(context)
                  .fetchPosts(entries: dropdownValue, currentPage: i);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 8),
              child: Text(
                i.toString(),
                style: TextStyle(
                  color: isCurrentPage ? Colors.white : const Color(0xff878492),
                ),
              ),
            ),
          ),
        ),
      ));
    }
    return paginations;
  }

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      endDrawer: const SideDrawer(),
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          height: _height,
          width: _width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //  Header
              Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('Show',
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Halvetica',
                                fontWeight: FontWeight.w500,
                                color: Color(0xff888593))),
                        BlocBuilder<PostCubit, PostState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  right: 15.0, top: 15, bottom: 15, left: 10),
                              child: Container(
                                height: 37,
                                width: 60,
                                padding: const EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38),
                                    borderRadius: BorderRadius.circular(5)),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: dropdownValue.toString(),
                                    icon: const Padding(
                                      padding: EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.expand_more_outlined,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    isDense: false,
                                    style: const TextStyle(color: Colors.grey),
                                    onChanged: (String? value) {
                                      setState(() {
                                        dropdownValue = int.parse(value!);
                                        if (state is PostLoaded) {
                                          BlocProvider.of<PostCubit>(context)
                                              .fetchPosts(
                                                  entries: dropdownValue,
                                                  currentPage:
                                                      state.currentPage + 1);
                                        }
                                      });
                                    },
                                    items: list.map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        SizedBox(
                          height: 37,
                          width: 120,
                          child: OnHover(
                            child: TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                onPressed: () {
                                  // Scaffold.of(context).openEndDrawer();
                                  _key.currentState!.openEndDrawer();
                                },
                                child: const Text('Add Record',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14))),
                          ),
                        )
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text('Search',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff888593))),
                        ),
                        BlocBuilder<PostCubit, PostState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: _width * 0.15,
                              child: FormBuilderTextField(
                                name: 'search',
                                obscureText: false,
                                controller: _searchController,
                                onChanged: (value) {
                                  if (state is PostLoaded) {
                                    debouncer.run(() {
                                      BlocProvider.of<PostCubit>(context)
                                          .fetchPosts(
                                              entries: dropdownValue,
                                              currentPage: state.currentPage,
                                              searchTerm: value ?? '');
                                    });
                                  }
                                },
                                autovalidateMode: AutovalidateMode.disabled,
                                keyboardType: TextInputType.text,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                    hintText: 'Search Invoice',
                                    hintStyle: const TextStyle(
                                        color: Color(0xffcacad1),
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 13, horizontal: 10),
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
                                        ))),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Container(
                            height: 37,
                            width: 125,
                            padding: const EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black38),
                                borderRadius: BorderRadius.circular(5)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: statusValue,
                                icon: const Padding(
                                  padding: EdgeInsets.only(right: 8.0),
                                  child: Icon(
                                    Icons.expand_more_outlined,
                                    color: Colors.grey,
                                  ),
                                ),
                                isDense: false,
                                style: const TextStyle(color: Colors.grey),
                                onChanged: (String? value) {
                                  setState(() {
                                    statusValue = value!;
                                  });
                                },
                                items: statusList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              // Datatable
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: _width,
                    child: BlocBuilder<PostCubit, PostState>(
                      builder: (context, state) {
                        if (state is PostLoaded) {
                          return DataTable(
                              dataRowHeight: 80,
                              // border: TableBorder(),
                              headingTextStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Color(0xff7c7988)),
                              headingRowHeight: 45,
                              columnSpacing: 30,
                              headingRowColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                return const Color(0xfff3f2f7);
                              }),
                              // decoration: ,
                              columns: const [
                                DataColumn(
                                    label: Text(
                                  '#',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Color(0xff757281)),
                                )),
                                DataColumn(
                                    label: Text(
                                  'TITLE',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Color(0xff757281)),
                                )),
                                DataColumn(
                                    label: Icon(
                                  Icons.auto_graph,
                                  color: Color(0xff757281),
                                )),
                                DataColumn(
                                    label: Text(
                                  'BODY',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Color(0xff757281)),
                                )),
                                DataColumn(
                                    label: Text(
                                  'STATUS',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Color(0xff757281)),
                                )),
                                DataColumn(
                                    label: Text(
                                  'ACTION',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                      color: Color(0xff757281)),
                                )),
                              ],
                              rows: dataRow(state.posts));
                        } else {
                          return Container();
                        }
                      },
                    ),
                  ),
                ),
              ),
              // Pagination
              // Value changed as the entries number changed.
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Pagination number
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: BlocBuilder<PostCubit, PostState>(
                        builder: (context, state) {
                          if (state is PostLoaded) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 3, vertical: 3),
                              decoration: BoxDecoration(
                                  color: const Color(0xfff3f2f7),
                                  borderRadius: BorderRadius.circular(45)),
                              child: Row(
                                children: [
                                  Material(
                                    type: MaterialType.transparency,
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        shape: BoxShape.circle,
                                      ),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(500.0),
                                        onTap: () {
                                          if (state.currentPage > 1) {
                                            BlocProvider.of<PostCubit>(context)
                                                .fetchPosts(
                                                    entries: dropdownValue,
                                                    currentPage:
                                                        state.currentPage - 1);
                                          }
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.arrow_back_ios,
                                            size: 10.0,
                                            color: Color(0xff878492),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: pagination(
                                        state.currentPage, state.totalPages),
                                  ),
                                  Material(
                                    type: MaterialType.transparency,
                                    child: Ink(
                                      decoration: const BoxDecoration(
                                        color: Color(0xfff3f2f7),
                                        shape: BoxShape.circle,
                                      ),
                                      child: InkWell(
                                        borderRadius:
                                            BorderRadius.circular(500.0),
                                        onTap: () {
                                          if (state.currentPage <
                                              state.totalPages) {}
                                          BlocProvider.of<PostCubit>(context)
                                              .fetchPosts(
                                                  entries: dropdownValue,
                                                  currentPage:
                                                      state.currentPage + 1);
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Icon(
                                            Icons.arrow_forward_ios,
                                            size: 10.0,
                                            color: Color(0xff878492),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
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
