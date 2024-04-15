import 'package:bloc/bloc.dart';
import 'package:job_portal/Features/Login/Bloc/Event/LoginEvent.dart';
import 'package:job_portal/Features/Login/Bloc/LoginRepository/LoginRespository.dart';
import 'package:job_portal/Features/Login/Bloc/State/LoginState.dart';
import 'package:job_portal/Features/Login/Model/LoginResponse.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;

  LoginBloc({required this.loginRepository})
      : super(const LoginState(status: LoginStatus.initial)) {
    on<GetOTP>(getOTPCode);
    on<SignIN>(signIn);
  }

  void signIn(SignIN event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(LoginStatus.signInLoading));
      LoginResponse session =
          await loginRepository.getLoginResponse(event.email, event.otp);
      if (session.success) {
        emit(state.copyWith(LoginStatus.otpSuccess));
      } else {
        emit(state.copyWithError(session.message, LoginStatus.otpFailure));
      }
    } catch (error) {
      emit(state.copyWithError(error.toString(), LoginStatus.otpFailure));
    }
  }

  void getOTPCode(GetOTP event, Emitter<LoginState> emit) async {
    try {
      emit(state.copyWith(LoginStatus.getCodeLoading));
      GetOTPResponse session =
          await loginRepository.getOTP(event.email, event.role);
      if (session.success) {
        emit(state.copyWith(LoginStatus.getCodeSuccess));
      } else {
        emit(state.copyWithError(session.message, LoginStatus.otpFailure));
      }
    } catch (error) {
      emit(state.copyWithError(error.toString(), LoginStatus.otpFailure));
    }
  }
}
