import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HeaderPage extends StatelessWidget {
  List<String> listImage = [
    'assets/image/banner1.jpg',
    'assets/image/banner2.jpg',
    'assets/image/banner3.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: double.infinity,
      child: CarouselSlider(
        options: CarouselOptions(
          height: 200,
          viewportFraction: 1.0,
          autoPlay: true,
          enlargeCenterPage: false,
          // autoPlay: false,
        ),
        items: listImage
            .map((e) => Image.asset(
                  e,
                  fit: BoxFit.cover,
                ))
            .toList(),
      ),
    );
  }
}
