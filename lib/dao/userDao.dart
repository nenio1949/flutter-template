import 'package:floor/floor.dart';
import 'package:funenc_flutter_template/dao/baseDao.dart';
import 'package:funenc_flutter_template/model/user.dart';

@dao
abstract class UserDao extends BaseDao<User> {
  @Query('SELECT * FROM User WHERE deleted=0 ORDER BY id DESC')
  Future<List<User>> findAllUsers();

  @Query(
      'SELECT * FROM User  ORDER BY id DESC LIMIT :size OFFSET :size*(:page - 1)')
  Future<List<User>> findPageUsers(int page, int size);

  @Query('SELECT * FROM User WHERE id = :id')
  Future<User?> findUserById(int id);

  @insert
  Future<int> insertUser(User user);

  @update
  Future<int> updateUser(User user);

  @Query('UPDATE User SET deleted=1 WHERE id IN (:ids)')
  Future<void> deleteUsers(List<int> ids);
}
