sealed class UserEditState {
  const UserEditState();
}

class StartEditUserState extends UserEditState {
  const StartEditUserState();
}

class SavedUserState extends UserEditState {
  const SavedUserState();
}

class LoadingEditUserState extends UserEditState {
  const LoadingEditUserState();
}

class FailureEditUserState extends UserEditState {
  final String message;
  const FailureEditUserState(this.message);
}
