import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//**************These Pages are used in the bottumnavigation bar*********************** */

final auth = FirebaseAuth.instance;

//for Qr scaning in Userdashboard
class ScanQr extends StatefulWidget {
  @override
  _ScanQrState createState() => _ScanQrState();
}

class _ScanQrState extends State<ScanQr> {
  String qrCodeResult = '';
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SingleChildScrollView(
        child: new Column(
          children: <Widget>[
            SizedBox(
              height: 120,
            ),
            Padding(
              padding: const EdgeInsets.all(29.0),
              child: Image(
                image: AssetImage('images/qr.png'),
                alignment: Alignment.topLeft,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: new MaterialButton(
                onPressed: () async {
                  String codeScanned = await BarcodeScanner.scan();
                  setState(() {
                    qrCodeResult = codeScanned;
                  });
                  // Navigator.pushNamed(context, RegistrationPage.id);
                },
                minWidth: 130,
                child: Text(
                  ' Scan QR ',
                  style: TextStyle(fontSize: 17),
                ),
                textColor: Colors.white,
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                elevation: 2,
                height: 55,
              ),
            ),
            Text(qrCodeResult)
          ],
        ),
      ),
    );
  }
}

// History page in Userdashboard
class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// For Store panel

// for VISITORS COUNT

class VistorsDetails extends StatefulWidget {
  @override
  _VistorsDetailsState createState() => _VistorsDetailsState();
}

class _VistorsDetailsState extends State<VistorsDetails> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// Search BY DATE

class SearchByDate extends StatefulWidget {
  @override
  _SearchByDateState createState() => _SearchByDateState();
}

class _SearchByDateState extends State<SearchByDate> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

//Show Qr Code

class ShowQRCode extends StatefulWidget {
  @override
  _ShowQRCodeState createState() => _ShowQRCodeState();
}

class _ShowQRCodeState extends State<ShowQRCode> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

///forgot password
class ForgotPassword extends StatefulWidget {
  static const String id = 'ForgotPassword';
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  String email;
  Future _showAlert(BuildContext context, String message) async {
    return showDialog(
        context: context,
        child: new AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          title: new Text(message),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pop(context), child: new Text('OK'))
          ],
        ));
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      _showAlert(context, "Check Your E-mail for the password Reset Link");
    } catch (e) {
      _showAlert(context, "User not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(19.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
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
                    'Forgot \nPassword',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: 45,
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            TextFormField(
              onChanged: (value) {
                setState(() {
                  email = value;
                });
              },
              decoration: new InputDecoration(
                labelText: ' Registered Email Address',
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
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: new MaterialButton(
                onPressed: () async {
                  resetPassword(email);
                },
                height: 46,
                minWidth: 130,
                child: Text(
                  'Reset Password',
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
    );
  }
}
