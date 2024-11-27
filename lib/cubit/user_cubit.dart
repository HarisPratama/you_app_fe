import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:you_app/models/user_model.dart';
import 'package:you_app/services/user_service.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  Future<void> getProfile() async {
    try {
      emit(UserLoading(action: 'getProfile'));

      UserModel user = await UserService().getProfile();
      emit(UserSuccess(user, action: 'getProfile'));
    } catch (e) {
      emit(UserFailed(e.toString(), action: 'getProfile'));
    }
  }

  Future<void> updateProfile(String name, String birthday, String height, String weight, List<String> interests) async {
    try {
      emit(UserLoading(action: 'updateProfile'));

      UserModel user = await UserService().updateProfile(name, birthday, height, weight, interests);
      emit(UserSuccess(user, action: 'updateProfile'));

      await getProfile();
    } catch (e) {
      emit(UserFailed(e.toString(), action: 'updateProfile'));
    }
  }
}
