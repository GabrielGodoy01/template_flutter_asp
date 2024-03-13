import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter_asp/app/helpers/functions/global_snackbar.dart';
import 'package:template_flutter_asp/app/interactor/actions/user_actions.dart';
import 'package:template_flutter_asp/app/interactor/atoms/user_atom.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';
import 'package:template_flutter_asp/app/interactor/states/edit_user_state.dart';
import 'package:template_flutter_asp/app/interactor/states/user_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  void editUserDialog(UserModel model) {
    showDialog(
      context: context,
      builder: (context) {
        return RxBuilder(builder: (context) {
          final editState = editUserState.value;
          final enabled = editState is! LoadingEditUserState;
          return AlertDialog(
            title: const Text('Edit user'),
            content: TextFormField(
              enabled: enabled,
              initialValue: model.name,
              onChanged: (value) {
                model = model.copyWith(name: value);
              },
            ),
            actions: [
              TextButton(
                onPressed: enabled
                    ? () {
                        deleteUser(model.id);
                      }
                    : null,
                child: const Text('Delete'),
              ),
              TextButton(
                onPressed: enabled
                    ? () {
                        Navigator.pop(context);
                      }
                    : null,
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: enabled
                    ? () {
                        updateUser(model);
                      }
                    : null,
                child: enabled
                    ? const Text('Save')
                    : const CircularProgressIndicator(),
              ),
            ],
          );
        });
      },
    );
  }

  Widget _gettedUsers(GettedUserState state) {
    return ListView.builder(
      itemCount: state.users.length,
      itemBuilder: (_, index) {
        final user = state.users[index];
        return ListTile(
          leading: const Icon(Icons.person),
          title: Text(state.users[index].name),
          subtitle: Text('${state.users[index].id}'),
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              editUserDialog(user);
            },
          ),
        );
      },
    );
  }

  Widget _failureUserState(FailureUserState state) {
    return Center(
      child: ElevatedButton(
        child: const Text('Refresh itens'),
        onPressed: () {
          fetchUsers();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RxCallback(
      effects: [
        rxObserver(
          () => userState.value,
          effect: (value) {
            if (value is FailureUserState) {
              GlobalSnackBar.error(value.message);
            }
          },
        ),
        rxObserver(
          () => editUserState.value,
          effect: (value) {
            if (value is FailureEditUserState) {
              GlobalSnackBar.error(value.message);
            }
            if (value is SavedUserState) {
              Navigator.pop(context);
              GlobalSnackBar.success('User saved');
            }
          },
        ),
      ],
      child: RxBuilder(
        builder: (context) {
          final state = userState.value;

          return Scaffold(
            appBar: AppBar(
              title: const Text('Home Page'),
            ),
            body: switch (state) {
              StartUserState() => const SizedBox(),
              GettedUserState() => _gettedUsers(state),
              LoadingUserState() =>
                const Center(child: CircularProgressIndicator()),
              FailureUserState() => _failureUserState(state),
            },
          );
        },
      ),
    );
  }
}
