import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'forgetpassword_event.dart';
part 'forgetpassword_state.dart';

class ForgetpasswordBloc
    extends Bloc<ForgetpasswordEvent, ForgetpasswordState> {
  ForgetpasswordBloc() : super(ForgetpasswordInitial()) {
    on<ForgetpasswordEvent>((event, emit) {});
    on<ForgetPasswordButtonClicked>(
      (event, emit) {
        
      },
    );
  }
}
