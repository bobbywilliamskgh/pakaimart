import 'package:flutter/material.dart';

class PaymentItem extends StatelessWidget {
  final image;
  final price;
  final totalPerItem;

  PaymentItem(this.image, this.price, this.totalPerItem);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: Image.asset(image),
          height: 150,
          width: 100,
        ),
        Text('Rp$price'),
        Text('x$totalPerItem'),
      ],
    );
  }
}
