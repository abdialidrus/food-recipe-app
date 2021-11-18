import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:food_recipe/core/error/failures.dart';
import 'package:food_recipe/core/usecase/usecase.dart';
import 'package:food_recipe/features/splash_screen/domain/entities/auth_status.dart';
import 'package:food_recipe/features/splash_screen/domain/usecases/get_user_auth_status.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final GetUserAuthStatus getUserAuthStatus;

  SplashScreenBloc({required this.getUserAuthStatus}) : super(Loading());

  @override
  Stream<SplashScreenState> mapEventToState(SplashScreenEvent event) async* {
    if (event is GetAuthStatusEvent) {
      yield Loading();
      final failureOrAuthStatus = await getUserAuthStatus(NoParams());
      yield* _eitherLoadedOrErrorState(failureOrAuthStatus!);
    }
  }

  Stream<SplashScreenState> _eitherLoadedOrErrorState(
    Either<Failure, AuthStatus> failureOrAuthStatus,
  ) async* {
    yield failureOrAuthStatus.fold(
      (failure) => const Error(message: 'error'),
      (authStatus) => Loaded(authStatus: authStatus),
    );
  }
}
