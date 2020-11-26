import 'package:flutter/material.dart';
import 'package:localdatastorage/provider/item_provider.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  static String routeName = 'form-data';
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final key = GlobalKey<FormState>();
  var editingItem = Item(id: null, name: '', value: null);
  bool isFirst = true;

  @override
  void didChangeDependencies() {
    if (isFirst) {
      final data = ModalRoute.of(context).settings.arguments;
      if (data != null) {
        final item = Provider.of<ItemProvider>(context, listen: false)
            .findItemToUpdate(data);

        editingItem = item;

        // editingItem = item;
      }
      isFirst = false;
    }
    super.didChangeDependencies();
  }

  void saveData(context) {
    final isValid = key.currentState.validate();
    if (!isValid) {
      return;
    }
    key.currentState.save();
    if (editingItem.id == null) {
      Provider.of<ItemProvider>(context, listen: false)
          .addData(editingItem.name, editingItem.value);
      Navigator.of(context).pushNamed('/');
    } else {
      Provider.of<ItemProvider>(context, listen: false).update({
        'id': editingItem.id,
        'name': editingItem.name,
        'value': editingItem.value
      });
      Navigator.of(context).pushReplacementNamed('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Data'),
      ),
      body: Form(
        key: key,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            TextFormField(
              initialValue: editingItem.name,
              onSaved: (val) {
                editingItem.name = val;
              },
              validator: (val) {
                if (val.isEmpty) {
                  return 'Itwm name is required';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Item Name',
              ),
            ),
            TextFormField(
              onSaved: (val) {
                editingItem.value = int.parse(val);
              },
              initialValue: editingItem.value.toString(),
              validator: (val) {
                if (val.isEmpty) {
                  return 'Value is required';
                }
                return null;
              },
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                labelText: 'Item Price',
              ),
            ),
            RaisedButton(
              onPressed: () {
                saveData(context);
              },
              color: Colors.blue,
              child: Text(
                'Add Data',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
