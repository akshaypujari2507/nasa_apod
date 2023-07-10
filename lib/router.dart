import 'package:flutter/material.dart';
import 'package:nasa_apod/models/apod.dart';
import 'package:nasa_apod/views/favorite_list.dart';
import 'package:nasa_apod/views/favorite_page.dart';
import 'package:nasa_apod/views/home_page.dart';

import 'network/constants.dart';


class Routers {
  static String previousRoute = "";
  static String tempRoute = "";
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Constants.homePage:
       return _createRoute(const HomePage());

      case Constants.favoriteList:
       return _createRoute(const FavoriteList());

      case Constants.favoritePage:
        final arguments = settings.arguments as Apod;
       return _createRoute(FavoritePage(apod: arguments));

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}


Route _createRoute(Widget widget, {String routeName = "", Map? arguments}) {

  return PageRouteBuilder(
    transitionDuration:  const Duration(milliseconds: 300),
    reverseTransitionDuration : const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

