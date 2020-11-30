import 'package:flutter/material.dart';
import 'package:pakai_mart/providers/auth.dart';
import 'package:pakai_mart/providers/button_and_title.dart';
import 'package:pakai_mart/providers/woman_overviews.dart';
import 'package:pakai_mart/widgets/payment.dart';
import 'package:provider/provider.dart';

class CasheerScreen extends StatefulWidget {
  @override
  _CasheerScreenState createState() => _CasheerScreenState();
}

class _CasheerScreenState extends State<CasheerScreen> {
  var _isLoading = false;
  var _isError = false;
  @override
  void initState() {
    print('initState in Casheer Screen');
    final auth = Provider.of<Auth>(context, listen: false);
    final buttonAndTitle = Provider.of<ButtonAndTitle>(context, listen: false);
    final womanOverviews = Provider.of<WomanOverviews>(context, listen: false);
    _isLoading = true;
    womanOverviews.fetchAmountOfShoppingBag(auth.userId, auth.token).then((_) {
      womanOverviews.fetchAndSetFirstPayment(auth.userId, auth.token).then((_) {
        womanOverviews
            .fetchAndSetIsFinishPayment(auth.userId, auth.token)
            .then((_) {
          print('checkIsGoToCasheer...');
          buttonAndTitle.checkIsGoToCasheer(auth.userId, auth.token).then((_) {
            setState(() {
              _isLoading = false;
            });
          });
        });
      });
    }).catchError((e) {
      setState(() {
        _isError = true;
      });
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Koneksi internet bermasalah'),
          duration: Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build in Casheer Screen...');
    final womanOverviews = Provider.of<WomanOverviews>(context, listen: false);
    final buttonAndTitle = Provider.of<ButtonAndTitle>(context, listen: false);
    return _isError
        ? Container(
            color: Colors.blue[200],
          )
        : _isLoading
            ? Container(
                color: Colors.blue[200],
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Stack(
                children: [
                  Container(
                    color: Colors.blue[200],
                  ),
                  womanOverviews.amountInShoppingBag == 0 &&
                          !womanOverviews.firstPayment
                      ? Center(
                          child: Text(
                            'Anda belum belanja apapun',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Consumer<WomanOverviews>(
                          builder: (context, wov, child) => womanOverviews
                                  .isFinishPayment
                              ? Container(
                                  padding: EdgeInsets.only(top: 200.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Segera Bayar Ke Rekening :',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 16.0,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(4.0),
                                        width: 200,
                                        color: Colors.blue,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'ATM             : BRI',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              'No                : 2132332323232',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            Text(
                                              'Atas Nama : Bobby Williams',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16.0,
                                      ),
                                      Text(
                                        'Konfirmasi Pembayaran Ke :',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      SizedBox(
                                        height: 16.0,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(4.0),
                                        width: 200,
                                        color: Colors.green,
                                        child: Text(
                                          'Nomor WA : 081385876202',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 16.0,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16.0),
                                        child: Text(
                                          '*Jangan belanja apapun sebelum melakukan pembayaran!!!',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : buttonAndTitle.isGoToCasheer
                                  ? Payment()
                                  : Center(
                                      child: Text(
                                      'Anda belum membawa tas ke kasir',
                                      style: TextStyle(color: Colors.white),
                                    )))
                ],
              );
  }
}
