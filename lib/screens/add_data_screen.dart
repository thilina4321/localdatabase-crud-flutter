import 'package:flutter/material.dart';
import 'package:localdatastorage/provider/data_provider.dart';
import 'package:localdatastorage/screens/home_screen.dart';
import 'package:provider/provider.dart';

class AddDataScreen extends StatefulWidget {
  static String routeName = 'add-data-screen';

  @override
  _AddDataScreenState createState() => _AddDataScreenState();
}

class _AddDataScreenState extends State<AddDataScreen> {
  final _form = GlobalKey<FormState>();

  final data = Item(name: '', age: '', id: null);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    if (id != null) {
      final item = Provider.of<DataProvider>(context, listen: false)
          .findItemToUpdate(id);
      data.id = id;
      data.name = item.name;
      data.age = item.age;
    }

    addData() {
      final isValid = _form.currentState.validate();
      if (!isValid) {
        return;
      }
      _form.currentState.save();
      if (data.id != null) {
        final updateData = {'id': data.id, 'name': data.name, 'age': data.age};
        Provider.of<DataProvider>(context, listen: false).update(updateData);
      } else {
        Provider.of<DataProvider>(context, listen: false)
            .addData(data.name, data.age);
      }

      Navigator.of(context).pushNamed('/');
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Form(
        key: _form,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              TextFormField(
                onSaved: (value) {
                  data.name = value;
                },
                initialValue: data.name,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextFormField(
                onSaved: (value) {
                  data.age = value;
                },
                initialValue: data.age,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                    color: Colors.blue,
                    onPressed: addData,
                    child: Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
