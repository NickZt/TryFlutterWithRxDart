import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nbu_currency/presentation/home/home_page.dart';
import 'package:nbu_currency/presentation/details/details_page.dart';

class Screen {
  final Object data;

  Screen({this.data});
}

class All extends Screen {
  All({Object data}) : super(data: data);
}

class Details extends Screen {
  Details({Object data}) : super(data: data);
}

class NavigationUtils {
  NavigationUtils._();

  static navigateTo(BuildContext context, Screen screen) {
    print("Navigate to: $screen");

    final page = resolveScreen(screen);

    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  static Widget resolveScreen(Screen screen) {
    if (screen is All) {
      return HomePage(
        title: 'NBU Rates',
        data: screen.data,
      );
    }

    if (screen is Details) {
      return DetailsPage(
        title: screen.data,
        data: screen.data,
      );
    }

    throw ("Unknown screen type");
  }
}
