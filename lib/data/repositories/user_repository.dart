import 'package:loggy/loggy.dart';
import '../../domain/repositories/iuserrepository.dart';
import '../datasources/local/user_local_datasource.dart';
import '../datasources/remote/user_remote_datasource.dart';
import '../../domain/entities/random_user.dart';

class UserRepository implements IUserRepository {
  late UserRemoteDatatasource remoteDataSource;
  late UserLocalDataSource localDataSource;

  UserRepository() {
    logInfo("Starting UserRepository");
    remoteDataSource = UserRemoteDatatasource();
    localDataSource = UserLocalDataSource();
  }

  @override
  Future<bool> getUser() async {
    logInfo("Getting user from remote");
    RandomUser user = await remoteDataSource.getUser();
    logInfo("Got user from remote");
    await localDataSource.addUser(user);
    return true;
  }

  @override
  Future<List<RandomUser>> getAllUsers() async {
    return await localDataSource.getAllUsers();
  }

  @override
  Future<void> deleteUser(id) async {
    await localDataSource.deleteUser(id);
  }

  @override
  Future<void> deleteAll() async {
    await localDataSource.deleteAll();
  }

  @override
  Future<void> updateUser(user) async {
    await localDataSource.updateUser(user);
  }
}
