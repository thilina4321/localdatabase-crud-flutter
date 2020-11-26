import 'package:flutter/material.dart';
import 'package:localdatastorage/provider/item_provider.dart';
import 'package:localdatastorage/screen/form_screen.dart';
import 'package:provider/provider.dart';

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Database App'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(FormScreen.routeName);
              })
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<ItemProvider>(context, listen: false).getData(),
        builder: (ctx, dataSnapshot) => dataSnapshot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            // : Text('hell')
            : Consumer<ItemProvider>(
                builder: (ctx, item, child) {
                  return ListView.builder(
                      itemCount: item.items.length,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.all(10),
                          title: Text(
                            item.items[index].name,
                          ),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.green,
                            child: Text(
                                item.items[index].value.toStringAsFixed(1)),
                          ),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                      size: 26,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          FormScreen.routeName,
                                          arguments: item.items[index].id);
                                    }),
                                IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 26,
                                    ),
                                    onPressed: () =>
                                        item.deleteData(item.items[index].id)),
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
      ),
    );
  }
}
