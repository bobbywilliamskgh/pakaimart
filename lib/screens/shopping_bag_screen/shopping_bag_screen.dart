import 'package:flutter/material.dart';
import 'package:pakai_mart/providers/auth.dart';
import 'package:pakai_mart/providers/button_and_title.dart';
import 'package:pakai_mart/providers/woman_overviews.dart';
import 'package:provider/provider.dart';

class ShoppingBagScreen extends StatefulWidget {
  final Function selectedButton;

  ShoppingBagScreen(this.selectedButton);

  @override
  _ShoppingBagScreenState createState() => _ShoppingBagScreenState();
}

class _ShoppingBagScreenState extends State<ShoppingBagScreen> {
  var _isLoading = false;
  var _isError = false;

  @override
  void initState() {
    print('initState');
    final womanOverviews = Provider.of<WomanOverviews>(context, listen: false);
    final buttonAndTitle = Provider.of<ButtonAndTitle>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    _isLoading = true;
    womanOverviews.fetchAmountOfShoppingBag(auth.userId, auth.token).then((_) {
      buttonAndTitle.getInstruction(auth.userId, auth.token).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }).catchError((error) {
      setState(() {
        _isError = true;
      });
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Koneksi internet bermasalah !'),
          duration: Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
    womanOverviews
        .fetchAndSetIsFinishPayment(auth.userId, auth.token)
        .catchError((error) {
      print('error1...');
    });
    womanOverviews
        .fetchAndSetFirstPayment(auth.userId, auth.token)
        .catchError((error) {
      print('error2');
    }); // for totalInShoppingBag
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return _isError
        ? Container(
            color: Colors.yellow[200],
          )
        : _isLoading
            ? Container(
                color: Colors.yellow[200],
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Stack(
                children: [
                  Container(
                    color: Colors.yellow[200],
                  ),
                  Center(
                      child: Container(
                    child: Consumer<WomanOverviews>(
                      builder: (context, womanOverviews, _) => Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              womanOverviews.amountInShoppingBag.toString(),
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(
                              Icons.shopping_basket,
                              color: Colors.blue,
                              size: 64.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Consumer<ButtonAndTitle>(
                                builder: (context, buttonAndTitle, _) =>
                                    RaisedButton(
                                      onPressed: buttonAndTitle.onPressedButton(
                                          widget.selectedButton,
                                          womanOverviews.amountInShoppingBag,
                                          womanOverviews.isFinishPayment,
                                          auth.userId,
                                          auth.token),
                                      child: Text(
                                        buttonAndTitle.instruction,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.blue,
                                      textColor: Colors.white,
                                      elevation: 5,
                                    )),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              );
  }
}
