// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) => _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() => _$AppDatabaseBuilder(null);
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
    final path = name != null ? await sqfliteDatabaseFactory.getDatabasePath(name!) : ':memory:';
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

  NewsFeedDao? _newsFeedDAOInstance;

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
        await MigrationAdapter.runMigrations(database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `news` (`id` TEXT, `title` TEXT, `description` TEXT, `url` TEXT, `author` TEXT, `image` TEXT, `category` TEXT, `published` TEXT, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  NewsFeedDao get newsFeedDAO {
    return _newsFeedDAOInstance ??= _$NewsFeedDao(database, changeListener);
  }
}

class _$NewsFeedDao extends NewsFeedDao {
  _$NewsFeedDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _newsFeedModelInsertionAdapter = InsertionAdapter(
            database,
            'news',
            (NewsFeedModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'url': item.url,
                  'author': item.author,
                  'image': item.image,
                  'category': _stringListConverter.encode(item.category),
                  'published': item.published
                }),
        _newsFeedModelDeletionAdapter = DeletionAdapter(
            database,
            'news',
            ['id'],
            (NewsFeedModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'url': item.url,
                  'author': item.author,
                  'image': item.image,
                  'category': _stringListConverter.encode(item.category),
                  'published': item.published
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<NewsFeedModel> _newsFeedModelInsertionAdapter;

  final DeletionAdapter<NewsFeedModel> _newsFeedModelDeletionAdapter;

  @override
  Future<List<NewsFeedModel>> getNewsFeed() async {
    return _queryAdapter.queryList('SELECT * FROM news',
        mapper: (Map<String, Object?> row) => NewsFeedModel(
            id: row['id'] as String?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            url: row['url'] as String?,
            author: row['author'] as String?,
            image: row['image'] as String?,
            category: _stringListConverter.decode(row['category'] as String),
            published: row['published'] as String?));
  }

  @override
  Future<void> insertNewsFeed(NewsFeedModel newsFeed) async {
    await _newsFeedModelInsertionAdapter.insert(newsFeed, OnConflictStrategy.replace);
  }

  @override
  Future<void> deleteNewsFeed(NewsFeedModel newsFeedModel) async {
    await _newsFeedModelDeletionAdapter.delete(newsFeedModel);
  }
}

// ignore_for_file: unused_element
final _stringListConverter = StringListConverter();
