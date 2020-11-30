import 'package:flutter/material.dart';
import 'package:pakai_mart/models/user_reciever_data.dart';
import 'package:pakai_mart/providers/auth.dart';
import 'package:pakai_mart/providers/users_receiver_data.dart';
import 'package:pakai_mart/providers/woman_overviews.dart';
import 'package:provider/provider.dart';

class UserFormScreen extends StatefulWidget {
  static const routeName = '/UserForm';
  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final _userNumberFocusNode = FocusNode();
  final _atmNumberFocuseNode = FocusNode();
  final _addressFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  var _isLoading = false;

  var _userReceiver = UserReciever(
    name: '',
    userNumber: '',
    userAtmNumber: '',
    address: '',
    setOfClothes: [],
    totalPerId: [],
    totalPayment: 0,
  );

  @override
  void dispose() {
    _userNumberFocusNode.dispose();
    _atmNumberFocuseNode.dispose();
    _addressFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      final auth = Provider.of<Auth>(context, listen: false);
      await Provider.of<ListOfUserReciever>(context, listen: false)
          .addListOfUserReciever(_userReceiver, auth.token, auth.userId);
      await Provider.of<WomanOverviews>(context, listen: false)
          .finishPayment(auth.token, auth.userId);
    } catch (error) {
      print('error exepction');
    } finally {
      setState(() {
        _isLoading = false;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final setOfClothes =
        Provider.of<WomanOverviews>(context, listen: false).setOfClothes;
    final totalPerId =
        Provider.of<WomanOverviews>(context, listen: false).totalPerId;
    final totalPayment =
        Provider.of<WomanOverviews>(context, listen: false).totalPayment;

    return Scaffold(
        appBar: AppBar(
          title: Text('Masukkan Data Penerima'),
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _form,
                  child: ListView(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Nama Lengkap'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_userNumberFocusNode);
                          _form.currentState.validate();
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Wajib diisi!!!';
                          }
                          if (value.length < 3) {
                            return 'Minimal 3 karakter';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _userReceiver = UserReciever(
                            name: newValue,
                            userNumber: _userReceiver.userNumber,
                            userAtmNumber: _userReceiver.userAtmNumber,
                            address: _userReceiver.address,
                            setOfClothes: setOfClothes,
                            totalPerId: totalPerId,
                            totalPayment: totalPayment,
                          );
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Nomor HP'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _userNumberFocusNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_atmNumberFocuseNode);
                          _form.currentState.validate();
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Wajib diisi!!!';
                          }
                          if (value.length < 10) {
                            return 'Minimal 10 karakter';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _userReceiver = UserReciever(
                            name: _userReceiver.name,
                            userNumber: newValue,
                            userAtmNumber: _userReceiver.userAtmNumber,
                            address: _userReceiver.address,
                            setOfClothes: setOfClothes,
                            totalPerId: totalPerId,
                            totalPayment: totalPayment,
                          );
                        },
                      ),
                      TextFormField(
                        decoration:
                            InputDecoration(labelText: 'Nomor Rekening'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _atmNumberFocuseNode,
                        onFieldSubmitted: (_) {
                          FocusScope.of(context)
                              .requestFocus(_addressFocusNode);
                          _form.currentState.validate();
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Wajib diisi!!!';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _userReceiver = UserReciever(
                            name: _userReceiver.name,
                            userNumber: _userReceiver.userNumber,
                            userAtmNumber: newValue,
                            address: _userReceiver.address,
                            setOfClothes: setOfClothes,
                            totalPerId: totalPerId,
                            totalPayment: totalPayment,
                          );
                        },
                      ),
                      TextFormField(
                        decoration: InputDecoration(labelText: 'Alamat'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _addressFocusNode,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Wajib diisi!!!';
                          }
                          if (value.length < 10) {
                            return 'Minimal 10 karakter';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          _userReceiver = UserReciever(
                            name: _userReceiver.name,
                            userNumber: _userReceiver.userNumber,
                            userAtmNumber: _userReceiver.userAtmNumber,
                            address: newValue,
                            setOfClothes: setOfClothes,
                            totalPerId: totalPerId,
                            totalPayment: totalPayment,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.done),
          onPressed: _saveForm,
        ));
  }
}
