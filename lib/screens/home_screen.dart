import 'package:flutter/material.dart';
import 'package:localdatastorage/provider/data_provider.dart';
import 'package:localdatastorage/screens/add_data_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = 'home-screen';

  final List _items = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                {Navigator.of(context).pushNamed(AddDataScreen.routeName)},
          ),
        ],
        title: Text('Main Screen'),
      ),
      body: FutureBuilder(
          future: Provider.of<DataProvider>(context, listen: false).getData(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.error != null) {
              return Center(
                child: Text('error'),
              );
            }

            return Consumer<DataProvider>(
              builder: (ctx, data, _) {
                return data.items.length == 0
                    ? Center(
                        child: Container(
                          child: Text('No items find yet....'),
                        ),
                      )
                    : ListView.builder(
                        itemCount: data.items.length,
                        itemBuilder: (ctx, index) {
                          return ListTile(
                            title: Text(data.items[index].name),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            AddDataScreen.routeName,
                                            arguments: data.items[index].id);
                                      }),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        data.deleteData(data.items[index].id);
                                      }),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            );
          }),
    );
  }
}
