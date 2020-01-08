import 'package:deva_app/db_structure.dart';
import 'package:deva_app/list_model.dart';
import 'package:flutter/material.dart';

class Listviewer extends StatefulWidget {
  @override
  _ListviewerState createState() => _ListviewerState();
}

class _ListviewerState extends State<Listviewer> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  Future<List<Listmodel>> list;
  String _itemname;
  bool isUpdate = false;
  int itemIdForUpdate;
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
        title: Text("Cart Page"),
      ),
      body: Column(
        children: <Widget>[
          CircleAvatar(
            child: ClipOval(
              child: Image.asset("assets/images/Add_to_Cart.png"),
            ),
            radius: 50.0,
          ),
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
                        return 'Please Enter the item to add to Cart';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _itemname = value;
                    },
                    controller: _itemNameController,
                    decoration: InputDecoration(
                        hintText: "Enter the list item to add to the Cart",
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
                  isUpdate ? "UPDATE ITEM" : "ADD TO CART",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  if (isUpdate) {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      dbHelper
                          .update(Listmodel(itemIdForUpdate, _itemname))
                          .then((data) {
                        setState(() {
                          isUpdate = false;
                        });
                      });
                    }
                  } else {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      dbHelper.add(Listmodel(null, _itemname));
                    }
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
                  isUpdate ? "CANCEL UPDATE" : "CLEAR THE NAME",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  _itemNameController.text = '';
                  setState(() {
                    isUpdate = false;
                    itemIdForUpdate = null;
                  });
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
              label: Text('CART ITEMS'),
            ),
            DataColumn(
              label: Text('DELETE FROM CART'),
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
                    onTap: () {
                      setState(() {
                        isUpdate = true;
                        itemIdForUpdate = list.id;
                      });
                      _itemNameController.text = list.name;
                    },
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
