import 'package:day_track/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Storeregistration extends StatefulWidget {
  static const String id = "Storeregistration";
  @override
  _StoreregistrationState createState() => _StoreregistrationState();
}

class _StoreregistrationState extends State<Storeregistration> {
  String email;
  String password;
  String password2;
  String contactnum;
  String storename;
  String storeloc;

  Future _showAlert(BuildContext context, String message, String action) async {
    return showDialog(
        context: context,
        child: new AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          title: new Text(message),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pop(context),
                child: new Text(action))
          ],
        ));
  }

  bool spinner = false;
  final auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      // appBar: new AppBar(
      //   title: new Text(''),
      // ),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: SingleChildScrollView(
          child: new Container(
            padding: new EdgeInsets.all(32.0),
            child: new Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: new Text(
                        'Register\nNow',
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  decoration: new InputDecoration(
                    labelText: ' Email Address',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Email cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.emailAddress,
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      contactnum = value;
                    });
                  },
                  decoration: new InputDecoration(
                    labelText: ' Contact Number',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "Email cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      storename = value;
                    });
                  },
                  decoration: new InputDecoration(
                    labelText: 'Store Name',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "password cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      storeloc = value;
                    });
                  },
                  decoration: new InputDecoration(
                    labelText: 'Store Location',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "password cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.text,
                ),
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      password = value;
                    });
                  },
                  decoration: new InputDecoration(
                    labelText: 'Password',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  validator: (val) {
                    if (val.length == 0) {
                      return "password cannot be empty";
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 20),
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      password2 = value;
                    });
                  },
                  decoration: new InputDecoration(
                    labelText: 'Confirm Password',
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: new BorderSide(),
                    ),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                ),
                Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: new MaterialButton(
                    onPressed: () {
                      if (email == null ||
                          contactnum == "" ||
                          storename == "" ||
                          storeloc == "") {
                        _showAlert(
                            context, 'Enter all the fields', 'Check Now');
                        print("not entered");
                      } else {
                        if (password == password2) {
                          Navigator.pushNamed(context, Loginpage.id);
                        } else {
                          _showAlert(context, 'Passwords are not same',
                              'Check password');
                        }
                      }
                      createAccount();
                    },
                    height: 46,
                    minWidth: 130,
                    child: Text(
                      'Register',
                      style: TextStyle(fontSize: 17),
                    ),
                    textColor: Colors.white,
                    color: Colors.black87,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    elevation: 2,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  createAccount() async {
    try {
      setState(() {
        spinner = true;
      });
      final user = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        final FirebaseUser user = await auth.currentUser();
        final userid = user.uid;

        // saving data to firebase
        //
        // _firestore.collection('store_details').document(userid).setData({

        // });
        _firestore.collection('store_details').document(userid).setData({
          'email': email,
          'contact_no': contactnum,
          'store_name': storename,
          'store_loc': storeloc,
        });
        _showAlert(context, 'Succesfully Registered ', 'Ok');
        setState(() {
          spinner = false;
        });
        Navigator.pushNamed(context, Loginpage.id);
      }
    } catch (e) {
      _showAlert(
          context, 'Allready Registered.\n Use another email id', 'Retry Now');
      setState(() {
        spinner = false;
      });
    }
  }
}
