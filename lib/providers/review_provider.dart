import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../locator.dart';


import '../services/crud_model.dart';

class ReviewsProvider with ChangeNotifier {
  CRUDModel _crudeModel = locator<CRUDModel>();
  ReviewsProvider() {
    _crudeModel.setpath('ratings');
  }

  Stream<QuerySnapshot> fetchAllReviewsAsStream() {
    return _crudeModel.streamAllDataCollection();
  }
}