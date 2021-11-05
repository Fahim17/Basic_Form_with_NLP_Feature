// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:form_pdf_mail/pdfApi.dart';
// import 'package:form_pdf_mail/sending_mail.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';

// class FormScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _FormScreenState();
//   }
// }

// class _FormScreenState extends State<FormScreen> {
//   String _name;
//   String _email;
//   String _password;
//   String _url;
//   String _phoneNumber;
//   String _calories;
//   List<String> stringText = [''];
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   bool isInitialized = false;
//   int _ocrCamera = FlutterMobileVision.CAMERA_BACK;
//   @override
//   void initState() {
//     super.initState();
//     FlutterMobileVision.start().then((previewSizes) {
//       isInitialized = true;
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Future<Null> _startScan() async {
//     List<OcrText> texts = [];
//     try {
//       texts = await FlutterMobileVision.read(
//         camera: _ocrCamera,
//         waitTap: true,
//         multiple: true,
//         fps: 5.0,
//       );

//       for (OcrText text in texts) {
//         print("value of OCR: ${text.value}");
//       }
//       stringText = texts.map((e) => e.value).toList();
//     } on Exception {
//       texts.add(OcrText('Failed to recognize text'));
//     }
//     // setState(() {});
//   }

//   Widget _buildName() {
//     return Row(
//       children: [
//         TextFormField(
//           initialValue: _name ?? '',
//           decoration: InputDecoration(labelText: 'Name'),
//           maxLength: 20,
//           validator: (String value) {
//             if (value.isEmpty) {
//               return 'Name is Required';
//             }

//             return null;
//           },
//           onSaved: (String value) {
//             _name = value;
//           },
//         ),
        // DropdownButton(
        //   icon: const Icon(Icons.arrow_downward),
        //   iconSize: 24,
        //   onChanged: (val) {
        //     setState(() {
        //       _name = val;
        //     });
        //   },
        //   items: stringText.map(
        //     (val) {
        //       return DropdownMenuItem(
        //         value: val,
        //         child: Text(val),
        //       );
        //     },
        //   ).toList(),
        // ),
//       ],
//     );
//   }

//   Widget _buildEmail() {
//     return TextFormField(
//       initialValue: _email ?? '',
//       decoration: InputDecoration(labelText: 'Email'),
//       keyboardType: TextInputType.emailAddress,
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Email is Required';
//         }

//         if (!RegExp(
//                 r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
//             .hasMatch(value)) {
//           return 'Please enter a valid email Address';
//         }

//         return null;
//       },
//       onSaved: (String value) {
//         _email = value;
//       },
//     );
//   }

//   Widget _buildPassword() {
//     return TextFormField(
//       decoration: InputDecoration(labelText: 'Password'),
//       // keyboardType: TextInputType.visiblePassword,
//       obscureText: true,
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Password is Required';
//         }

//         return null;
//       },
//       onSaved: (String value) {
//         _password = value;
//       },
//     );
//   }

//   // Widget _builURL() {
//   //   return TextFormField(
//   //     decoration: InputDecoration(labelText: 'Url'),
//   //     keyboardType: TextInputType.url,
//   //     validator: (String value) {
//   //       if (value.isEmpty) {
//   //         return 'URL is Required';
//   //       }

//   //       return null;
//   //     },
//   //     onSaved: (String value) {
//   //       _url = value;
//   //     },
//   //   );
//   // }

//   Widget _buildPhoneNumber() {
//     return TextFormField(
//       initialValue: _phoneNumber ?? '',
//       decoration: InputDecoration(labelText: 'Phone number'),
//       keyboardType: TextInputType.phone,
//       validator: (String value) {
//         if (value.isEmpty) {
//           return 'Phone number is Required';
//         }

//         return null;
//       },
//       onSaved: (String value) {
//         _phoneNumber = value;
//       },
//     );
//   }

//   // Widget _buildCalories() {
//   //   return TextFormField(
//   //     decoration: InputDecoration(labelText: 'Calories'),
//   //     keyboardType: TextInputType.number,
//   //     validator: (String value) {
//   //       int calories = int.tryParse(value);

//   //       if (calories == null || calories <= 0) {
//   //         return 'Calories must be greater than 0';
//   //       }

//   //       return null;
//   //     },
//   //     onSaved: (String value) {
//   //       _calories = value;
//   //     },
//   //   );
//   // }
//   File file;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Form Demo")),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.all(24),
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 _buildName(),
//                 _buildEmail(),
//                 _buildPassword(),
//                 // _builURL(),
//                 _buildPhoneNumber(),
//                 // _buildCalories(),
//                 SizedBox(height: 100),
//                 Row(children: [
//                   Expanded(
//                     flex: 1,
//                     child: Padding(
//                       padding: EdgeInsets.all(10),
//                       child: ElevatedButton(
//                         child: Text(
//                           'Save PDF',
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                         onPressed: () async {
//                           if (!_formKey.currentState.validate()) {
//                             return;
//                           }

//                           _formKey.currentState.save();

//                           print("Name: $_name");
//                           print("Email: $_email");
//                           print("Phone Number: $_phoneNumber");
//                           print("Password: $_password");
//                           //Send to API

//                           file =
//                               await PdfApi.savePDf(_name, _email, _phoneNumber);

//                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                             content: const Text('Pdf Saved'),
//                           ));
//                         },
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     flex: 1,
//                     child: Padding(
//                       padding: EdgeInsets.all(10),
//                       child: ElevatedButton(
//                         onPressed: _startScan,
//                         child: Text(
//                           'OCR',
//                           style: TextStyle(color: Colors.white, fontSize: 16),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ]),

//                 ElevatedButton(
//                   child: Text(
//                     'Open PDF',
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                   onPressed: () async {
//                     // final dir = await getApplicationDocumentsDirectory();
//                     if (!_formKey.currentState.validate()) {
//                       return;
//                     }
//                     PdfApi.openFile(file);
//                   },
//                 ),

//                 ElevatedButton(
//                   child: Text(
//                     'Send Mail',
//                     style: TextStyle(color: Colors.white, fontSize: 16),
//                   ),
//                   onPressed: () async {
//                     if (!_formKey.currentState.validate()) {
//                       return;
//                     }
//                     mailApi.sendMail(file);
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
