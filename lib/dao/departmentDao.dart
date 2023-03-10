import 'package:floor/floor.dart';
import 'package:funenc_flutter_template/model/department.dart';

import 'baseDao.dart';

@dao
abstract class DepartmentDao  extends BaseDao<Department>{
  @Query('SELECT * FROM Department WHERE deleted=0 ORDER BY id DESC')
  Future<List<Department>> findAllDepartments();

  @Query(
      'SELECT * FROM Department  ORDER BY id DESC LIMIT :size OFFSET :size*(:page - 1)')
  Future<List<Department>> findPageDepartments(int page, int size);

  @Query('SELECT * FROM Department WHERE id = :id')
  Future<Department?> findDepartmentById(int id);

  @insert
  Future<int> insertDepartment(Department department);

  @update
  Future<int> updateDepartment(Department department);

  @Query('UPDATE Department SET deleted=1 WHERE id IN (:ids)')
  Future<void> deleteDepartments(List<int> ids);
}
