import 'package:asp/asp.dart';
import 'package:template_flutter_asp/app/interactor/states/edit_user_state.dart';
import 'package:template_flutter_asp/app/interactor/states/user_state.dart';

final userState = Atom<UserState>(const StartUserState());
final editUserState = Atom<UserEditState>(const StartEditUserState());
