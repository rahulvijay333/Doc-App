part of 'on_boarding_bloc.dart';

@immutable
sealed class OnBoardingState {}

final class OnBoardingInitial extends OnBoardingState {}

class OnBoardingLoading extends OnBoardingState {}

class OnBordingSuccess extends OnBoardingState {}

class OnBordingFailure extends OnBoardingState {
  final String error;

  OnBordingFailure({required this.error});
}
