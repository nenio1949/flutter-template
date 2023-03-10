import 'package:floor/floor.dart';

@dao
abstract class BaseDao<T> {
  // @Query('SELECT * FROM :item WHERE deleted=0 ORDER BY id DESC')
  // Future<List<T>> findAllList(T item);
  //
  // @Query(
  //     'SELECT * FROM :item  ORDER BY id DESC LIMIT :size OFFSET :size*(:page - 1)')
  // Future<List<T>> findPageList(T item,int page, int size);
  //
  // @Query('SELECT * FROM :item WHERE id = :id')
  // Future<T?> findById(T item,int id);

  @insert
  Future<int> insertItem(T item);

  @update
  Future<int> updateItem(T item);
}
