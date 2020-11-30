import 'package:flutter/material.dart';
import 'package:pakai_mart/providers/auth.dart';
import 'package:pakai_mart/providers/button_and_title.dart';
import 'package:pakai_mart/providers/woman_overviews.dart';
import 'package:provider/provider.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/DetailScreen';

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  var _isLoading = false;
  var _isFirst = true;
  var _isError = false;
  String _overviewId;

  @override
  void didChangeDependencies() {
    print('didChangeDependencies...');
    _overviewId = ModalRoute.of(context).settings.arguments as String;
    final womanOverviews = Provider.of<WomanOverviews>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    final buttonAndTitle = Provider.of<ButtonAndTitle>(context, listen: false);
    _isLoading = true;

    buttonAndTitle.checkIsBagTaken(auth.userId, auth.token).then((_) {
      womanOverviews
          .fetchAndSetQuantityById(auth.userId, auth.token, _overviewId)
          .then((_) {
        buttonAndTitle.checkIsGoToCasheer(auth.userId, auth.token).then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      });
    }).catchError((error) {
      setState(() {
        _isError = true;
      });
    });
    womanOverviews
        .fetchAmountOfShoppingBag(auth.userId, auth.token)
        .catchError((error) {
      print('error...');
    });
    womanOverviews
        .fetchAndSetIsFinishPayment(auth.userId, auth.token)
        .catchError((error) {
      print('error...');
    });
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('build...');
    final detailList = Provider.of<WomanOverviews>(context, listen: false)
        .womanOverviews
        .firstWhere((ov) => ov.id == _overviewId);
    print('Id yang di klik: $_overviewId');
    final auth = Provider.of<Auth>(context, listen: false);
    final womanOverviews = Provider.of<WomanOverviews>(context, listen: false);
    final buttonAndTitle = Provider.of<ButtonAndTitle>(context, listen: false);
    // Update Instruction
    buttonAndTitle
        .updateInstruction(
            womanOverviews.amountInShoppingBag, auth.userId, auth.token)
        .catchError((error) {
      print('error');
    });

    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: _isError
          ? Center(
              child: Text('Koneksi internet bermasalah !'),
            )
          : _isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Image.asset(detailList.image),
                    Container(
                      height: 150.0,
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Ukuran: ${detailList.size}'),
                          Text('Bahan: ${detailList.substance}'),
                          Text('Harga: Rp${detailList.price}'),
                        ],
                      ),
                    ),
                    AddAndRemoveButton(_overviewId, _isFirst),
                  ],
                ),
    );
  }
}

class AddAndRemoveButton extends StatefulWidget {
  final String _overviewId;
  bool _isFirst;

  AddAndRemoveButton(this._overviewId, this._isFirst);

  @override
  _AddAndRemoveButtonState createState() => _AddAndRemoveButtonState();
}

class _AddAndRemoveButtonState extends State<AddAndRemoveButton> {
  Future<void> _selectedButton(
      String label, String id, BuildContext ctx) async {
    final auth = Provider.of<Auth>(ctx, listen: false);
    final buttonAndTitle = Provider.of<ButtonAndTitle>(ctx, listen: false);
    final womanOverviews = Provider.of<WomanOverviews>(ctx, listen: false);
    print('_selectedButton');

    if (!buttonAndTitle.isBagTaken && !womanOverviews.isFinishPayment) {
      Scaffold.of(ctx).hideCurrentSnackBar();
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            'Anda belum mengambil tas belanjaan!',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
        ),
      );
      return;
      // ANDA BELUM MENGAMBIL TAS BELANJAAN
    }

    if (womanOverviews.isFinishPayment) {
      Scaffold.of(ctx).hideCurrentSnackBar();
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(
            'Anda belum menyelesaikan pembayaran!',
            textAlign: TextAlign.center,
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.blue,
        ),
      );
      return;
    }

    if (label == 'add') {
      setState(() {
        widget._isFirst = false;
      });
      print('add');
      //_isLoading = false;
      await womanOverviews.addClothes(id, auth.userId, auth.token);
      print('setelah add...');
      await womanOverviews.calculateQuantityById(id, auth.userId, auth.token);
      setState(() {
        widget._isFirst = true;
      });

      // Scaffold.of(ctx).showSnackBar(
      //   SnackBar(
      //     content: Text('Jika sudah selesai, silahkan ambil tas belanja :)'),
      //     backgroundColor: Colors.blue,
      //   ),
      // );
      print('finish add');
    } else if (label == 'remove') {
      print('start remove...');
      if (womanOverviews.quantityById > 0) {
        setState(() {
          widget._isFirst = false;
        });
        //   Scaffold.of(ctx).showSnackBar(
        //     SnackBar(
        //       content: Text('Jika sudah selesai, silahkan ambil tas belanja :)'),
        //       backgroundColor: Colors.blue,
        //     ),
        //   );
        await womanOverviews.removeClothes(id, auth.userId, auth.token);
        print('setelah remove...');
        await womanOverviews.calculateQuantityById(id, auth.userId, auth.token);
        setState(() {
          widget._isFirst = true;
        });
      }
      print('finish remove...');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 125.0,
      height: 40.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17.0),
        color: Colors.lightBlue,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            onTap: () => _selectedButton('remove', widget._overviewId, context),
            child: Container(
              height: 25.0,
              width: 25.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: Colors.lightBlue,
              ),
              child: Center(
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
            ),
          ),
          !widget._isFirst
              ? CircularProgressIndicator()
              : Consumer<WomanOverviews>(
                  builder: (context, womanOverviews, _) => Text(
                    womanOverviews.quantityById.toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                ),
          InkWell(
            onTap: () => _selectedButton('add', widget._overviewId, context),
            child: Container(
              height: 25.0,
              width: 25.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.0),
                color: Colors.white,
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.lightBlue,
                  size: 20.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
