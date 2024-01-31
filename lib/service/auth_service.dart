import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pto_code_test_wallet/database/database_provider.dart';
import 'package:pto_code_test_wallet/model/user.dart';

class AuthService{
  final CollectionReference _userCollectionReference = FirebaseFirestore.instance.collection("users");
  final dbClient = DatabaseProvider.databaseProvider;

  Future<String?> signInWithGoogle() async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
      await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      final firebaseAuth = FirebaseAuth.instance;
      await firebaseAuth.signInWithCredential(credential);
      if(firebaseAuth.currentUser != null){
        User user = firebaseAuth.currentUser!;
        return user.uid;
      }else{
        return "";
      }
    }catch(e){
      throw Exception(e.toString());
    }

  }

  Future<bool> saveUser() async{
    User user = FirebaseAuth.instance.currentUser!;
    var userData = {
      "uid" : user.uid,
      "name" : user.displayName,
      "email" : user.email,
      "imgUrl" : user.photoURL,
      "amount" : 10000,
    };
    final db = await dbClient.db;
    bool status = false;
    try{
      var data = _userCollectionReference.where("uid",isEqualTo: user.uid).get();
      data.then((value) {
        var onlineUser = value.docs;
        if(onlineUser.isEmpty){
          _userCollectionReference.add(userData).whenComplete(() {
            var result = db.insert('users', userData);
            result.then((value) {
              if(value == 1){
                status = true;
              }
            });
          });
        }else{
          var localUser = onlineUser.first.data() as Map<String,dynamic>;
          var result = db.insert('users', localUser);
          result.then((value) {
            if(value == 1){
              status = true;
            }
          });
        }
      });
    }catch(e){
      throw Exception(e.toString());
    }
    return status;
  }

  Future<UserModel?> getUserFromServer() async{
    String uid = FirebaseAuth.instance.currentUser!.uid;
    UserModel? user;
    var data = await _userCollectionReference.where("uid", isEqualTo: uid).get();
    var userData = data.docs.first.data() as Map<String,dynamic>;
    user = UserModel.fromJson(userData);
    return user;
  }

  Future<UserModel?> getUserFromLocal() async{
    final db = await dbClient.db;
    UserModel? user;
    var result = await db.query('users');
    if(result.isNotEmpty){
      result.map((e) {
        user = UserModel.fromJson(e);
      });
    }
    return user;
  }

  Future<void> signOut() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      throw Exception(e);
    }
  }

}