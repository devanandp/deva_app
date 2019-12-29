import 'package:deva_app/dbstructure.dart';
import 'package:deva_app/listmodel.dart';
import 'package:flutter/material.dart';

class Listviewer extends StatefulWidget {
  @override
  _ListviewerState createState() => _ListviewerState();
}

class _ListviewerState extends State<Listviewer> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<Listmodel>> list;
  String _itemname;
  DBstructure dbHelper;
  final _itemNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DBstructure();
    refreshItemList();
  }

  refreshItemList() {
    setState(() {
      list = dbHelper.getListitems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("List View"),
      ),
      body: Column(
        children: <Widget>[
          Form(
            key: _formStateKey,
            autovalidate: true,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please Enter the list item';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _itemname = value;
                    },
                    controller: _itemNameController,
                    decoration: InputDecoration(
                        hintText: "Enter the list item",
                        fillColor: Colors.white,
                        labelStyle: TextStyle(
                          color: Colors.green,
                        )),
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                color: Colors.green,
                child: Text(
                  "ADD",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (_formStateKey.currentState.validate()) {
                    _formStateKey.currentState.save();
                    print(_itemname);
                    dbHelper.add(Listmodel(null, _itemname));
                  }
                  _itemNameController.text = '';
                  refreshItemList();
                },
              ),
              Padding(
                padding: EdgeInsets.all(10),
              ),
              RaisedButton(
                color: Colors.red,
                child: Text(
                  "CLEAR",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _itemNameController.text = '';
                },
              ),
            ],
          ),
          const Divider(
            height: 5.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: list,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateList(snapshot.data);
                }
                if (snapshot.data == null || snapshot.data.length == 0) {
                  return Text('No Data Found');
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView generateList(List<Listmodel> list) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('LIST ITEMS'),
            ),
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: list.map(
            (list) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      list.name,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  DataCell(
                    IconButton(
                      icon: Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () {
                        dbHelper.delete(list.id);
                        refreshItemList();
                      },
                    ),
                  )
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
