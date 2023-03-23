import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Calender extends StatelessWidget {
  final String date;
  final String day;
  final bool? activate;

  const Calender(
      {super.key, this.activate, required this.date, required this.day});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 50,
        height: 100,
        decoration: BoxDecoration(
            color: (activate == null || activate == false)
                ? Colors.white
                : Color.fromRGBO(19, 96, 239, 1),
            border: Border.all(color: Colors.black38),
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(day,
                  style: TextStyle(
                      color: (activate == null || activate == false)
                          ? Colors.black
                          : Colors.white)),
              const SizedBox(
                height: 10,
              ),
              Text(
                date,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 17,
                    color: (activate == null || activate == false)
                        ? Colors.black
                        : Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
              )
            ]));
  }
}
