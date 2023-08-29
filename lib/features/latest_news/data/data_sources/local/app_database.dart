import 'dart:async';

import 'package:floor/floor.dart';
import 'package:news/features/latest_news/data/data_sources/local/converters/string_list_converter.dart';
import 'package:news/features/latest_news/data/data_sources/local/dao/news_feed_dao.dart';
import 'package:news/features/latest_news/data/models/news_feed_model.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(version: 1, entities: [NewsFeedModel])
abstract class AppDatabase extends FloorDatabase {
  NewsFeedDao get newsFeedDAO;
}
