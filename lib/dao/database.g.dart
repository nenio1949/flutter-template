// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  UserDao? _userDaoInstance;

  RoleDao? _roleDaoInstance;

  DepartmentDao? _departmentDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `User` (`name` TEXT NOT NULL, `avatar` TEXT, `gender` INTEGER, `account` TEXT NOT NULL, `password` TEXT NOT NULL, `mobile` TEXT NOT NULL, `email` TEXT, `departmentId` INTEGER, `roleId` INTEGER, `id` INTEGER, `creatorId` INTEGER, `modifierId` INTEGER, `createdAt` TEXT, `updatedAt` TEXT, `deleted` INTEGER, FOREIGN KEY (`departmentId`) REFERENCES `Department` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`roleId`) REFERENCES `Role` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Role` (`name` TEXT NOT NULL, `permissions` TEXT, `id` INTEGER, `creatorId` INTEGER, `modifierId` INTEGER, `createdAt` TEXT, `updatedAt` TEXT, `deleted` INTEGER, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Department` (`name` TEXT NOT NULL, `parentId` INTEGER, `leaderId` INTEGER, `id` INTEGER, `creatorId` INTEGER, `modifierId` INTEGER, `createdAt` TEXT, `updatedAt` TEXT, `deleted` INTEGER, FOREIGN KEY (`parentId`) REFERENCES `Department` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`leaderId`) REFERENCES `User` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE INDEX `index_User_name_account_mobile` ON `User` (`name`, `account`, `mobile`)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  RoleDao get roleDao {
    return _roleDaoInstance ??= _$RoleDao(database, changeListener);
  }

  @override
  DepartmentDao get departmentDao {
    return _departmentDaoInstance ??= _$DepartmentDao(database, changeListener);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'User',
            (User item) => <String, Object?>{
                  'name': item.name,
                  'avatar': item.avatar,
                  'gender': item.gender?.index,
                  'account': item.account,
                  'password': item.password,
                  'mobile': item.mobile,
                  'email': item.email,
                  'departmentId': item.departmentId,
                  'roleId': item.roleId,
                  'id': item.id,
                  'creatorId': item.creatorId,
                  'modifierId': item.modifierId,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'deleted':
                      item.deleted == null ? null : (item.deleted! ? 1 : 0)
                }),
        _userUpdateAdapter = UpdateAdapter(
            database,
            'User',
            ['id'],
            (User item) => <String, Object?>{
                  'name': item.name,
                  'avatar': item.avatar,
                  'gender': item.gender?.index,
                  'account': item.account,
                  'password': item.password,
                  'mobile': item.mobile,
                  'email': item.email,
                  'departmentId': item.departmentId,
                  'roleId': item.roleId,
                  'id': item.id,
                  'creatorId': item.creatorId,
                  'modifierId': item.modifierId,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'deleted':
                      item.deleted == null ? null : (item.deleted! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  final UpdateAdapter<User> _userUpdateAdapter;

  @override
  Future<List<User>> findAllUsers() async {
    return _queryAdapter.queryList(
        'SELECT * FROM User WHERE deleted=0 ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => User(
            row['name'] as String,
            row['account'] as String,
            row['password'] as String,
            row['mobile'] as String,
            avatar: row['avatar'] as String?,
            gender: row['gender'] == null
                ? null
                : GenderEnum.values[row['gender'] as int],
            email: row['email'] as String?,
            departmentId: row['departmentId'] as int?,
            roleId: row['roleId'] as int?,
            id: row['id'] as int?,
            creatorId: row['creatorId'] as int?,
            modifierId: row['modifierId'] as int?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?,
            deleted:
                row['deleted'] == null ? null : (row['deleted'] as int) != 0));
  }

  @override
  Future<List<User>> findPageUsers(
    int page,
    int size,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM User  ORDER BY id DESC LIMIT ?2 OFFSET ?2*(?1 - 1)',
        mapper: (Map<String, Object?> row) => User(
            row['name'] as String,
            row['account'] as String,
            row['password'] as String,
            row['mobile'] as String,
            avatar: row['avatar'] as String?,
            gender: row['gender'] == null
                ? null
                : GenderEnum.values[row['gender'] as int],
            email: row['email'] as String?,
            departmentId: row['departmentId'] as int?,
            roleId: row['roleId'] as int?,
            id: row['id'] as int?,
            creatorId: row['creatorId'] as int?,
            modifierId: row['modifierId'] as int?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?,
            deleted:
                row['deleted'] == null ? null : (row['deleted'] as int) != 0),
        arguments: [page, size]);
  }

  @override
  Future<User?> findUserById(int id) async {
    return _queryAdapter.query('SELECT * FROM User WHERE id = ?1',
        mapper: (Map<String, Object?> row) => User(
            row['name'] as String,
            row['account'] as String,
            row['password'] as String,
            row['mobile'] as String,
            avatar: row['avatar'] as String?,
            gender: row['gender'] == null
                ? null
                : GenderEnum.values[row['gender'] as int],
            email: row['email'] as String?,
            departmentId: row['departmentId'] as int?,
            roleId: row['roleId'] as int?,
            id: row['id'] as int?,
            creatorId: row['creatorId'] as int?,
            modifierId: row['modifierId'] as int?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?,
            deleted:
                row['deleted'] == null ? null : (row['deleted'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> deleteUsers(List<int> ids) async {
    const offset = 1;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    await _queryAdapter.queryNoReturn(
        'UPDATE User SET deleted=1 WHERE id IN (' +
            _sqliteVariablesForIds +
            ')',
        arguments: [...ids]);
  }

  @override
  Future<int> insertUser(User user) {
    return _userInsertionAdapter.insertAndReturnId(
        user, OnConflictStrategy.abort);
  }

  @override
  Future<int> insertItem(User item) {
    return _userInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateUser(User user) {
    return _userUpdateAdapter.updateAndReturnChangedRows(
        user, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(User item) {
    return _userUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }
}

class _$RoleDao extends RoleDao {
  _$RoleDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _roleInsertionAdapter = InsertionAdapter(
            database,
            'Role',
            (Role item) => <String, Object?>{
                  'name': item.name,
                  'permissions': item.permissions,
                  'id': item.id,
                  'creatorId': item.creatorId,
                  'modifierId': item.modifierId,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'deleted':
                      item.deleted == null ? null : (item.deleted! ? 1 : 0)
                }),
        _roleUpdateAdapter = UpdateAdapter(
            database,
            'Role',
            ['id'],
            (Role item) => <String, Object?>{
                  'name': item.name,
                  'permissions': item.permissions,
                  'id': item.id,
                  'creatorId': item.creatorId,
                  'modifierId': item.modifierId,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'deleted':
                      item.deleted == null ? null : (item.deleted! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Role> _roleInsertionAdapter;

  final UpdateAdapter<Role> _roleUpdateAdapter;

  @override
  Future<List<Role>> findAllRoles() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Role WHERE deleted=0 ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => Role(row['name'] as String,
            permissions: row['permissions'] as String?,
            id: row['id'] as int?,
            creatorId: row['creatorId'] as int?,
            modifierId: row['modifierId'] as int?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?,
            deleted:
                row['deleted'] == null ? null : (row['deleted'] as int) != 0));
  }

  @override
  Future<List<Role>> findPageRoles(
    int page,
    int size,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Role  ORDER BY id DESC LIMIT ?2 OFFSET ?2*(?1 - 1)',
        mapper: (Map<String, Object?> row) => Role(row['name'] as String,
            permissions: row['permissions'] as String?,
            id: row['id'] as int?,
            creatorId: row['creatorId'] as int?,
            modifierId: row['modifierId'] as int?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?,
            deleted:
                row['deleted'] == null ? null : (row['deleted'] as int) != 0),
        arguments: [page, size]);
  }

  @override
  Future<Role?> findRoleById(int id) async {
    return _queryAdapter.query('SELECT * FROM Role WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Role(row['name'] as String,
            permissions: row['permissions'] as String?,
            id: row['id'] as int?,
            creatorId: row['creatorId'] as int?,
            modifierId: row['modifierId'] as int?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?,
            deleted:
                row['deleted'] == null ? null : (row['deleted'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> deleteRoles(List<int> ids) async {
    const offset = 1;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    await _queryAdapter.queryNoReturn(
        'UPDATE Role SET deleted=1 WHERE id IN (' +
            _sqliteVariablesForIds +
            ')',
        arguments: [...ids]);
  }

  @override
  Future<int> insertRole(Role role) {
    return _roleInsertionAdapter.insertAndReturnId(
        role, OnConflictStrategy.abort);
  }

  @override
  Future<int> insertItem(Role item) {
    return _roleInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateRole(Role role) {
    return _roleUpdateAdapter.updateAndReturnChangedRows(
        role, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(Role item) {
    return _roleUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }
}

class _$DepartmentDao extends DepartmentDao {
  _$DepartmentDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _departmentInsertionAdapter = InsertionAdapter(
            database,
            'Department',
            (Department item) => <String, Object?>{
                  'name': item.name,
                  'parentId': item.parentId,
                  'leaderId': item.leaderId,
                  'id': item.id,
                  'creatorId': item.creatorId,
                  'modifierId': item.modifierId,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'deleted':
                      item.deleted == null ? null : (item.deleted! ? 1 : 0)
                }),
        _departmentUpdateAdapter = UpdateAdapter(
            database,
            'Department',
            ['id'],
            (Department item) => <String, Object?>{
                  'name': item.name,
                  'parentId': item.parentId,
                  'leaderId': item.leaderId,
                  'id': item.id,
                  'creatorId': item.creatorId,
                  'modifierId': item.modifierId,
                  'createdAt': item.createdAt,
                  'updatedAt': item.updatedAt,
                  'deleted':
                      item.deleted == null ? null : (item.deleted! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Department> _departmentInsertionAdapter;

  final UpdateAdapter<Department> _departmentUpdateAdapter;

  @override
  Future<List<Department>> findAllDepartments() async {
    return _queryAdapter.queryList(
        'SELECT * FROM Department WHERE deleted=0 ORDER BY id DESC',
        mapper: (Map<String, Object?> row) => Department(row['name'] as String,
            parentId: row['parentId'] as int?,
            leaderId: row['leaderId'] as int?,
            id: row['id'] as int?,
            creatorId: row['creatorId'] as int?,
            modifierId: row['modifierId'] as int?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?,
            deleted:
                row['deleted'] == null ? null : (row['deleted'] as int) != 0));
  }

  @override
  Future<List<Department>> findPageDepartments(
    int page,
    int size,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM Department  ORDER BY id DESC LIMIT ?2 OFFSET ?2*(?1 - 1)',
        mapper: (Map<String, Object?> row) => Department(row['name'] as String, parentId: row['parentId'] as int?, leaderId: row['leaderId'] as int?, id: row['id'] as int?, creatorId: row['creatorId'] as int?, modifierId: row['modifierId'] as int?, createdAt: row['createdAt'] as String?, updatedAt: row['updatedAt'] as String?, deleted: row['deleted'] == null ? null : (row['deleted'] as int) != 0),
        arguments: [page, size]);
  }

  @override
  Future<Department?> findDepartmentById(int id) async {
    return _queryAdapter.query('SELECT * FROM Department WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Department(row['name'] as String,
            parentId: row['parentId'] as int?,
            leaderId: row['leaderId'] as int?,
            id: row['id'] as int?,
            creatorId: row['creatorId'] as int?,
            modifierId: row['modifierId'] as int?,
            createdAt: row['createdAt'] as String?,
            updatedAt: row['updatedAt'] as String?,
            deleted:
                row['deleted'] == null ? null : (row['deleted'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> deleteDepartments(List<int> ids) async {
    const offset = 1;
    final _sqliteVariablesForIds =
        Iterable<String>.generate(ids.length, (i) => '?${i + offset}')
            .join(',');
    await _queryAdapter.queryNoReturn(
        'UPDATE Department SET deleted=1 WHERE id IN (' +
            _sqliteVariablesForIds +
            ')',
        arguments: [...ids]);
  }

  @override
  Future<int> insertDepartment(Department department) {
    return _departmentInsertionAdapter.insertAndReturnId(
        department, OnConflictStrategy.abort);
  }

  @override
  Future<int> insertItem(Department item) {
    return _departmentInsertionAdapter.insertAndReturnId(
        item, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateDepartment(Department department) {
    return _departmentUpdateAdapter.updateAndReturnChangedRows(
        department, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateItem(Department item) {
    return _departmentUpdateAdapter.updateAndReturnChangedRows(
        item, OnConflictStrategy.abort);
  }
}
