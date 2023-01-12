import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:post_repository/post_repository.dart';

import '../util/debouncer.dart';
import 'cubit/post_cubit.dart';

class DataTables extends StatefulWidget {
  const DataTables({Key? key}) : super(key: key);

  @override
  State<DataTables> createState() => _DataTablesState();
}

class _DataTablesState extends State<DataTables> {
  int dropdownValue = 15;
  List<String> list = ['10', '15', '20', '25'];
  final TextEditingController _searchController =
      TextEditingController.fromValue(TextEditingValue.empty);

  final debouncer = Debouncer(milliseconds: 500);

  List<DataRow> dataRow(List<Post> posts) {
    return posts
        .map((post) => DataRow(cells: [
              DataCell(Text(post.postID.toString())),
              DataCell(Text(post.body)),
              DataCell(Text(post.title)),
              DataCell(Text(post.userID.toString())),
            ]))
        .toList();
  }

  List<Material> pagination(int currentPage, int totalPage) {
    List<Material> paginations = List.empty(growable: true);
    for (var i = 1; i <= totalPage; i++) {
      paginations.add(Material(
        type: MaterialType.transparency,
        child: Ink(
          decoration: BoxDecoration(
            color: currentPage == i ? Colors.deepPurple : Colors.grey[200],
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
                style: const TextStyle(
                  color: Colors.white,
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
      backgroundColor: Colors.grey,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: _height,
          width: _width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Text(
                  'Server Side',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
                ),
              ),
              const Divider(thickness: 2.0),
              // TODO: display entries and search function
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('show', style: TextStyle(fontSize: 12)),
                        BlocBuilder<PostCubit, PostState>(
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                padding: const EdgeInsets.only(left: 5),
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black38),
                                    borderRadius: BorderRadius.circular(5)),
                                child: DropdownButton<String>(
                                  value: dropdownValue.toString(),
                                  icon: const Icon(Icons.arrow_drop_down_sharp),
                                  elevation: 16,
                                  isDense: true,
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
                            );
                          },
                        ),
                        const Text(
                          'entries',
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 10.0),
                          child: Text(
                            'Search',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                        BlocBuilder<PostCubit, PostState>(
                          builder: (context, state) {
                            return SizedBox(
                              width: _width * 0.25,
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
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
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
                              headingTextStyle: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 11,
                                  color: Colors.black87),
                              headingRowHeight: 45,
                              headingRowColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                return Colors.grey[400];
                              }),
                              // decoration: ,
                              columns: const [
                                DataColumn(label: Text('POST ID')),
                                DataColumn(label: Text('BODY')),
                                DataColumn(label: Text('TITLE')),
                                DataColumn(label: Text('USER ID')),
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
                    // Arrow back
                    BlocBuilder<PostCubit, PostState>(
                      builder: (context, state) {
                        if (state is PostLoaded) {
                          return Material(
                            type: MaterialType.transparency,
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(500.0),
                                onTap: () {
                                  if (state.currentPage > 1) {
                                    BlocProvider.of<PostCubit>(context)
                                        .fetchPosts(
                                            entries: dropdownValue,
                                            currentPage: state.currentPage - 1);
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    size: 10.0,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    // Pagination number
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: BlocBuilder<PostCubit, PostState>(
                        builder: (context, state) {
                          if (state is PostLoaded) {
                            return Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(45)),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: pagination(
                                      state.currentPage, state.totalPages)),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    ),
                    // Arrow forward
                    BlocBuilder<PostCubit, PostState>(
                      builder: (context, state) {
                        if (state is PostLoaded) {
                          return Material(
                            type: MaterialType.transparency,
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                shape: BoxShape.circle,
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(500.0),
                                onTap: () {
                                  if (state.currentPage < state.totalPages) {}
                                  BlocProvider.of<PostCubit>(context)
                                      .fetchPosts(
                                          entries: dropdownValue,
                                          currentPage: state.currentPage + 1);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 10.0,
                                    color: Colors.grey[400],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
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
