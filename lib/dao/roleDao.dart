import 'package:floor/floor.dart';
import 'package:funenc_flutter_template/model/role.dart';

import 'baseDao.dart';

@dao
abstract class RoleDao extends BaseDao<Role> {
  @Query('SELECT * FROM Role WHERE deleted=0 ORDER BY id DESC')
  Future<List<Role>> findAllRoles();

  @Query(
      'SELECT * FROM Role  ORDER BY id DESC LIMIT :size OFFSET :size*(:page - 1)')
  Future<List<Role>> findPageRoles(int page, int size);

  @Query('SELECT * FROM Role WHERE id = :id')
  Future<Role?> findRoleById(int id);

  @insert
  Future<int> insertRole(Role role);

  @update
  Future<int> updateRole(Role role);

  @Query('UPDATE Role SET deleted=1 WHERE id IN (:ids)')
  Future<void> deleteRoles(List<int> ids);
}
