import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class Empty extends StatelessWidget {
  const Empty({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GFImageOverlay(
            image: const NetworkImage(
                'https://user-images.githubusercontent.com/507615/54591670-ac0a0180-4a65-11e9-846c-e55ffce0fe7b.png'),
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.3), BlendMode.darken),
            height: 100,
            width: 100,
            boxFit: BoxFit.cover,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Text('暂无数据'),
          )
        ],
      ),
    );
  }
}
