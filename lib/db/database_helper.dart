import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:esikshya/models/network_models/request/student/student_details_request.dart';
import 'package:esikshya/models/network_models/response/children_details_response.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ?? await initDatabase();

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'childdetails.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    db.execute('''
    CREATE TABLE $tableName(
      ${ChildrenDetailsField.childId} INTEGER NOT NULL,
      ${ChildrenDetailsField.fullName} TEXT NOT NULL,
      ${ChildrenDetailsField.username}  TEXT NOT NULL,
      ${ChildrenDetailsField.gender}  TEXT NOT NULL,
      ${ChildrenDetailsField.dateOfBirth}  TEXT NOT NULL,
      ${ChildrenDetailsField.grade}  INTEGER NOT NULL,
      ${ChildrenDetailsField.school}  TEXT NOT NULL,
      ${ChildrenDetailsField.country}  TEXT NOT NULL,
      ${ChildrenDetailsField.state}  TEXT NOT NULL
    )
      ''');
  }

  Future<List<ChildrenDetailsResponse>> getChildDetails() async {
    Database db = await instance.database;
    var childDetails = await db.query('childdetails');
    List<ChildrenDetailsResponse> childDetailsList = childDetails.isNotEmpty
        ? childDetails.map((e) => ChildrenDetailsResponse.fromJson(e)).toList()
        : [];

    return childDetailsList;
  }

  Future addChildDetails(ChildrenDetailsResponse childrenDetails) async {
    Database db = await instance.database;
    return await db.insert('childdetails', childrenDetails.toJson());
  }

  Future updateChildDetails(ChildDetail childrenDetails, String id) async {
    Database db = await instance.database;

    return await db.update('childdetails', childrenDetails.toJson(),
        where: '${ChildrenDetailsField.childId}=?', whereArgs: [id]);
  }

  Future delete() async {
    Database db = await instance.database;
    db.delete('childdetails');
  }

  Future getChildDetailsById(String id) async {
    Database db = await instance.database;
    var childDetail = await db.query('childdetails',
        where: '${ChildrenDetailsField.childId}=?', whereArgs: [id]);

    return childDetail;
  }
}
