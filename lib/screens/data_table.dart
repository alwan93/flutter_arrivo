import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
                        Padding(
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
                        SizedBox(
                          width: _width * 0.25,
                          child: FormBuilderTextField(
                            name: 'search',
                            obscureText: false,
                            controller: _searchController,
                            onChanged: (value) {},
                            autovalidateMode: AutovalidateMode.disabled,
                            keyboardType: TextInputType.text,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 5),
                              isDense: true,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: const BorderSide(
                                    color: Colors.grey,
                                    width: 1.0,
                                  )),
                            ),
                          ),
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
                    child: DataTable(
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
                          DataColumn(
                              label: Text(
                            'FULL NAME',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          DataColumn(label: Text('EMAIL')),
                          DataColumn(label: Text('POSITION')),
                          DataColumn(label: Text('OFFICE')),
                          DataColumn(label: Text('START DATE')),
                          DataColumn(label: Text('SALARY')),
                        ],
                        rows: const [
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                          DataRow(cells: [
                            DataCell(Text("Alwan Kaharuddin")),
                            DataCell(Text("alwankaharuddin93@gmail.com")),
                            DataCell(Text("Software Engineer")),
                            DataCell(Text("Tawau")),
                            DataCell(Text("01/02/23")),
                            DataCell(Text("\$ 7500.00")),
                          ]),
                        ]),
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
                    Material(
                      type: MaterialType.transparency,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(500.0),
                          onTap: () {},
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
                    ),
                    // Pagination number
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(45)),
                        child: Row(
                          children: [
                            Material(
                              type: MaterialType.transparency,
                              child: Ink(
                                decoration: const BoxDecoration(
                                  color: Colors.deepPurple,
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(500.0),
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 8),
                                    child: Text(
                                      '1',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              type: MaterialType.transparency,
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(500.0),
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 8),
                                    child: Text(
                                      '2',
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              type: MaterialType.transparency,
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(500.0),
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 8),
                                    child: Text(
                                      '...',
                                      style: TextStyle(
                                        textBaseline: TextBaseline.ideographic,
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              type: MaterialType.transparency,
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(500.0),
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 8),
                                    child: Text(
                                      '3',
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Material(
                              type: MaterialType.transparency,
                              child: Ink(
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  shape: BoxShape.circle,
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(500.0),
                                  onTap: () {},
                                  child: const Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 8),
                                    child: Text(
                                      '4',
                                      style: TextStyle(
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    // Arrow forward
                    Material(
                      type: MaterialType.transparency,
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(500.0),
                          onTap: () {},
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
