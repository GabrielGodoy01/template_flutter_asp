abstract class State {
  const State();
}

class InitialState extends State {}

class LoadingState extends State {}

class ErrorState extends State {
  final String errorMessage;

  const ErrorState({required this.errorMessage});
}

class SuccessState extends State {}
