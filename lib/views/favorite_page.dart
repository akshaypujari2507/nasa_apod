import 'package:flutter/material.dart';
import 'package:nasa_apod/models/apod.dart';
import 'package:nasa_apod/widgets.dart';

class FavoritePage extends StatefulWidget {
  final Apod apod;
  FavoritePage({Key? key, required this.apod}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Page'),
      ),
      body: (widget.apod == null)
          ? const Center(
        child: CircularProgressIndicator(
            color: Colors.blue),
      ) : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showTitle('${widget.apod.display_date}'),
            showTitle('${widget.apod.title}'),
            const SizedBox(
              height: 10.0,
            ),
            showImage(widget.apod.media_type, widget.apod.hdurl, context),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
            showApodInfo(widget.apod.explanation),
          ],
        ),
      ),
    );
  }
}
