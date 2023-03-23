import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryComponent extends StatelessWidget {
  final title;
  final url;
  final Color color;
  final bool selected;
  const CategoryComponent(
      {super.key,
      this.title,
      this.url,
      this.color = Colors.blue,
      this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Stack(
          // alignment: Alignment.topRight,
          // fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: selected
                      ? Color.fromARGB(114, 10, 50, 251)
                      : Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      offset: Offset(
                        3.0,
                        3.0,
                      ),
                      blurRadius: 3.0,
                      spreadRadius: 2.0,
                    ), //BoxShadow
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0.0,
                      spreadRadius: 0.0,
                    ), //BoxShadow
                  ],
                ),
                child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(title.toString(),
                          style: TextStyle(fontSize: 14)),
                    )),
              ),
            ),
            Positioned(
              top: -10,
              right: -10,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(url.toString()),
                ),
              ),
            ),
          ]),
    );
  }
}
