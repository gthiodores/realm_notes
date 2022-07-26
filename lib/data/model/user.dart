import 'package:realm/realm.dart';

part 'user.g.dart';

@RealmModel()
class _User {
  @PrimaryKey()
  @MapTo("_id")
  late String id;

  late String name;

  @MapTo("image_url")
  late String? imageUrl;
}

@RealmModel()
class _Notes {
  @PrimaryKey()
  @MapTo("_id")
  late ObjectId id;

  late String title;

  late String content;

  late int? color;

  late String holder;
}
