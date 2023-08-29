import 'package:floor/floor.dart';
import 'package:news/features/latest_news/data/data_sources/local/converters/string_list_converter.dart';
import 'package:news/features/latest_news/domain/entities/news_feed_entity.dart';

@Entity(tableName: 'news', primaryKeys: ['id'])
@TypeConverters([StringListConverter])
class NewsFeedModel extends NewsFeedEntity {
  const NewsFeedModel(
      {String? id,
      String? title,
      String? description,
      String? url,
      String? author,
      String? image,
      List<String>? category,
      String? published})
      : super(
            id: id,
            title: title,
            description: description,
            url: url,
            author: author,
            image: image,
            category: category,
            published: published);

  factory NewsFeedModel.fromJson(Map<String, dynamic> map) => NewsFeedModel(
        id: map['id'] ?? "",
        title: map['title'] ?? "",
        description: map['description'] ?? "",
        url: map['url'] ?? "",
        author: map['author'] ?? "",
        image: map['image'] ?? "",
        category: map['category'].cast<String>() as List<String>?,
        published: map['published'] ?? "",
      );

  factory NewsFeedModel.fromEntity(NewsFeedEntity entity) => NewsFeedModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      url: entity.url,
      author: entity.author,
      image: entity.image,
      category: entity.category?.cast<String>().toList(),
      published: entity.published);
}
