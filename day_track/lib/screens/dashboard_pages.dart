import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
//**************These Pages are used in the bottumnavigation bar*********************** */

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
