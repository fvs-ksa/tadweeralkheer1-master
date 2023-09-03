import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tadweer_alkheer/locator.dart';
import 'package:tadweer_alkheer/models/issue.dart';
import 'package:tadweer_alkheer/providers/review_provider.dart';
import 'package:tadweer_alkheer/services/crud_model.dart';

class IssueProvider with ChangeNotifier{
  CRUDModel _crudModel=locator<CRUDModel>();
  IssueProvider(){
    _crudModel.setpath('issue');

  }
  Future<DocumentReference>addIssue(Issue data)async{
    var result=await _crudModel.addDocument(data.toJson());
    print('Issue Add: ${result.id}');
    return result;

  }
  Stream<QuerySnapshot> fetchAllIssueAsStream() {
    return _crudModel.streamAllDataCollection();
  }
  
}