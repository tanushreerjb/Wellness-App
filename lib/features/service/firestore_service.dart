import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';


class FireStoreService {
  // final String _generateUniqueID = Uuid().v4();

  Future<void> insertNewUserData({
    required String email,
    required String name,
    required String uuid,
}) async {
    try{
      await FirebaseFirestore.instance
          .collection(
        "users" //Collection or Table in database
        //CloudFireStoreConstant.userTable,
      )
      .doc(uuid)
      .set({
        'email': email,
        'name': name,
        'userRole': 'customer',
      });

    }catch(e){
      log("Failed to add new user data [insertNewUserData] : $e");
    }
  }
  /*Future<List<Map<String,dynamic>>> getUserData() async{
    try{
    }
  }*/
}
