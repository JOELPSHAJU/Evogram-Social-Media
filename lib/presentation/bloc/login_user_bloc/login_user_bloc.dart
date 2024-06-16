// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/models/login_user.dart';
import 'package:evogram/domain/repository/user_repo.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'login_user_event.dart';
part 'login_user_state.dart';

class LoginUserBloc extends Bloc<LoginUserEvent, LoginUserState> {
  LoginUserBloc() : super(LoginUserInitial()) {
    on<LoginUserEvent>((event, emit) {});
    on<LoginUserInitialFetchingEvent>(
      (LoginUserInitialFetchingEvent event,
          Emitter<LoginUserState> emit) async {
        emit(LoginUserLoadingState());
        final Response response = await LoginUserRepo.fetchloginuser();
        if (response.statusCode == 200) {
          print(response);
          final responsebody = jsonDecode(response.body);
          print(responsebody);
          final LoginUserModel user = LoginUserModel.fromJson(responsebody);
          return emit(LoginUserSucessState(users: user));
        } else {
          return emit(LoginUserErrorState());
        }
      },
    );
  }
}
