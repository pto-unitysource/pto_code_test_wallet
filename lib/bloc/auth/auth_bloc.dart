import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pto_code_test_wallet/model/user.dart';
import 'package:pto_code_test_wallet/repository/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {

    //google sign
    on<GoogleSignInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        String? uid = await authRepository.signInWithGoogle();
        if(uid != ""){
          var status = await authRepository.saveUser();
          if(status){
            emit(Authenticated());
          }else{
            emit(UnAuthenticated());
          }
        }else{
          emit(UnAuthenticated());
        }
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });

    //load user
    on<LoadUser>((event, emit) async{
      emit(UserLoading());
      try{
        UserModel? user = await authRepository.getUser(event.networkStatus);
        emit(UserLoaded(user!));
      }catch(e){
        emit(UserError(e.toString()));
      }

    });

    //sign out
    on<SignOutRequested>((event, emit) async {
      emit(AuthLoading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
  }
}
