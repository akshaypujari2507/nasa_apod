import 'package:flutter/material.dart';
import 'package:nasa_apod/models/apod.dart';
import 'package:nasa_apod/network/constants.dart';
import 'package:provider/provider.dart';

import '../provider/apod_provider.dart';

class FavoriteList extends StatefulWidget {
  const FavoriteList({Key? key}) : super(key: key);

  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    final apodProvider = Provider.of<ApodProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite List'),
      ),
      body: FutureBuilder<List<Apod>>(
          future: apodProvider.dbHelper.getAPODFavorite(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.blue),
              );
            } else if (snapshot.hasData) {
              return (snapshot.data!.length) > 0
                  ? ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, Constants.favoritePage,
                                arguments: snapshot.data![index]);
                          },
                          child: ListTile(
                              leading: const Icon(Icons.list),
                              trailing: IconButton(
                                  onPressed: () async {
                                    snapshot.data![index].favorite = 'no';
                                    await apodProvider.dbHelper
                                        .updateApod(snapshot.data![index]);
                                    setState(() {});
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                  )),
                              title: Text(snapshot.data![index].title)),
                        );
                      })
                  : const Center(
                      child: Text(
                        'No Favorite Photo Found!',
                        style: TextStyle(color: Colors.red),
                      ),
                    );
            } else {
              return const Center(
                child: Text(
                  'No Favorite Photo Found!',
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
          }),
    );
  }
}
