import 'package:asp/asp.dart';
import 'package:flutter/material.dart';
import 'package:template_flutter_asp/app/interactor/actions/user_actions.dart';
import 'package:template_flutter_asp/app/interactor/atoms/user_atom.dart';
import 'package:template_flutter_asp/app/interactor/models/user_model.dart';

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
        return AlertDialog(
          title: const Text('Edit Todo'),
          content: TextFormField(
            initialValue: model.name,
            onChanged: (value) {
              model = model.copyWith(name: value);
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                deleteUser(model.id);
                Navigator.pop(context);
              },
              child: const Text('Delete'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                updateUser(model);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return RxBuilder(
      builder: (context) {
        final users = userState.value;
        final isLoading = userLoading.value;
        final isOnError = userOnError.value;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Home Page'),
          ),
          body: isOnError
              ? Center(
                  child: ElevatedButton(
                    child: const Text('Refresh itens'),
                    onPressed: () {
                      fetchUsers();
                    },
                  ),
                )
              : isLoading
                  ? const LinearProgressIndicator()
                  : ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (_, index) {
                        final user = users[index];
                        return GestureDetector(
                          onLongPress: () {
                            editUserDialog(user);
                          },
                          child: ListTile(
                            leading: const Icon(Icons.person),
                            title: Text(users[index].name),
                            subtitle: Text('${users[index].id}'),
                            trailing: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {},
                            ),
                          ),
                        );
                      },
                    ),
        );
      },
    );
  }
}
