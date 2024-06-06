// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_database.dart';

// ignore_for_file: type=lint
class MovieHelper extends Table with TableInfo<MovieHelper, MovieHelperData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  MovieHelper(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _postPathMeta =
      const VerificationMeta('postPath');
  late final GeneratedColumn<String> postPath = GeneratedColumn<String>(
      'postPath', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _releaseDateMeta =
      const VerificationMeta('releaseDate');
  late final GeneratedColumn<String> releaseDate = GeneratedColumn<String>(
      'releaseDate', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  late final GeneratedColumn<String> rating = GeneratedColumn<String>(
      'rating', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  static const VerificationMeta _movieIDMeta =
      const VerificationMeta('movieID');
  late final GeneratedColumn<String> movieID = GeneratedColumn<String>(
      'movieID', aliasedName, true,
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, postPath, releaseDate, rating, movieID];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'movieHelper';
  @override
  VerificationContext validateIntegrity(Insertable<MovieHelperData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('postPath')) {
      context.handle(_postPathMeta,
          postPath.isAcceptableOrUnknown(data['postPath']!, _postPathMeta));
    }
    if (data.containsKey('releaseDate')) {
      context.handle(
          _releaseDateMeta,
          releaseDate.isAcceptableOrUnknown(
              data['releaseDate']!, _releaseDateMeta));
    }
    if (data.containsKey('rating')) {
      context.handle(_ratingMeta,
          rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta));
    }
    if (data.containsKey('movieID')) {
      context.handle(_movieIDMeta,
          movieID.isAcceptableOrUnknown(data['movieID']!, _movieIDMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MovieHelperData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MovieHelperData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title']),
      postPath: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}postPath']),
      releaseDate: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}releaseDate']),
      rating: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rating']),
      movieID: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}movieID']),
    );
  }

  @override
  MovieHelper createAlias(String alias) {
    return MovieHelper(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class MovieHelperData extends DataClass implements Insertable<MovieHelperData> {
  final int id;
  final String? title;
  final String? postPath;
  final String? releaseDate;
  final String? rating;
  final String? movieID;
  const MovieHelperData(
      {required this.id,
      this.title,
      this.postPath,
      this.releaseDate,
      this.rating,
      this.movieID});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String>(title);
    }
    if (!nullToAbsent || postPath != null) {
      map['postPath'] = Variable<String>(postPath);
    }
    if (!nullToAbsent || releaseDate != null) {
      map['releaseDate'] = Variable<String>(releaseDate);
    }
    if (!nullToAbsent || rating != null) {
      map['rating'] = Variable<String>(rating);
    }
    if (!nullToAbsent || movieID != null) {
      map['movieID'] = Variable<String>(movieID);
    }
    return map;
  }

  MovieHelperCompanion toCompanion(bool nullToAbsent) {
    return MovieHelperCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      postPath: postPath == null && nullToAbsent
          ? const Value.absent()
          : Value(postPath),
      releaseDate: releaseDate == null && nullToAbsent
          ? const Value.absent()
          : Value(releaseDate),
      rating:
          rating == null && nullToAbsent ? const Value.absent() : Value(rating),
      movieID: movieID == null && nullToAbsent
          ? const Value.absent()
          : Value(movieID),
    );
  }

  factory MovieHelperData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MovieHelperData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      postPath: serializer.fromJson<String?>(json['postPath']),
      releaseDate: serializer.fromJson<String?>(json['releaseDate']),
      rating: serializer.fromJson<String?>(json['rating']),
      movieID: serializer.fromJson<String?>(json['movieID']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'postPath': serializer.toJson<String?>(postPath),
      'releaseDate': serializer.toJson<String?>(releaseDate),
      'rating': serializer.toJson<String?>(rating),
      'movieID': serializer.toJson<String?>(movieID),
    };
  }

  MovieHelperData copyWith(
          {int? id,
          Value<String?> title = const Value.absent(),
          Value<String?> postPath = const Value.absent(),
          Value<String?> releaseDate = const Value.absent(),
          Value<String?> rating = const Value.absent(),
          Value<String?> movieID = const Value.absent()}) =>
      MovieHelperData(
        id: id ?? this.id,
        title: title.present ? title.value : this.title,
        postPath: postPath.present ? postPath.value : this.postPath,
        releaseDate: releaseDate.present ? releaseDate.value : this.releaseDate,
        rating: rating.present ? rating.value : this.rating,
        movieID: movieID.present ? movieID.value : this.movieID,
      );
  @override
  String toString() {
    return (StringBuffer('MovieHelperData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('postPath: $postPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('rating: $rating, ')
          ..write('movieID: $movieID')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, postPath, releaseDate, rating, movieID);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MovieHelperData &&
          other.id == this.id &&
          other.title == this.title &&
          other.postPath == this.postPath &&
          other.releaseDate == this.releaseDate &&
          other.rating == this.rating &&
          other.movieID == this.movieID);
}

class MovieHelperCompanion extends UpdateCompanion<MovieHelperData> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String?> postPath;
  final Value<String?> releaseDate;
  final Value<String?> rating;
  final Value<String?> movieID;
  const MovieHelperCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.postPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.rating = const Value.absent(),
    this.movieID = const Value.absent(),
  });
  MovieHelperCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.postPath = const Value.absent(),
    this.releaseDate = const Value.absent(),
    this.rating = const Value.absent(),
    this.movieID = const Value.absent(),
  });
  static Insertable<MovieHelperData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? postPath,
    Expression<String>? releaseDate,
    Expression<String>? rating,
    Expression<String>? movieID,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (postPath != null) 'postPath': postPath,
      if (releaseDate != null) 'releaseDate': releaseDate,
      if (rating != null) 'rating': rating,
      if (movieID != null) 'movieID': movieID,
    });
  }

  MovieHelperCompanion copyWith(
      {Value<int>? id,
      Value<String?>? title,
      Value<String?>? postPath,
      Value<String?>? releaseDate,
      Value<String?>? rating,
      Value<String?>? movieID}) {
    return MovieHelperCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      postPath: postPath ?? this.postPath,
      releaseDate: releaseDate ?? this.releaseDate,
      rating: rating ?? this.rating,
      movieID: movieID ?? this.movieID,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (postPath.present) {
      map['postPath'] = Variable<String>(postPath.value);
    }
    if (releaseDate.present) {
      map['releaseDate'] = Variable<String>(releaseDate.value);
    }
    if (rating.present) {
      map['rating'] = Variable<String>(rating.value);
    }
    if (movieID.present) {
      map['movieID'] = Variable<String>(movieID.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MovieHelperCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('postPath: $postPath, ')
          ..write('releaseDate: $releaseDate, ')
          ..write('rating: $rating, ')
          ..write('movieID: $movieID')
          ..write(')'))
        .toString();
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(e);
  _$MyDatabaseManager get managers => _$MyDatabaseManager(this);
  late final MovieHelper movieHelper = MovieHelper(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [movieHelper];
}

typedef $MovieHelperInsertCompanionBuilder = MovieHelperCompanion Function({
  Value<int> id,
  Value<String?> title,
  Value<String?> postPath,
  Value<String?> releaseDate,
  Value<String?> rating,
  Value<String?> movieID,
});
typedef $MovieHelperUpdateCompanionBuilder = MovieHelperCompanion Function({
  Value<int> id,
  Value<String?> title,
  Value<String?> postPath,
  Value<String?> releaseDate,
  Value<String?> rating,
  Value<String?> movieID,
});

class $MovieHelperTableManager extends RootTableManager<
    _$MyDatabase,
    MovieHelper,
    MovieHelperData,
    $MovieHelperFilterComposer,
    $MovieHelperOrderingComposer,
    $MovieHelperProcessedTableManager,
    $MovieHelperInsertCompanionBuilder,
    $MovieHelperUpdateCompanionBuilder> {
  $MovieHelperTableManager(_$MyDatabase db, MovieHelper table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer:
              $MovieHelperFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $MovieHelperOrderingComposer(ComposerState(db, table)),
          getChildManagerBuilder: (p) => $MovieHelperProcessedTableManager(p),
          getUpdateCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> postPath = const Value.absent(),
            Value<String?> releaseDate = const Value.absent(),
            Value<String?> rating = const Value.absent(),
            Value<String?> movieID = const Value.absent(),
          }) =>
              MovieHelperCompanion(
            id: id,
            title: title,
            postPath: postPath,
            releaseDate: releaseDate,
            rating: rating,
            movieID: movieID,
          ),
          getInsertCompanionBuilder: ({
            Value<int> id = const Value.absent(),
            Value<String?> title = const Value.absent(),
            Value<String?> postPath = const Value.absent(),
            Value<String?> releaseDate = const Value.absent(),
            Value<String?> rating = const Value.absent(),
            Value<String?> movieID = const Value.absent(),
          }) =>
              MovieHelperCompanion.insert(
            id: id,
            title: title,
            postPath: postPath,
            releaseDate: releaseDate,
            rating: rating,
            movieID: movieID,
          ),
        ));
}

class $MovieHelperProcessedTableManager extends ProcessedTableManager<
    _$MyDatabase,
    MovieHelper,
    MovieHelperData,
    $MovieHelperFilterComposer,
    $MovieHelperOrderingComposer,
    $MovieHelperProcessedTableManager,
    $MovieHelperInsertCompanionBuilder,
    $MovieHelperUpdateCompanionBuilder> {
  $MovieHelperProcessedTableManager(super.$state);
}

class $MovieHelperFilterComposer
    extends FilterComposer<_$MyDatabase, MovieHelper> {
  $MovieHelperFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get postPath => $state.composableBuilder(
      column: $state.table.postPath,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get releaseDate => $state.composableBuilder(
      column: $state.table.releaseDate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get rating => $state.composableBuilder(
      column: $state.table.rating,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get movieID => $state.composableBuilder(
      column: $state.table.movieID,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $MovieHelperOrderingComposer
    extends OrderingComposer<_$MyDatabase, MovieHelper> {
  $MovieHelperOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get title => $state.composableBuilder(
      column: $state.table.title,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get postPath => $state.composableBuilder(
      column: $state.table.postPath,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get releaseDate => $state.composableBuilder(
      column: $state.table.releaseDate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get rating => $state.composableBuilder(
      column: $state.table.rating,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get movieID => $state.composableBuilder(
      column: $state.table.movieID,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class _$MyDatabaseManager {
  final _$MyDatabase _db;
  _$MyDatabaseManager(this._db);
  $MovieHelperTableManager get movieHelper =>
      $MovieHelperTableManager(_db, _db.movieHelper);
}
