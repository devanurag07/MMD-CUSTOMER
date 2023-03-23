import 'package:flutter/material.dart';

Widget successToast(String msg) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Colors.greenAccent,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.check),
        const SizedBox(
          width: 12.0,
        ),
        Text(msg),
      ],
    ),
  );
  return toast;
}

Widget errorToast(String msg) {
  Widget toast = Container(
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25.0),
      color: Color.fromARGB(255, 227, 35, 35),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.error),
        const SizedBox(
          width: 12.0,
        ),
        Text(msg),
      ],
    ),
  );
  return toast;
}
