import 'package:flutter/material.dart';
import 'package:pakai_mart/providers/auth.dart';
import 'package:pakai_mart/providers/woman_overviews.dart';
import 'package:pakai_mart/screens/casheer_screen/user_form_screen.dart';
import 'package:pakai_mart/widgets/payment_item.dart';
import 'package:provider/provider.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var _isLoading = false;
  @override
  void initState() {
    final auth = Provider.of<Auth>(context, listen: false);
    final womanOverviews = Provider.of<WomanOverviews>(context, listen: false);
    _isLoading = true;
    womanOverviews.reset(auth.userId, auth.token);
    womanOverviews.createPayment(auth.userId, auth.token).then((_) {
      womanOverviews.calculateTotalPayment(auth.userId, auth.token).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void selectedButton(BuildContext ctx) {
      Navigator.of(ctx).pushNamed(UserFormScreen.routeName);
    }

    final womanOverviews = Provider.of<WomanOverviews>(context, listen: false);

    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      'Pembayaran',
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.blue)),
                  child: ListView.builder(
                    padding: EdgeInsets.all(10.0),
                    itemCount: womanOverviews.setOfClothes.length,
                    itemBuilder: (ctx, i) => PaymentItem(
                      womanOverviews.setOfClothes[i].image,
                      womanOverviews.setOfClothes[i].price,
                      womanOverviews.totalPerId[i],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.blue[50])),
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('${womanOverviews.totalItems} items'),
                      Text('Rp ${womanOverviews.totalPayment}'),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                      width: 300.0,
                      height: 50.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.blue),
                      margin: EdgeInsets.all(10.0),
                      child: FlatButton(
                        splashColor: Colors.blue[200],
                        onPressed: () => selectedButton(context),
                        child: Text(
                          'Selanjutnya',
                          style: TextStyle(color: Colors.white),
                        ),
                      ))),
            ],
          );
  }
}
