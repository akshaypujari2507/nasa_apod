import 'package:flutter/material.dart';
import 'package:nasa_apod/db/db_helper.dart';
import 'package:nasa_apod/network/constants.dart';
import 'package:nasa_apod/provider/apod_provider.dart';
import 'package:provider/provider.dart';

class DatePickerWidget extends StatefulWidget {
  const DatePickerWidget({Key? key}) : super(key: key);

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {

  Future<void> datePicker(BuildContext context) async {
    final today = DateTime.now();
    DateTime? dateTime = await showDatePicker(
        context: context,
        initialDate: today,
        firstDate: DateTime(1995, 6, 16, 0, 0),
        lastDate: today,
        cancelText: "Cancel",
        confirmText: "OK");
    final apodProvider = Provider.of<ApodProvider>(context, listen: false);

    apodProvider.currentDate = dateTime!;
    apodProvider.notifyListeners();
    apodProvider.getApod(date: apodProvider.getCurrentDateString());

  }


  @override
  void initState() {
    super.initState();
    final apodProvider = Provider.of<ApodProvider>(context, listen: false);
    apodProvider.getFavoriteStatus();
  }

  @override
  Widget build(BuildContext context) {
    final apodProvider = Provider.of<ApodProvider>(context);
    return GestureDetector(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 20.0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Text((apodProvider.isInternet) ? apodProvider.getCurrentDisplayDateString() : apodProvider.apod!.display_date),
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 1.5)),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
            ),
            const Icon(
              Icons.calendar_today,
            ),
            IconButton(
              icon: Icon(
                Icons.favorite,
                color: (apodProvider.isFavorite) ? Colors.red : Colors.grey,
              ),
              onPressed: () async {
                apodProvider.isFavorite = !apodProvider.isFavorite;
                apodProvider.apod!.favorite = (apodProvider.isFavorite) ? 'yes' : 'no';
                await apodProvider.dbHelper.updateApod(apodProvider.apod!);
                setState(() {
                  apodProvider.isFavorite;
                });
              },
            )
          ],
        ),
      ),
      onTap: () async => await datePicker(context),
    );
  }
}
