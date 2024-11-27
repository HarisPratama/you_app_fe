import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:you_app/models/auth_model.dart';
import 'package:you_app/services/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login({String email ='', String username = '', String password =''}) async {
    try {
      emit(AuthLoading());

      AuthLoginModel auth = await AuthService().login(email, username, password);
      emit(AuthSuccess(auth));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> register({String email ='', String username = '', String password =''}) async {
    try {
      emit(AuthLoading());

      AuthRegisterModel auth = await AuthService().register(email, username, password);
      emit(AuthSuccessRegister(auth));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> logout() async {
    try {      
      await AuthService().logout();
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
