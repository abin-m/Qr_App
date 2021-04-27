import 'dart:typed_data';
import 'package:day_track/screens/dashboard_user.dart';
import 'package:day_track/screens/register.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:day_track/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
//**************These Pages are used in the bottom navigation bar*********************** */

final auth = FirebaseAuth.instance;
final _firestore = Firestore.instance;
// Future getUId() async {
//   final FirebaseUser user = await auth.currentUser();
//   final userid = user.uid;
//   kuid = userid;
//   print(userid);
// }

// String kuid;
String qrData = "";

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
                    qrData = qrCodeResult;
                  });
                  try {
                    if (qrCodeResult.isNotEmpty) {
                      Navigator.pushNamed(context, StoreCkechIn.id);
                    }
                  } catch (e) {
                    print(e);
                  }
                  // -----------------------
                  // if (qrCodeResult != null) {
                  //   StoreCkechIn();
                  //   // Navigator.pushNamed(context, RegistrationPage.id);
                  // }
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
            // Text(qrData)
          ],
        ),
      ),
    );
  }
}

// shop checkin
//
class StoreCkechIn extends StatefulWidget {
  static const String id = 'StoreCheckIn';
  @override
  _StoreCkechInState createState() => _StoreCkechInState();
}

class _StoreCkechInState extends State<StoreCkechIn> {
  String userName = "";
  String storeloc = "";
  String mob = "";
  String storeName = "";
  Future _showAlert(BuildContext context, String message, String action) async {
    return showDialog(
        context: context,
        child: new AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
          title: new Text(message),
          actions: <Widget>[
            new FlatButton(
                onPressed: () => Navigator.pushNamed(context, UserDashboard.id),
                child: new Text(action))
          ],
        ));
  }

  Future getDetails() async {
    final FirebaseUser user = await auth.currentUser();
    final userid = user.uid;
    _firestore.collection('store_details').document(qrData).get().then((value) {
      setState(() {
        storeName = value.data['store_name'];
        storeloc = value.data['store_loc'];
      });
      // print(value);
      // print(userName);
    });
    _firestore.collection('user_details').document(userid).get().then((value) {
      setState(() {
        mob = value.data['contact_no'];
        userName = value.data['name'];
      });
      // print(value);
      // print(userName);
    });
  }

  Future checkInData() async {
    String now = "";
    final FirebaseUser user = await auth.currentUser();
    final userid = user.uid;
    try {
      _firestore
          .collection('store_details')
          .document(qrData)
          .collection('CheckIn_details')
          .document(userid)
          .setData({
        'customer_name': userName,
        'contact_number': mob,
        'date': now = DateFormat("dd-MM-yyyy").format(DateTime.now()),
      });
      _firestore
          .collection('user_details')
          .document(userid)
          .collection('CheckIn_details')
          .add({
        'store_name': storeName,
        'time': DateFormat("H:m:s").format(DateTime.now()),
        'date': now = DateFormat("dd-MM-yyyy").format(DateTime.now()),
      });
      _showAlert(context, 'Succesfully checked In\n Have a nice day ', 'Ok');
    } catch (e) {
      _showAlert(context, 'Something went wrong ', 'Ok');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Welcome To \n$storeName , $storeloc",
                style: TextStyle(fontSize: 29, fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Card(
                color: Colors.blueGrey[300],
                child: Container(
                  height: MediaQuery.of(context).size.height * .08,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Text(
                      userName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Card(
                color: Colors.blueGrey[300],
                child: Container(
                  height: MediaQuery.of(context).size.height * .08,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Text(
                      mob,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(22.0),
              child: new MaterialButton(
                onPressed: () async {
                  checkInData();
                },
                minWidth: 130,
                child: Text(
                  ' check in  ',
                  style: TextStyle(fontSize: 17),
                ),
                textColor: Colors.white,
                color: Colors.black87,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
                elevation: 2,
                height: 45,
              ),
            ),
            // Card(
            //   elevation: 5,
            //   child: Text(data),
            // ),
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
//logout page

class LogOut extends StatefulWidget {
  @override
  _LogOutState createState() => _LogOutState();
}

class _LogOutState extends State<LogOut> {
  String userName = "";
  String joinedOn = "";
  String kUid;
  Future getDetails() async {
    final FirebaseUser user = await auth.currentUser();
    final userid = user.uid;
    _firestore.collection('user_details').document(userid).get().then((value) {
      setState(() {
        kUid = userid;
        userName = value.data['name'];
        joinedOn = value.data['joinedon'];
      });
      print(value);
      print(userName);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 60,
              backgroundImage: AssetImage('images/person.png'),
            ),
            Text(
              userName,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
            ),
            Text("Joined On : $joinedOn"),
            // FloatingActionButton(onPressed: () {}),
            //
            SizedBox(
              height: 53,
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: new MaterialButton(
                onPressed: () {
                  auth.signOut();
                  Navigator.pushNamed(context, Loginpage.id);
                },
                height: 46,
                minWidth: 130,
                child: Text(
                  'Log out',
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

// logout for admin
class StoreLogOut extends StatefulWidget {
  @override
  _StoreLogOutState createState() => _StoreLogOutState();
}

class _StoreLogOutState extends State<StoreLogOut> {
  String userName = "";
  String joinedOn = "";
  String kUid;
  Future getDetails() async {
    final FirebaseUser user = await auth.currentUser();
    final userid = user.uid;
    _firestore.collection('store_details').document(userid).get().then((value) {
      setState(() {
        kUid = userid;
        userName = value.data['store_name'];
        joinedOn = value.data['joinedon'];
      });
      print(value);
      print(userName);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.blueGrey,
              radius: 60,
              backgroundImage: AssetImage('images/person.png'),
            ),
            Text(
              userName,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
            ),
            Text("Joined On : $joinedOn"),
            // FloatingActionButton(onPressed: () {}),
            //
            SizedBox(
              height: 53,
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: new MaterialButton(
                onPressed: () {
                  auth.signOut();
                  Navigator.pushNamed(context, Loginpage.id);
                },
                height: 46,
                minWidth: 130,
                child: Text(
                  'Log out',
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
// For Store panel
//
//
// Logout
// class LogOut extends StatelessWidget {
//   String userName = "poda";
//   String joinedOn;
//   // ignore: missing_return
//   Future getDetails() async {
//     final FirebaseUser user = await auth.currentUser();
//     final userid = user.uid;
//     _firestore.collection('user_details').document(userid).get().then((value) {
//       userName = value.data['name'];
//       print(userName);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return Center(
//     //   child: Container(
//     //     height: MediaQuery.of(context).size.height,
//     //     width: MediaQuery.of(context).size.width,
//     //     child: Column(
//     //       // crossAxisAlignment: CrossAxisAlignment.center,
//     //       mainAxisAlignment: MainAxisAlignment.center,
//     //       children: <Widget>[

//     //         CircleAvatar(
//     //           backgroundColor: Colors.green,
//     //           radius: 60,
//     //           backgroundImage: AssetImage('images/person.png'),
//     //         ),
//     //         Text("Logout Page\n"),
//     //       ],
//     //     ),
//     //   ),
//     // );
//   }
// }

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
// Future _showAlert(BuildContext context, String message,String action) async {
//     return showDialog(
//         context: context,
//         child: new AlertDialog(
//           shape:
//               RoundedRectangleBorder(borderRadius: BorderRadius.circular(19)),
//           title: new Text(message),
//           actions: <Widget>[
//             new FlatButton(
//                 onPressed: () => Navigator.pop(context), child: new Text(action))
//           ],
//         ));
class ShowQRCode extends StatefulWidget {
  final auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  @override
  _ShowQRCodeState createState() => _ShowQRCodeState();
}

class _ShowQRCodeState extends State<ShowQRCode> {
  String userName = "";
  String storeloc = "";
  String kUid = "";
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

  _save() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    } else {
      final directory = (await getApplicationDocumentsDirectory())
          .path; //from path_provide package
      String fileName = "storeQRcode";
      String path = '/storage/emulated/0/Downloads/';

      screenshotController.captureAndSave(
          path, //set path where screenshot will be saved
          fileName: fileName);
    }
  }

  Future getDetails() async {
    final FirebaseUser user = await auth.currentUser();
    final userid = user.uid;
    _firestore.collection('store_details').document(userid).get().then((value) {
      setState(() {
        kUid = userid;
        userName = value.data['store_name'];
        storeloc = value.data['store_loc'];
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails();
  }

  int _counter = 0;
  Uint8List _imageFile;
  ScreenshotController screenshotController = ScreenshotController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            // Text(
            //   "Your QR",
            //   textAlign: TextAlign.left,
            //   style: TextStyle(
            //     fontSize: 35,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            Screenshot(
              controller: screenshotController,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Card(
                  elevation: 9,
                  child: Container(
                    color: Colors.white70,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "Break the chain",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(85.0),
                          child: QrImage(
                            data: kUid,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Day_Track",
                            style: TextStyle(
                              fontSize: 23,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Text(
                          "Scan the above QR and enter your details",
                          style: TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Happy shopping with $userName",
                          style: TextStyle(
                              fontSize: 10, fontWeight: FontWeight.w300),
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(28.0),
              child: new MaterialButton(
                onPressed: () {
                  try {
                    screenshotController
                        .capture()
                        .then((Uint8List image) async {
                      setState(() {
                        _imageFile = image;
                      });
                      final result =
                          await ImageGallerySaver.saveImage(image, quality: 90);
                      // print("captured");
                      // print(result);
                      _save();
                    }).catchError((onError) {
                      print(onError);
                    });
                    _showAlert(
                        context,
                        "File saved on your Gallery,take a print out of that and paste that at your entrance",
                        "Ok");
                  } catch (e) {
                    _showAlert(context, "An error occured ", "Try again");
                  }

                  // auth.signOut();
                  // Navigator.pushNamed(context, Loginpage.id);
                },
                height: 46,
                minWidth: 130,
                child: Text(
                  'Download QR',
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
