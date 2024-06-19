// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:evogram/domain/models/suggession_user_model.dart';
import 'package:evogram/domain/repository/user_repo.dart';
import 'package:http/http.dart';
import 'package:meta/meta.dart';

part 'fetch_suggession_user_event.dart';
part 'fetch_suggession_user_state.dart';

class FetchSuggessionUserBloc
    extends Bloc<FetchSuggessionUserEvent, FetchSuggessionUserState> {
  FetchSuggessionUserBloc() : super(FetchSuggessionUserInitial()) {
    on<FetchSuggessionUserEvent>((event, emit) {});
    on<SuggessionUserInitialFetchEvent>(suggessionUserInitialFetchEvent);
  }
  Future<void> suggessionUserInitialFetchEvent(
      SuggessionUserInitialFetchEvent event,
      Emitter<FetchSuggessionUserState> emit) async {
    emit(FetchSuggessionLoadingState());
    final Response? result = await LoginUserRepo.fetchSuggessionUser();

      if (result != null && result.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(result.body);

      // log(result.body);

        final SuggessionUserModel userSuggessionModel =
            SuggessionUserModel.fromJson(responseBody);
       // log(result.body);

        emit(FetchSuggessionSucessState(
            suggessionUserModel: userSuggessionModel));
      } else if (result != null && result.statusCode == 500) {
        emit(FetchSuggessionUserErrorState(error: 'server not responding'));
      } else {
        emit(FetchSuggessionUserInternalErrorState(error: 'something went wrong'));
      }
  }
}
