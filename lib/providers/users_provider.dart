import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../locator.dart';
import '../models/user.dart';

import '../services/crud_model.dart';

class UsersProvider with ChangeNotifier {
  CRUDModel _crudeModel = locator<CRUDModel>();

  List<Users> users;

  var firebaseUser;

  UsersProvider() {
    _crudeModel.setpath('users');
  }

  Future<Users> getUserById(String id) async {
    var doc = await _crudeModel.getDocumentById(id);
    return Users.fromMap(doc.data(), doc.id);
  }

  Future updateUser(Users data, String id) async {
    await _crudeModel.updateDocument(data.toJson(), id);
    print('object////////////////////////////////////////////////////');
    return;
  }

  Future addUser(Users data, String id) async {
    await _crudeModel.addDocumentWithId(data.toJson(), id);
    print('user added' + id);

    return;
  }

  File file;
  bool isPickedImage = false;

  Future pickImageGallery() async {
    final XFile pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    file = (File(pickedImage.path));
     isPickedImage = true;
    notifyListeners();
  }

  Future pickImageCamera() async {
    final XFile pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    file = (File(pickedImage.path));
    isPickedImage = true;
    notifyListeners();
  }
}
