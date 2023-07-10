
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Padding showTitle(String imageTitle) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
    child: Text(
      imageTitle,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 16),
    ),
  );
}

Container showImage(String mediaType, String imgURL, BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(6.0),
        child: imgURL != null
            ? CachedNetworkImage(
          progressIndicatorBuilder: (c, url, progress) {
            return Column(
              children: const [
                Text(''),
                SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                      color: Colors.blue),
                ),
                Text('Loading image...'),
              ],
            );
          },
          imageUrl: imgURL,
        )
            : Text("Image is not available")

    ),
  );
}

Padding showApodInfo(String imageInfo) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
    child: Text(
      imageInfo,
    ),
  );
}

Widget errorWidget(String message, VoidCallback commonAction) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(12,0,12,12),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            size: 80,
            Icons.error_outline_sharp,
            color: Colors.deepOrange,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(message,textAlign: TextAlign.center),
          const SizedBox(
            height: 10,
          ),
          ButtonTheme(
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(58, 28),
              ),
              onPressed: () {
                commonAction();
              },
              child: const Text('Try again',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.deepOrange,
                  )),
            ),
          ),
        ],
      ),
    ),
  );

}
