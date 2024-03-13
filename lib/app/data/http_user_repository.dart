// import 'package:template_flutter_asp/app/interactor/models/user_model.dart';
// import 'package:template_flutter_asp/app/interactor/repositories/user_repository.dart';
// import 'package:template_flutter_asp/app/helpers/services/http_service.dart';

// class HttpUserRepository implements UserRepository {
//   final HttpService _httpService;

//   HttpUserRepository({required HttpService httpService})
//       : _httpService = httpService;

//   @override
//   Future<bool> delete(int id) async {
//     try {
//       var response = await _httpService.delete('/delete-user/$id');
//       if (response.statusCode == 200) {
//         return true;
//       }
//     } catch (e) {
      
//     }
//   }

//   @override
//   Future<List<UserModel>> getAll() {
//     // TODO: implement getAll
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserModel> insert(UserModel model) {
//     // TODO: implement insert
//     throw UnimplementedError();
//   }

//   @override
//   Future<UserModel> update(UserModel model) {
//     // TODO: implement update
//     throw UnimplementedError();
//   }
// }
