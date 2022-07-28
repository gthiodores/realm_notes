// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

class User extends _User with RealmEntity, RealmObject {
  User(
    String id,
    String name, {
    String? imageUrl,
  }) {
    RealmObject.set(this, '_id', id);
    RealmObject.set(this, 'name', name);
    RealmObject.set(this, 'image_url', imageUrl);
  }

  User._();

  @override
  String get id => RealmObject.get<String>(this, '_id') as String;
  @override
  set id(String value) => throw RealmUnsupportedSetError();

  @override
  String get name => RealmObject.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObject.set(this, 'name', value);

  @override
  String? get imageUrl => RealmObject.get<String>(this, 'image_url') as String?;
  @override
  set imageUrl(String? value) => RealmObject.set(this, 'image_url', value);

  @override
  Stream<RealmObjectChanges<User>> get changes =>
      RealmObject.getChanges<User>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(User._);
    return const SchemaObject(User, 'User', [
      SchemaProperty('_id', RealmPropertyType.string,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('image_url', RealmPropertyType.string,
          mapTo: 'image_url', optional: true),
    ]);
  }
}

class Notes extends _Notes with RealmEntity, RealmObject, EquatableMixin {
  Notes(
    ObjectId id,
    String title,
    String content,
    String holder, {
    int? color,
  }) {
    RealmObject.set(this, '_id', id);
    RealmObject.set(this, 'title', title);
    RealmObject.set(this, 'content', content);
    RealmObject.set(this, 'color', color);
    RealmObject.set(this, 'holder', holder);
  }

  Notes._();

  @override
  ObjectId get id => RealmObject.get<ObjectId>(this, '_id') as ObjectId;
  @override
  set id(ObjectId value) => throw RealmUnsupportedSetError();

  @override
  String get title => RealmObject.get<String>(this, 'title') as String;
  @override
  set title(String value) => RealmObject.set(this, 'title', value);

  @override
  String get content => RealmObject.get<String>(this, 'content') as String;
  @override
  set content(String value) => RealmObject.set(this, 'content', value);

  @override
  int? get color => RealmObject.get<int>(this, 'color') as int?;
  @override
  set color(int? value) => RealmObject.set(this, 'color', value);

  @override
  String get holder => RealmObject.get<String>(this, 'holder') as String;
  @override
  set holder(String value) => RealmObject.set(this, 'holder', value);

  @override
  Stream<RealmObjectChanges<Notes>> get changes =>
      RealmObject.getChanges<Notes>(this);

  static SchemaObject get schema => _schema ??= _initSchema();
  static SchemaObject? _schema;
  static SchemaObject _initSchema() {
    RealmObject.registerFactory(Notes._);
    return const SchemaObject(Notes, 'Notes', [
      SchemaProperty('_id', RealmPropertyType.objectid,
          mapTo: '_id', primaryKey: true),
      SchemaProperty('title', RealmPropertyType.string),
      SchemaProperty('content', RealmPropertyType.string),
      SchemaProperty('color', RealmPropertyType.int, optional: true),
      SchemaProperty('holder', RealmPropertyType.string),
    ]);
  }

  @override
  List<Object?> get props => [id, title, content, holder, color];
}
