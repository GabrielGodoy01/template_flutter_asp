import 'package:asp/asp.dart';
import 'package:template_flutter_asp/app/interactor/models/state_model.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';

final listUsersState = Atom<List<UserModel>>(List<UserModel>.empty());

final userState = Atom<State>(InitialState());
