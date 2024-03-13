import 'package:template_flutter_asp/app/interactor/models/user_model.dart';

sealed class UserState {
  const UserState();
}

class StartUserState extends UserState {
  const StartUserState();
}

class GettedUserState extends UserState {
  final List<UserModel> users;

  const GettedUserState(this.users);
}

class LoadingUserState extends UserState {
  const LoadingUserState();
}

class FailureUserState extends UserState {
  final String message;
  const FailureUserState(this.message);
}
