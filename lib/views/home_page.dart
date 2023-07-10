import 'package:flutter/material.dart';
import 'package:nasa_apod/date_picker_widget.dart';
import 'package:nasa_apod/network/constants.dart';
import 'package:nasa_apod/provider/apod_provider.dart';
import 'package:nasa_apod/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    final today = DateTime.now();
    DateTime date = DateTime(today.year, today.month, today.day);

    final apodProvider = Provider.of<ApodProvider>(context, listen: false);
    apodProvider.currentDate = date;

    // apodProvider.getApod(date: '2023-07-09');
    apodProvider.getApod(date: apodProvider.getCurrentDateString());
  }

  @override
  Widget build(BuildContext context) {
    final apodProvider = Provider.of<ApodProvider>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () {
              Navigator.pushNamed(context, Constants.favoriteList);
            },
          )
        ],
        title: const Text('Flutter Demo Home Page'),
      ),
      body: (apodProvider.errorMessage.isNotEmpty) ?
          errorWidget(apodProvider.errorMessage, () {
            apodProvider.getApod(date: apodProvider.getCurrentDateString());
            apodProvider.notifyListeners();
          })
      : (apodProvider.apod == null)
          ? const Center(
        child: CircularProgressIndicator(
            color: Colors.blue),
      ) : SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            showTitle(apodProvider.apod!.title),
            const DatePickerWidget(),
            const SizedBox(
              height: 10.0,
            ),
            showImage(apodProvider.apod!.media_type, apodProvider.apod!.hdurl, context),
            const Padding(
              padding: EdgeInsets.only(bottom: 20),
            ),
            showApodInfo(apodProvider.apod!.explanation),
          ],
        ),
      ),
    );
  }
}
