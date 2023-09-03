// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// //import 'package:path_provider/path_provider.dart' as syspaths;
//
// class ImageInput extends StatefulWidget {
//   final Function onSelectImage;
//   ImageInput(this.onSelectImage);
//   @override
//   _ImageInputState createState() => _ImageInputState();
// }
//
// class _ImageInputState extends State<ImageInput> {
//   File _savedImage;
//   bool camera;
//
//   Future<void> _takePicture() async {
//     //final ImageFile = await ImagePicker.pickImage(source: );
//    // final picker = ImagePicker();
//
//     //wait for the user to make a decision first
//     await showDialog(
//       context: context,
//       builder: (_) => new AlertDialog(
//         title: Text(AppLocalizations.of(context).addpicture),
//         content: Text(AppLocalizations.of(context).fromcameraorgallery),
//         actions: <Widget>[
//           TextButton(
//             onPressed: () {
//               camera = true;
//               Navigator.of(context).pop();
//             },
//             child: Text(AppLocalizations.of(context).camera),
//           ),
//           TextButton(
//             onPressed: () async {
//               camera = false;
//               final XFile pickedFile =
//                   await ImagePicker().pickImage(source: ImageSource.camera);
//               _savedImage = (File(pickedFile.path));
//               final pickedImageFile = File(pickedFile.path);
//               setState(() {
//                 //_storedImage = ImageFile;   //old alternative
//                 _savedImage = pickedImageFile;
//               });
//
//               widget.onSelectImage(_savedImage);
//             },
//             child: Text(AppLocalizations.of(context).gallery),
//           ),
//         ],
//       ),
//     );
//
//     final XFile pickedFile = await ImagePicker().pickImage(
//       source: camera == true ? ImageSource.camera : ImageSource.gallery,
//       imageQuality: 50,
//       maxWidth: 600,
//     );
//     if (pickedFile == null) {
//       return;
//     }
//     final pickedImageFile = File(pickedFile.path);
//     setState(() {
//       //_storedImage = ImageFile;   //old alternative
//       _savedImage = pickedImageFile;
//     });
//
//     widget.onSelectImage(_savedImage);
//   }
//   File file;
//   bool pickImage = false;
//
//   // final ImagePicker _picker = ImagePicker();
//   // Future pickScooterImage() async {
//   //   final XFile pickedFile =
//   //   await ImagePicker().pickImage(source: ImageSource.camera);
//   //   file = (File(pickedFile.path));
//   //  // pickImage = true;
//   //   // emit(pickImageSuccess());
//   // }
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap:()async{
//
//         final XFile pickedFile =
//         await ImagePicker().pickImage(source: ImageSource.camera);
//         setState(() {
//           file = (File(pickedFile.path));
//         });
//
//       },
//       child: Center(
//         child: Row(
//           children: [
//             Card(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               elevation: 4,
//               color: Color(0xffd3d3d3),
//               margin: EdgeInsets.all(10),
//               child: Container(
//                 decoration: BoxDecoration(
//                     border: Border.all(
//                       width: 2,
//                       color: Colors.green,
//                     ),
//                     borderRadius: BorderRadius.circular(15)),
//                 // decoration: BoxDecoration(
//                 //   borderRadius: BorderRadius.circular(15),
//                 // ),
//                 width: MediaQuery.of(context).size.width * 0.4,
//                 height: MediaQuery.of(context).size.height * 0.2,
//                 child: file == null
//                     ? Center(child: Icon(Icons.add_a_photo))
//                     : ClipRRect(
//                         borderRadius: BorderRadius.circular(1),
//                         child: Image.file(
//                           file,
//                           fit: BoxFit.contain,
//                           width: double.infinity,
//                         ),
//                       ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
