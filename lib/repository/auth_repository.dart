import 'package:firebase_auth/firebase_auth.dart';
import 'package:pto_code_test_wallet/model/user.dart';
import 'package:pto_code_test_wallet/service/auth_service.dart';

class AuthRepository{
  final _authService = AuthService();

  Future<String?> signInWithGoogle() async{
    return _authService.signInWithGoogle();
  }

  Future<bool> saveUser() async{
    return _authService.saveUser();
  }

  Future<UserModel?> getUser(bool networkStatus) async{
    if(networkStatus){
      return _authService.getUserFromServer();
    }else{
      return _authService.getUserFromLocal();
    }
  }

  Future<void> signOut() async {
    _authService.signOut();
  }
}