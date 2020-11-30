import 'package:flutter/material.dart';
import 'package:pakai_mart/providers/auth.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  void _exitButtonPressed(BuildContext context) {
    Provider.of<Auth>(context, listen: false).logout();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return Stack(
      children: [
        Container(
          color: Colors.yellow[200],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16.0, top: 32.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Email : ${auth.email}',
                      style: TextStyle(fontSize: 16.0, color: Colors.blue),
                    )
                  ],
                ),
                //color: Colors.red,
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Nilai Aplikasi',
                          style: TextStyle(fontSize: 16.0, color: Colors.blue),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.star,
                              color: Colors.blue,
                            ),
                            onPressed: () {}),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          'Keluar',
                          style: TextStyle(fontSize: 16.0, color: Colors.blue),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.exit_to_app,
                            color: Colors.blue,
                          ),
                          onPressed: () => _exitButtonPressed(context),
                        ),
                      ],
                    ),
                  ],
                ),
                //color: Colors.green,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
